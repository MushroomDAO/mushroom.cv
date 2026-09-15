// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.25;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

/**
 * @title APNTsSaleContract
 * @author Mycelium Protocol
 * @notice Sells aPNTs (AccessPoints) at a fixed USD price.
 *
 * aPNTs are gas-credit tokens used in the SuperPaymaster system. Operators deposit
 * aPNTs into SuperPaymaster to sponsor user transactions; users can spend aPNTs
 * to pay for gas on their smart accounts.
 *
 * Design:
 * - Fixed price: DEFAULT_APNTS_PRICE_USD = $0.02 (6 decimals = 20_000)
 * - No bonding curve — price is configurable by owner
 * - Multiple purchases allowed (unlike GToken sale)
 * - Payment in any whitelisted ERC20 stablecoin (USDC, USDT)
 * - Proceeds go to treasury
 */
contract APNTsSaleContract is Ownable, ReentrancyGuard {
    using SafeERC20 for ERC20;

    // =============================================================
    //                           STATE
    // =============================================================

    ERC20 public immutable aPNTs;
    address public treasury;

    /// @notice Price of one aPNTs in USD with 6 decimals (e.g. 20_000 = $0.02)
    uint256 public priceUSD;

    /// @notice Total aPNTs sold through this contract
    uint256 public totalSold;

    /// @notice Minimum purchase: 1 aPNTs (1e18)
    uint256 public minPurchaseAmount;

    /// @notice Maximum single purchase to prevent whale manipulation
    uint256 public maxPurchaseAmount;

    /// @notice Whitelisted payment tokens (USDC, USDT)
    mapping(address => bool) public acceptedPaymentTokens;

    // =============================================================
    //                          EVENTS
    // =============================================================

    event APNTsPurchased(
        address indexed buyer,
        address indexed paymentToken,
        uint256 aPNTsAmount,
        uint256 usdAmount,
        uint256 priceUsed
    );
    event PriceUpdated(uint256 oldPrice, uint256 newPrice);
    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event PaymentTokenSet(address indexed token, bool accepted);
    event PurchaseLimitsUpdated(uint256 minAmount, uint256 maxAmount);
    event EmergencyWithdraw(address indexed token, uint256 amount, address indexed to);
    /// @notice Emitted by buyAPNTsFor when the recipient differs from the payer.
    event APNTsPurchasedFor(
        address indexed buyer,
        address indexed recipient,
        address indexed paymentToken,
        uint256 aPNTsAmount,
        uint256 usdAmount,
        uint256 priceUsed
    );

    // =============================================================
    //                        ERRORS
    // =============================================================

    error ZeroAddress();
    error ZeroAmount();
    error InvalidPrice();
    error PaymentTokenNotAccepted(address token);
    error InvalidPaymentTokenDecimals(address token, uint8 decimals);
    error BelowMinPurchase(uint256 amount, uint256 minimum);
    error ExceedsMaxPurchase(uint256 amount, uint256 maximum);
    error InsufficientInventory(uint256 requested, uint256 available);

    // =============================================================
    //                       CONSTRUCTOR
    // =============================================================

    /**
     * @param _aPNTsAddress Address of the aPNTs ERC20 token
     * @param _treasury Address to receive payment proceeds
     * @param _initialPriceUSD Initial price in USD with 6 decimals (default $0.02 = 20_000)
     * @param _initialOwner Owner of this contract
     */
    constructor(
        address _aPNTsAddress,
        address _treasury,
        uint256 _initialPriceUSD,
        address _initialOwner
    ) Ownable(_initialOwner) {
        if (_aPNTsAddress == address(0)) revert ZeroAddress();
        if (_treasury == address(0)) revert ZeroAddress();
        if (_initialPriceUSD == 0) revert InvalidPrice();

        aPNTs = ERC20(_aPNTsAddress);
        treasury = _treasury;
        priceUSD = _initialPriceUSD;

        // Default limits: min 10 aPNTs, max 100,000 aPNTs per purchase
        minPurchaseAmount = 10 * 1e18;
        maxPurchaseAmount = 100_000 * 1e18;
    }

    // =============================================================
    //                       VIEW FUNCTIONS
    // =============================================================

    /**
     * @notice Calculate how many aPNTs a buyer receives for a given USD amount.
     * @param usdAmount Amount in USD with 6 decimals
     * @return aPNTsAmount Amount of aPNTs (18 decimals)
     */
    function getAPNTsForUSD(uint256 usdAmount) public view returns (uint256 aPNTsAmount) {
        // aPNTsAmount = usdAmount * 1e18 / priceUSD
        return (usdAmount * 1e18) / priceUSD;
    }

    /**
     * @notice Calculate how much USD is needed to buy a given amount of aPNTs.
     * @param aPNTsAmount Amount of aPNTs (18 decimals)
     * @return usdAmount Amount in USD with 6 decimals
     */
    function getUSDForAPNTs(uint256 aPNTsAmount) public view returns (uint256 usdAmount) {
        // Round up to avoid rounding attacks
        return (aPNTsAmount * priceUSD + 1e18 - 1) / 1e18;
    }

    /**
     * @notice Get the current aPNTs inventory held by this contract.
     */
    function availableInventory() public view returns (uint256) {
        return aPNTs.balanceOf(address(this));
    }

    // =============================================================
    //                      PURCHASE LOGIC
    // =============================================================

    /**
     * @notice Purchase aPNTs by paying with an accepted stablecoin.
     * @param usdAmount Amount in USD (6 decimals) to spend
     * @param paymentToken Address of the accepted ERC20 stablecoin (e.g. USDC)
     *
     * @dev Payment token must be whitelisted by owner. The contract assumes
     * the payment token is a USD stablecoin with 6 decimals. For tokens
     * with different decimals, owner should adjust the price accordingly.
     */
    function buyAPNTs(uint256 usdAmount, address paymentToken) external nonReentrant {
        _buyAPNTsFor(msg.sender, usdAmount, paymentToken);
    }

    /**
     * @notice Same as `buyAPNTs`, but credits the purchased aPNTs to `to`
     *         instead of msg.sender. Payment is still pulled from msg.sender.
     * @dev Added for SDK self-pay "buy into AirAccount" — recipient ≠ payer
     *      (aastar-sdk#145 gap 2; e.g. pay with USDT from MetaMask EOA, credit
     *      aPNTs to the user's AirAccount).
     * @param to Recipient of the purchased aPNTs (must be non-zero).
     * @return aPNTsAmount Amount of aPNTs credited to `to`.
     */
    function buyAPNTsFor(address to, uint256 usdAmount, address paymentToken)
        external
        nonReentrant
        returns (uint256)
    {
        return _buyAPNTsFor(to, usdAmount, paymentToken);
    }

    /**
     * @dev Core purchase logic. Payer is always msg.sender; recipient is `to`.
     *      Only reachable via the nonReentrant `buyAPNTs` / `buyAPNTsFor` externals.
     */
    function _buyAPNTsFor(address to, uint256 usdAmount, address paymentToken)
        internal
        returns (uint256 aPNTsAmount)
    {
        if (to == address(0) || to == address(this)) revert ZeroAddress();
        if (usdAmount == 0) revert ZeroAmount();
        if (!acceptedPaymentTokens[paymentToken]) revert PaymentTokenNotAccepted(paymentToken);

        aPNTsAmount = getAPNTsForUSD(usdAmount);

        if (aPNTsAmount < minPurchaseAmount) revert BelowMinPurchase(aPNTsAmount, minPurchaseAmount);
        if (aPNTsAmount > maxPurchaseAmount) revert ExceedsMaxPurchase(aPNTsAmount, maxPurchaseAmount);

        uint256 inventory = availableInventory();
        if (aPNTsAmount > inventory) revert InsufficientInventory(aPNTsAmount, inventory);

        // CEI: state update before external transfers.
        totalSold += aPNTsAmount;

        // Transfer payment from payer (msg.sender) to treasury
        ERC20(paymentToken).safeTransferFrom(msg.sender, treasury, usdAmount);

        // Transfer aPNTs to recipient `to` (observable via the aPNTs Transfer event)
        aPNTs.safeTransfer(to, aPNTsAmount);

        emit APNTsPurchased(msg.sender, paymentToken, aPNTsAmount, usdAmount, priceUSD);
        // Record the actual recipient when it differs from the payer.
        if (to != msg.sender) {
            emit APNTsPurchasedFor(msg.sender, to, paymentToken, aPNTsAmount, usdAmount, priceUSD);
        }
    }

    /**
     * @notice Purchase aPNTs by specifying an exact aPNTs amount (USD is calculated).
     * @param aPNTsAmount Exact amount of aPNTs to buy (18 decimals)
     * @param paymentToken Address of the accepted ERC20 stablecoin
     */
    function buyExactAPNTs(uint256 aPNTsAmount, address paymentToken) external nonReentrant {
        if (aPNTsAmount == 0) revert ZeroAmount();
        if (!acceptedPaymentTokens[paymentToken]) revert PaymentTokenNotAccepted(paymentToken);
        if (aPNTsAmount < minPurchaseAmount) revert BelowMinPurchase(aPNTsAmount, minPurchaseAmount);
        if (aPNTsAmount > maxPurchaseAmount) revert ExceedsMaxPurchase(aPNTsAmount, maxPurchaseAmount);

        uint256 inventory = availableInventory();
        if (aPNTsAmount > inventory) revert InsufficientInventory(aPNTsAmount, inventory);

        uint256 usdAmount = getUSDForAPNTs(aPNTsAmount);

        // CEI: state update before external transfers.
        totalSold += aPNTsAmount;

        ERC20(paymentToken).safeTransferFrom(msg.sender, treasury, usdAmount);
        aPNTs.safeTransfer(msg.sender, aPNTsAmount);

        emit APNTsPurchased(msg.sender, paymentToken, aPNTsAmount, usdAmount, priceUSD);
    }

    // =============================================================
    //                       ADMIN FUNCTIONS
    // =============================================================

    /**
     * @notice Set the price of one aPNTs in USD (6 decimals).
     * @param newPriceUSD New price. e.g. 20_000 = $0.02
     */
    function setPrice(uint256 newPriceUSD) external onlyOwner {
        if (newPriceUSD == 0) revert InvalidPrice();
        emit PriceUpdated(priceUSD, newPriceUSD);
        priceUSD = newPriceUSD;
    }

    /**
     * @notice Update the treasury address that receives payment proceeds.
     */
    function setTreasury(address newTreasury) external onlyOwner {
        if (newTreasury == address(0)) revert ZeroAddress();
        emit TreasuryUpdated(treasury, newTreasury);
        treasury = newTreasury;
    }

    /**
     * @notice Whitelist or blacklist a payment token.
     * @param token ERC20 token address
     * @param accepted True to accept, false to reject
     */
    function setPaymentToken(address token, bool accepted) external onlyOwner {
        if (token == address(0)) revert ZeroAddress();
        // Codex MEDIUM-3 fix: enforce 6-decimal stablecoin (USDC/USDT). Mirrors
        // SaleContractV2.setPaymentToken so pricing math (USD with 6 decimals)
        // can't be subverted by whitelisting a non-6-dec token.
        if (accepted) {
            uint8 decimals = IERC20Metadata(token).decimals();
            if (decimals != 6) revert InvalidPaymentTokenDecimals(token, decimals);
        }
        acceptedPaymentTokens[token] = accepted;
        emit PaymentTokenSet(token, accepted);
    }

    /**
     * @notice Update min and max purchase limits.
     * @param minAmount Minimum aPNTs per purchase (18 decimals)
     * @param maxAmount Maximum aPNTs per purchase (18 decimals)
     */
    function setPurchaseLimits(uint256 minAmount, uint256 maxAmount) external onlyOwner {
        require(minAmount > 0 && maxAmount >= minAmount, "Invalid limits");
        minPurchaseAmount = minAmount;
        maxPurchaseAmount = maxAmount;
        emit PurchaseLimitsUpdated(minAmount, maxAmount);
    }

    /**
     * @notice Withdraw unsold aPNTs back to treasury.
     */
    function withdrawUnsoldAPNTs() external onlyOwner {
        uint256 balance = aPNTs.balanceOf(address(this));
        if (balance > 0) {
            aPNTs.safeTransfer(treasury, balance);
            emit EmergencyWithdraw(address(aPNTs), balance, treasury);
        }
    }

    /**
     * @notice Emergency: recover any ERC20 token accidentally sent to this contract.
     * Cannot be used to drain aPNTs (use withdrawUnsoldAPNTs for that).
     */
    function recoverToken(address token, uint256 amount) external onlyOwner {
        require(token != address(aPNTs), "Use withdrawUnsoldAPNTs");
        ERC20(token).safeTransfer(treasury, amount);
        emit EmergencyWithdraw(token, amount, treasury);
    }

    /**
     * @notice Withdraw any accumulated ETH (e.g. from accidental ETH sends).
     */
    function withdrawEther() external onlyOwner {
        uint256 balance = address(this).balance;
        if (balance > 0) {
            (bool success,) = treasury.call{value: balance}("");
            require(success, "ETH transfer failed");
        }
    }
}
