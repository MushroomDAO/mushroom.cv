// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Pausable} from "openzeppelin-contracts/contracts/utils/Pausable.sol";

/**
 * @title SaleContractV2
 * @author Mycelium Protocol
 * @notice Revenue-Based Milestone Sale for GToken — V2 with extensible milestones.
 *
 * Version: 2.0.0
 *   2 = MAJOR: dynamic milestone array (was fixed [6] in V1) +
 *              addMilestone / addMilestoneAutoStep owner functions for follow-on phases
 *   0 = MINOR
 *   0 = PATCH
 *
 * Key V2 changes vs V1:
 *   - Milestones stored in dynamic Milestone[] (not Milestone[6]).
 *   - Initial 6 milestones seeded at construction (matches V1 prices/caps).
 *   - Owner can append more milestones at any time via addMilestone() /
 *     addMilestoneAutoStep() — for the second sale phase ($200K → $850K-1M).
 *   - Inventory is topped up by simple GToken.transfer() to this contract
 *     (no special function — availableInventory = balanceOf(this)).
 *
 * Safety preserved from V1.2.1:
 *   - CEI ordering, ReentrancyGuard, Pausable.
 *   - 6-decimal payment-token enforcement.
 *   - Per-person purchase cap.
 *   - Slippage parameter (minTokensOut).
 *   - Auto-advance milestone after each buy (also publicly callable).
 *   - recoverToken() for treasury recovery.
 *
 * All USD amounts use 6 decimals (USDC/USDT precision). GToken uses 18 decimals.
 */
contract SaleContractV2 is Ownable, ReentrancyGuard, Pausable {

    // =============================================================
    //                         VERSION
    // =============================================================

    uint256 public constant VERSION = 20000; // 2.0.0

    function version() external pure returns (string memory) {
        return "2.0.0";
    }

    using SafeERC20 for IERC20;

    // =============================================================
    //                         ERRORS
    // =============================================================

    error ZeroAmount();
    error ZeroTokensOut();
    error TokenNotAccepted(address token);
    error InvalidTokenDecimals(address token, uint8 decimals);
    error SlippageExceeded(uint256 got, uint256 minExpected);
    error ExceedsPerPersonCap(uint256 requested, uint256 remaining);
    error InsufficientInventory(uint256 requested, uint256 available);
    error NotWhitelisted(address user);
    error MilestoneNotReached(uint256 currentRevenue, uint256 required);
    error AlreadyAtMaxMilestone();
    error ZeroAddress();

    // V2 errors
    error InvalidMilestonePrice(uint256 newPrice, uint256 lastPrice);
    error InvalidMilestoneCap(uint256 newCap, uint256 lastCap);
    error MilestoneIndexOOB(uint256 index, uint256 length);

    // =============================================================
    //                         CONSTANTS
    // =============================================================

    /// @notice Step in basis points for addMilestoneAutoStep (+12% = 1200 bps).
    uint16 public constant AUTO_STEP_BPS = 1200;
    uint16 internal constant BPS_DENOMINATOR = 10_000;

    // =============================================================
    //                         MILESTONE DATA
    // =============================================================

    struct Milestone {
        uint256 priceUSD;      // Price of 1 GToken in USD (6 decimals)
        uint256 revenueCap;    // Cumulative USD revenue required to reach this milestone (6 decimals)
    }

    /// @dev Dynamic milestone array. Index 0 is initial state (revenueCap = 0).
    Milestone[] private _milestones;

    // =============================================================
    //                           STATE
    // =============================================================

    IERC20 public immutable gToken;
    address public treasury;

    /// @notice Current milestone index — always < _milestones.length
    uint256 public currentMilestone;

    uint256 public totalRevenue;
    uint256 public totalTokensSold;

    mapping(address => uint256) public userTotalSpent;

    /// @notice Per-user cumulative cap, default $864 (6-decimal)
    uint256 public perPersonCapUSD = 864_000_000;

    bool public whitelistRequired;
    mapping(address => bool) public isWhitelisted;
    mapping(address => bool) public acceptedTokens;

    /// @notice Addresses exempt from perPersonCapUSD. Intended for the trusted
    /// BuyHelper, whose gasless purchases all aggregate under its own address
    /// (msg.sender) — without an exemption the shared counter would hit the
    /// per-person cap and brick gasless for everyone. Per-buyer limits for the
    /// gasless path are enforced at the relayer layer (rate limit + per-tx/day).
    mapping(address => bool) public capExempt;

    // =============================================================
    //                          EVENTS
    // =============================================================

    event TokensPurchased(
        address indexed buyer,
        address indexed paymentToken,
        uint256 usdAmount,
        uint256 gTokenAmount,
        uint256 priceUSD,
        uint256 milestone
    );
    event MilestoneAdvanced(uint256 indexed newMilestone, uint256 newPriceUSD);
    /// @notice V2 — emitted when owner appends a new milestone
    event MilestoneAdded(uint256 indexed index, uint256 priceUSD, uint256 revenueCap);
    event PaymentTokenSet(address indexed token, bool accepted);
    event TreasuryUpdated(address indexed newTreasury);
    event WhitelistRequiredUpdated(bool required);
    event WhitelistUpdated(address indexed user, bool status);
    event PerPersonCapUpdated(uint256 newCapUSD);
    /// @notice Emitted by buyTokensFor when the recipient differs from the payer
    /// (代购 / buy-into-AirAccount). Mirrors TokensPurchased + the actual recipient.
    event TokensPurchasedFor(
        address indexed buyer,
        address indexed recipient,
        address indexed paymentToken,
        uint256 usdAmount,
        uint256 gTokenAmount,
        uint256 priceUSD,
        uint256 milestone
    );
    event CapExemptUpdated(address indexed account, bool exempt);

    // =============================================================
    //                        CONSTRUCTOR
    // =============================================================

    /**
     * @param gTokenAddress Address of the GToken ERC20.
     * @param _treasury Treasury that receives payment proceeds + recoverToken.
     * @param _initialOwner Owner of this contract.
     */
    constructor(address gTokenAddress, address _treasury, address _initialOwner) Ownable(_initialOwner) {
        if (gTokenAddress == address(0)) revert ZeroAddress();
        if (_treasury == address(0)) revert ZeroAddress();

        gToken = IERC20(gTokenAddress);
        treasury = _treasury;

        // Seed identical 6 milestones as V1 to preserve the launch-phase narrative.
        _milestones.push(Milestone({priceUSD: 150_000,  revenueCap:           0})); // M0  $0.150
        _milestones.push(Milestone({priceUSD: 168_000,  revenueCap:   1_200_000_000})); // M1  $0.168 @ $1.2K
        _milestones.push(Milestone({priceUSD: 188_160,  revenueCap:   4_800_000_000})); // M2  $0.18816 @ $4.8K
        _milestones.push(Milestone({priceUSD: 210_739,  revenueCap:  12_800_000_000})); // M3  $0.210739 @ $12.8K
        _milestones.push(Milestone({priceUSD: 236_028,  revenueCap:  49_400_000_000})); // M4  $0.236028 @ $49.4K
        _milestones.push(Milestone({priceUSD: 264_351,  revenueCap: 135_800_000_000})); // M5  $0.264351 @ $135.8K
    }

    // =============================================================
    //                        VIEW FUNCTIONS
    // =============================================================

    function getCurrentPriceUSD() public view returns (uint256) {
        return _milestones[currentMilestone].priceUSD;
    }

    function getTokensForUSD(uint256 usdAmount) public view returns (uint256) {
        uint256 price = getCurrentPriceUSD();
        return (usdAmount * 1e18) / price;
    }

    function getMilestone(uint256 index) external view returns (uint256 priceUSD, uint256 revenueCap) {
        if (index >= _milestones.length) revert MilestoneIndexOOB(index, _milestones.length);
        Milestone memory m = _milestones[index];
        return (m.priceUSD, m.revenueCap);
    }

    /// @notice V2 — total number of milestones currently defined.
    function getMilestoneCount() external view returns (uint256) {
        return _milestones.length;
    }

    /// @notice V2 — return the entire milestone schedule for transparency.
    function getAllMilestones() external view returns (Milestone[] memory) {
        return _milestones;
    }

    function availableInventory() public view returns (uint256) {
        return gToken.balanceOf(address(this));
    }

    // =============================================================
    //                       PURCHASE LOGIC
    // =============================================================

    /**
     * @notice Purchase GTokens by paying with an accepted stablecoin.
     * @dev Tokens are credited to msg.sender. Thin wrapper over `_buyTokensFor`.
     */
    function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)
        external
        nonReentrant
        whenNotPaused
    {
        _buyTokensFor(msg.sender, usdAmount, paymentToken, minTokensOut);
    }

    /**
     * @notice Same as `buyTokens`, but credits the purchased GToken to `to`
     *         instead of msg.sender. Payment is still pulled from msg.sender,
     *         and the per-person cap + whitelist still apply to msg.sender (payer).
     * @dev Added for SDK self-pay "buy into AirAccount" — recipient ≠ payer
     *      (aastar-sdk#145 gap 2; e.g. pay with USDT from MetaMask EOA, credit
     *      aPNTs/GToken to the user's AirAccount). The gasless path already
     *      supports recipient via BuyHelper; this covers non-EIP-3009 self-pay.
     * @param to Recipient of the purchased GToken (must be non-zero).
     * @return gTokenAmount Amount of GToken credited to `to`.
     */
    function buyTokensFor(address to, uint256 usdAmount, address paymentToken, uint256 minTokensOut)
        external
        nonReentrant
        whenNotPaused
        returns (uint256)
    {
        return _buyTokensFor(to, usdAmount, paymentToken, minTokensOut);
    }

    /**
     * @dev Core purchase logic. Payer is always msg.sender; recipient is `to`.
     *      Not re-entrancy guarded itself — only reachable via the guarded
     *      `buyTokens` / `buyTokensFor` externals.
     */
    function _buyTokensFor(address to, uint256 usdAmount, address paymentToken, uint256 minTokensOut)
        internal
        returns (uint256 gTokenAmount)
    {
        if (to == address(0) || to == address(this)) revert ZeroAddress();
        if (whitelistRequired && !isWhitelisted[msg.sender]) {
            revert NotWhitelisted(msg.sender);
        }
        if (usdAmount == 0) revert ZeroAmount();
        if (!acceptedTokens[paymentToken]) revert TokenNotAccepted(paymentToken);

        uint256 spent = userTotalSpent[msg.sender];
        // capExempt addresses (the trusted BuyHelper) skip the per-person cap.
        if (!capExempt[msg.sender] && spent + usdAmount > perPersonCapUSD) {
            // Guard against underflow: an address could have been exempt (spent
            // may exceed cap) and later re-included via setCapExempt(false).
            uint256 remaining = perPersonCapUSD > spent ? perPersonCapUSD - spent : 0;
            revert ExceedsPerPersonCap(usdAmount, remaining);
        }

        gTokenAmount = getTokensForUSD(usdAmount);
        if (gTokenAmount == 0) revert ZeroTokensOut();

        if (minTokensOut > 0 && gTokenAmount < minTokensOut) {
            revert SlippageExceeded(gTokenAmount, minTokensOut);
        }

        uint256 inventory = availableInventory();
        if (gTokenAmount > inventory) revert InsufficientInventory(gTokenAmount, inventory);

        // Capture price/milestone the buyer paid (before auto-advance for the next one).
        uint256 pricePaid = getCurrentPriceUSD();
        uint256 milestonePaid = currentMilestone;

        // CEI: state update before externals.
        totalRevenue += usdAmount;
        totalTokensSold += gTokenAmount;
        userTotalSpent[msg.sender] = spent + usdAmount;

        _advanceIfNeeded();

        IERC20(paymentToken).safeTransferFrom(msg.sender, treasury, usdAmount);
        gToken.safeTransfer(to, gTokenAmount);

        emit TokensPurchased(
            msg.sender,
            paymentToken,
            usdAmount,
            gTokenAmount,
            pricePaid,
            milestonePaid
        );
        // Record the actual recipient when it differs from the payer (代购/AirAccount),
        // so indexers credit the buy to the recipient and not just the payer.
        if (to != msg.sender) {
            emit TokensPurchasedFor(
                msg.sender,
                to,
                paymentToken,
                usdAmount,
                gTokenAmount,
                pricePaid,
                milestonePaid
            );
        }
    }

    // =============================================================
    //                    MILESTONE ADVANCEMENT
    // =============================================================

    /**
     * @notice Advance the current milestone forward as many steps as totalRevenue allows.
     * @dev V2: bound is _milestones.length - 1 (was hardcoded 5 in V1).
     */
    function _advanceIfNeeded() internal {
        uint256 maxIdx = _milestones.length - 1;
        while (currentMilestone < maxIdx) {
            uint256 next = currentMilestone + 1;
            if (totalRevenue < _milestones[next].revenueCap) break;
            currentMilestone = next;
            emit MilestoneAdvanced(next, _milestones[next].priceUSD);
        }
    }

    function tryAdvanceMilestone() external {
        _advanceIfNeeded();
    }

    /**
     * @notice Owner-only: advance to next milestone if revenue cap reached.
     * @dev V2: cap is _milestones.length - 1.
     */
    function advanceMilestone() external onlyOwner {
        uint256 maxIdx = _milestones.length - 1;
        if (currentMilestone >= maxIdx) revert AlreadyAtMaxMilestone();

        uint256 nextMilestone = currentMilestone + 1;
        uint256 required = _milestones[nextMilestone].revenueCap;

        if (totalRevenue < required) {
            revert MilestoneNotReached(totalRevenue, required);
        }

        currentMilestone = nextMilestone;
        emit MilestoneAdvanced(nextMilestone, _milestones[nextMilestone].priceUSD);
    }

    // =============================================================
    //                  V2: EXTEND MILESTONES
    // =============================================================

    /**
     * @notice Append a new milestone at the end. Owner-only.
     * @dev `priceUSD` MUST be strictly greater than the previous milestone's price.
     *      `revenueCap` MUST be strictly greater than the previous milestone's cap.
     *      Cannot insert in the middle — only append. This preserves auto-advance ordering.
     * @param priceUSD New price (6 decimals).
     * @param revenueCap Cumulative USD revenue (6 decimals) required to reach this milestone.
     */
    function addMilestone(uint256 priceUSD, uint256 revenueCap) external onlyOwner {
        Milestone memory last = _milestones[_milestones.length - 1];
        if (priceUSD <= last.priceUSD) revert InvalidMilestonePrice(priceUSD, last.priceUSD);
        if (revenueCap <= last.revenueCap) revert InvalidMilestoneCap(revenueCap, last.revenueCap);

        _milestones.push(Milestone({priceUSD: priceUSD, revenueCap: revenueCap}));
        emit MilestoneAdded(_milestones.length - 1, priceUSD, revenueCap);
        // If revenue already meets the new cap, advance now so the next buy doesn't
        // transact at the stale (lower) price.
        _advanceIfNeeded();
    }

    /**
     * @notice Append a milestone with price = lastPrice * (1 + AUTO_STEP_BPS / 10_000) (= +12%).
     * @dev Convenience wrapper around addMilestone for the user's "auto +12% step" rule.
     *      `revenueCap` still must be strictly greater than the previous cap.
     * @param revenueCap Cumulative USD revenue (6 decimals) for this new milestone.
     */
    function addMilestoneAutoStep(uint256 revenueCap) external onlyOwner {
        Milestone memory last = _milestones[_milestones.length - 1];
        if (revenueCap <= last.revenueCap) revert InvalidMilestoneCap(revenueCap, last.revenueCap);

        // priceUSD = last.priceUSD * (10_000 + AUTO_STEP_BPS) / 10_000
        uint256 newPrice = (last.priceUSD * (BPS_DENOMINATOR + AUTO_STEP_BPS)) / BPS_DENOMINATOR;
        // Sanity: with AUTO_STEP_BPS > 0, newPrice > last.priceUSD always.

        _milestones.push(Milestone({priceUSD: newPrice, revenueCap: revenueCap}));
        emit MilestoneAdded(_milestones.length - 1, newPrice, revenueCap);
        _advanceIfNeeded();
    }

    // =============================================================
    //                       ADMIN FUNCTIONS
    // =============================================================

    function setPaymentToken(address token, bool accepted) external onlyOwner {
        if (token == address(0)) revert ZeroAddress();
        if (accepted) {
            uint8 decimals = IERC20Metadata(token).decimals();
            if (decimals != 6) revert InvalidTokenDecimals(token, decimals);
        }
        acceptedTokens[token] = accepted;
        emit PaymentTokenSet(token, accepted);
    }

    function setWhitelistRequired(bool required) external onlyOwner {
        whitelistRequired = required;
        emit WhitelistRequiredUpdated(required);
    }

    function setWhitelisted(address[] calldata users, bool status) external onlyOwner {
        for (uint256 i = 0; i < users.length; i++) {
            isWhitelisted[users[i]] = status;
            emit WhitelistUpdated(users[i], status);
        }
    }

    function setPerPersonCap(uint256 capUSD) external onlyOwner {
        if (capUSD == 0) revert ZeroAmount();
        perPersonCapUSD = capUSD;
        emit PerPersonCapUpdated(capUSD);
    }

    /**
     * @notice Exempt (or re-include) an address from the per-person cap.
     * @dev Intended for the trusted BuyHelper so gasless buys don't share one
     *      capped counter. Owner-only; emits CapExemptUpdated.
     */
    function setCapExempt(address account, bool exempt) external onlyOwner {
        if (account == address(0)) revert ZeroAddress();
        capExempt[account] = exempt;
        emit CapExemptUpdated(account, exempt);
    }

    function setTreasury(address newTreasury) external onlyOwner {
        if (newTreasury == address(0)) revert ZeroAddress();
        treasury = newTreasury;
        emit TreasuryUpdated(newTreasury);
    }

    /**
     * @notice Recover any ERC20 token (incl. GToken inventory) to treasury. Owner-only.
     */
    function recoverToken(address token) external onlyOwner {
        if (token == address(0)) revert ZeroAddress();
        uint256 balance = IERC20(token).balanceOf(address(this));
        if (balance > 0) {
            IERC20(token).safeTransfer(treasury, balance);
        }
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}
