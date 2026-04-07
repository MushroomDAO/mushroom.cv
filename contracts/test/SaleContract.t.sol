// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {SaleContract} from "../src/SaleContract.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {Pausable} from "openzeppelin-contracts/contracts/utils/Pausable.sol";

// ─── Mock Tokens ────────────────────────────────────────────────────────────

contract MockGToken is ERC20 {
    constructor() ERC20("GToken", "GT") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract MockUSDC is ERC20 {
    constructor() ERC20("Mock USDC", "USDC") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

// ─── Test Suite ─────────────────────────────────────────────────────────────

contract SaleContractTest is Test {
    SaleContract public sale;
    MockGToken public gToken;
    MockUSDC public usdc;

    address public owner = makeAddr("owner");
    address public treasury = makeAddr("treasury");
    address public user1 = makeAddr("user1");
    address public user2 = makeAddr("user2");
    address public user3 = makeAddr("user3");

    // Milestone 0 price: $0.15 (6 decimals)
    uint256 constant PRICE_M0 = 150_000;
    // Milestone 1 revenueCap: $1,200 (6 decimals)
    uint256 constant REVENUE_CAP_M1 = 1_200_000_000;
    // Per-person default cap: $864
    uint256 constant PER_PERSON_CAP = 864_000_000;
    // Large GToken inventory for tests
    uint256 constant INVENTORY = 1_000_000 * 1e18;

    function setUp() public {
        gToken = new MockGToken();
        usdc = new MockUSDC();

        vm.startPrank(owner);
        sale = new SaleContract(address(gToken), treasury, owner);
        sale.setPaymentToken(address(usdc), true);
        vm.stopPrank();

        // Fund the contract with GTokens
        gToken.mint(address(sale), INVENTORY);

        // Fund users with USDC — more than per-person cap so we can test limits
        usdc.mint(user1, 10_000 * 1e6);
        usdc.mint(user2, 10_000 * 1e6);
        usdc.mint(user3, 10_000 * 1e6);
    }

    // =========================================================
    //                    INITIAL STATE
    // =========================================================

    function test_InitialState() public view {
        assertEq(sale.owner(), owner);
        assertEq(address(sale.gToken()), address(gToken));
        assertEq(sale.treasury(), treasury);
        assertEq(sale.currentMilestone(), 0);
        assertEq(sale.totalRevenue(), 0);
        assertEq(sale.totalTokensSold(), 0);
        assertEq(sale.getCurrentPriceUSD(), PRICE_M0);
        assertFalse(sale.whitelistRequired());
        assertEq(sale.perPersonCapUSD(), PER_PERSON_CAP);
    }

    // =========================================================
    //                   BASIC PURCHASE
    // =========================================================

    function test_BuyTokensBasic() public {
        uint256 usdAmount = 300 * 1e6; // $300
        uint256 expectedGTokens = (usdAmount * 1e18) / PRICE_M0;

        vm.startPrank(user1);
        usdc.approve(address(sale), usdAmount);
        sale.buyTokens(usdAmount, address(usdc));
        vm.stopPrank();

        assertEq(gToken.balanceOf(user1), expectedGTokens);
        assertEq(usdc.balanceOf(treasury), usdAmount);
        assertEq(sale.totalRevenue(), usdAmount);
        assertEq(sale.totalTokensSold(), expectedGTokens);
        assertEq(sale.userTotalSpent(user1), usdAmount);
    }

    function test_BuyTokens_ZeroAmountReverts() public {
        vm.prank(user1);
        vm.expectRevert(SaleContract.ZeroAmount.selector);
        sale.buyTokens(0, address(usdc));
    }

    function test_BuyTokens_UnacceptedTokenReverts() public {
        address randomToken = makeAddr("randomToken");
        vm.prank(user1);
        vm.expectRevert(abi.encodeWithSelector(SaleContract.TokenNotAccepted.selector, randomToken));
        sale.buyTokens(100 * 1e6, randomToken);
    }

    function test_BuyTokens_InsufficientInventoryReverts() public {
        // Drain the inventory first
        vm.prank(owner);
        sale.recoverToken(address(gToken));

        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        uint256 gTokens = sale.getTokensForUSD(100 * 1e6);
        vm.expectRevert(abi.encodeWithSelector(SaleContract.InsufficientInventory.selector, gTokens, 0));
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();
    }

    // =========================================================
    //                   PER-PERSON CAP
    // =========================================================

    function test_BuyTokensPerPersonCap() public {
        // Spend exactly the cap — should succeed
        vm.startPrank(user1);
        usdc.approve(address(sale), PER_PERSON_CAP);
        sale.buyTokens(PER_PERSON_CAP, address(usdc));
        vm.stopPrank();

        assertEq(sale.userTotalSpent(user1), PER_PERSON_CAP);

        // Any additional spend should revert
        vm.startPrank(user1);
        usdc.approve(address(sale), 1);
        vm.expectRevert(abi.encodeWithSelector(SaleContract.ExceedsPerPersonCap.selector, 1, 0));
        sale.buyTokens(1, address(usdc));
        vm.stopPrank();
    }

    function test_BuyTokens_PartialBuysRespectCap() public {
        uint256 half = PER_PERSON_CAP / 2;

        vm.startPrank(user1);
        usdc.approve(address(sale), PER_PERSON_CAP + 1);
        sale.buyTokens(half, address(usdc));
        sale.buyTokens(half, address(usdc));
        // One more wei should revert
        vm.expectRevert(abi.encodeWithSelector(SaleContract.ExceedsPerPersonCap.selector, 1, 0));
        sale.buyTokens(1, address(usdc));
        vm.stopPrank();
    }

    // =========================================================
    //                   MILESTONE ADVANCE
    // =========================================================

    function test_AdvanceMilestone() public {
        // Milestone 1 requires $1,200 revenue
        _buyWithRevenue(user1, REVENUE_CAP_M1);

        (uint256 price1, ) = sale.getMilestone(1);

        vm.prank(owner);
        sale.advanceMilestone();

        assertEq(sale.currentMilestone(), 1);
        assertEq(sale.getCurrentPriceUSD(), price1);
    }

    function test_AdvanceMilestone_PriceChanges() public {
        uint256 priceBefore = sale.getCurrentPriceUSD();
        _buyWithRevenue(user1, REVENUE_CAP_M1);

        vm.prank(owner);
        sale.advanceMilestone();

        uint256 priceAfter = sale.getCurrentPriceUSD();
        assertGt(priceAfter, priceBefore);
    }

    function test_AdvanceMilestoneNotReached() public {
        // Only $100 — far below $1,200 cap
        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();

        vm.prank(owner);
        vm.expectRevert(
            abi.encodeWithSelector(
                SaleContract.MilestoneNotReached.selector,
                100 * 1e6,
                REVENUE_CAP_M1
            )
        );
        sale.advanceMilestone();
    }

    function test_AdvanceMilestone_AlreadyAtMax() public {
        // Fast-forward: set totalRevenue to max cap and currentMilestone to 5 via storage
        _setTotalRevenue(135_800_000_000);
        _setCurrentMilestone(5);
        assertEq(sale.currentMilestone(), 5);

        vm.prank(owner);
        vm.expectRevert(SaleContract.AlreadyAtMaxMilestone.selector);
        sale.advanceMilestone();
    }

    // =========================================================
    //                   WHITELIST
    // =========================================================

    function test_WhitelistRequired() public {
        vm.prank(owner);
        sale.setWhitelistRequired(true);

        // Non-whitelisted user should fail
        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        vm.expectRevert(abi.encodeWithSelector(SaleContract.NotWhitelisted.selector, user1));
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();

        // Whitelist user1 then buy should succeed
        address[] memory users = new address[](1);
        users[0] = user1;
        vm.prank(owner);
        sale.setWhitelisted(users, true);

        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();

        assertGt(gToken.balanceOf(user1), 0);
    }

    function test_WhitelistDisabled_AnyoneCanBuy() public {
        // whitelistRequired is false by default — user2 should be able to buy
        vm.startPrank(user2);
        usdc.approve(address(sale), 100 * 1e6);
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();

        assertGt(gToken.balanceOf(user2), 0);
    }

    // =========================================================
    //                   PAUSE / UNPAUSE
    // =========================================================

    function test_PauseUnpause() public {
        vm.prank(owner);
        sale.pause();

        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        vm.expectRevert(Pausable.EnforcedPause.selector);
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();

        vm.prank(owner);
        sale.unpause();

        // After unpause, purchase should succeed
        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        sale.buyTokens(100 * 1e6, address(usdc));
        vm.stopPrank();

        assertGt(gToken.balanceOf(user1), 0);
    }

    function test_Pause_OnlyOwner() public {
        vm.prank(user1);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1));
        sale.pause();
    }

    // =========================================================
    //                   RECOVER TOKEN
    // =========================================================

    function test_RecoverToken() public {
        // Accidentally send some USDC to the contract
        usdc.mint(address(sale), 500 * 1e6);
        uint256 treasuryBefore = usdc.balanceOf(treasury);

        vm.prank(owner);
        sale.recoverToken(address(usdc));

        // Treasury should have received the USDC
        assertEq(usdc.balanceOf(treasury), treasuryBefore + 500 * 1e6);
        assertEq(usdc.balanceOf(address(sale)), 0);
    }

    function test_RecoverToken_OnlyOwner() public {
        vm.prank(user1);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1));
        sale.recoverToken(address(usdc));
    }

    // =========================================================
    //                   MULTIPLE USERS
    // =========================================================

    function test_MultipleUsersBuy() public {
        uint256 amountEach = 200 * 1e6; // $200 each

        vm.startPrank(user1);
        usdc.approve(address(sale), amountEach);
        sale.buyTokens(amountEach, address(usdc));
        vm.stopPrank();

        vm.startPrank(user2);
        usdc.approve(address(sale), amountEach);
        sale.buyTokens(amountEach, address(usdc));
        vm.stopPrank();

        vm.startPrank(user3);
        usdc.approve(address(sale), amountEach);
        sale.buyTokens(amountEach, address(usdc));
        vm.stopPrank();

        assertEq(sale.totalRevenue(), amountEach * 3);
        assertEq(sale.userTotalSpent(user1), amountEach);
        assertEq(sale.userTotalSpent(user2), amountEach);
        assertEq(sale.userTotalSpent(user3), amountEach);
        assertEq(usdc.balanceOf(treasury), amountEach * 3);

        uint256 expectedTokensEach = (amountEach * 1e18) / PRICE_M0;
        assertEq(gToken.balanceOf(user1), expectedTokensEach);
        assertEq(gToken.balanceOf(user2), expectedTokensEach);
        assertEq(gToken.balanceOf(user3), expectedTokensEach);
        assertEq(sale.totalTokensSold(), expectedTokensEach * 3);
    }

    // =========================================================
    //                   ADMIN FUNCTIONS
    // =========================================================

    function test_SetTreasury() public {
        address newTreasury = makeAddr("newTreasury");
        vm.prank(owner);
        sale.setTreasury(newTreasury);
        assertEq(sale.treasury(), newTreasury);
    }

    function test_SetTreasury_ZeroAddressReverts() public {
        vm.prank(owner);
        vm.expectRevert(SaleContract.ZeroAddress.selector);
        sale.setTreasury(address(0));
    }

    function test_SetPerPersonCap() public {
        uint256 newCap = 500 * 1e6; // $500
        vm.prank(owner);
        sale.setPerPersonCap(newCap);
        assertEq(sale.perPersonCapUSD(), newCap);
    }

    function test_SetPaymentToken() public {
        address newToken = makeAddr("newToken");
        vm.prank(owner);
        sale.setPaymentToken(newToken, true);
        assertTrue(sale.acceptedTokens(newToken));

        vm.prank(owner);
        sale.setPaymentToken(newToken, false);
        assertFalse(sale.acceptedTokens(newToken));
    }

    function test_GetTokensForUSD() public view {
        uint256 usd = 150 * 1e6; // $150
        uint256 expected = (usd * 1e18) / PRICE_M0; // 1000 GTokens
        assertEq(sale.getTokensForUSD(usd), expected);
    }

    // =========================================================
    //                   HELPERS
    // =========================================================

    /// @dev Buy tokens in chunks to accumulate `targetRevenue` using multiple users
    function _buyWithRevenue(address buyer, uint256 targetRevenue) internal {
        // If target exceeds per-person cap, distribute across multiple users
        uint256 cap = sale.perPersonCapUSD();
        address[3] memory buyers = [buyer, user2, user3];
        uint256 remaining = targetRevenue;
        uint256 bi = 0;

        while (remaining > 0) {
            address b = buyers[bi % 3];
            uint256 spent = sale.userTotalSpent(b);
            uint256 canSpend = cap > spent ? cap - spent : 0;
            if (canSpend == 0) {
                bi++;
                continue;
            }
            uint256 amount = remaining < canSpend ? remaining : canSpend;

            // Make sure the buyer has enough USDC
            if (usdc.balanceOf(b) < amount) {
                usdc.mint(b, amount);
            }

            vm.startPrank(b);
            usdc.approve(address(sale), amount);
            sale.buyTokens(amount, address(usdc));
            vm.stopPrank();

            remaining -= amount;
            bi++;
        }
    }

    /// @dev Directly overwrite totalRevenue storage slot for milestone tests.
    function _setTotalRevenue(uint256 amount) internal {
        // Storage layout (from forge inspect):
        //   slot 14: currentMilestone
        //   slot 15: totalRevenue
        vm.store(address(sale), bytes32(uint256(15)), bytes32(amount));
    }

    /// @dev Directly overwrite currentMilestone storage slot.
    function _setCurrentMilestone(uint256 index) internal {
        vm.store(address(sale), bytes32(uint256(14)), bytes32(index));
    }
}
