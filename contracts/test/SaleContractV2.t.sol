// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {SaleContractV2} from "../src/SaleContractV2.sol";
import {MockGToken} from "../src/MockGToken.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract MockUSDC is ERC20 {
    constructor() ERC20("USD Coin", "USDC") {}
    function decimals() public pure override returns (uint8) { return 6; }
    function mint(address to, uint256 amount) external { _mint(to, amount); }
}

contract SaleContractV2Test is Test {
    SaleContractV2 sale;
    MockGToken gt;
    MockUSDC usdc;

    address owner = makeAddr("owner");
    address treasury = makeAddr("treasury");
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        vm.startPrank(owner);
        gt = new MockGToken(owner);
        usdc = new MockUSDC();
        sale = new SaleContractV2(address(gt), treasury, owner);
        sale.setPaymentToken(address(usdc), true);
        gt.mint(address(sale), 5_000_000 * 1e18); // 5M GT inventory (covers full milestone walkthroughs)
        vm.stopPrank();

        // Bump per-person cap so big-buy tests can run.
        vm.prank(owner);
        sale.setPerPersonCap(500_000 * 1e6); // $500K per person

        usdc.mint(alice, 1_000_000 * 1e6);
        usdc.mint(bob, 1_000_000 * 1e6);
        vm.prank(alice); usdc.approve(address(sale), type(uint256).max);
        vm.prank(bob);   usdc.approve(address(sale), type(uint256).max);
    }

    // ─── V1 parity: initial milestones ──────────────────────────────────

    function test_initial_milestones_match_V1() public view {
        assertEq(sale.getMilestoneCount(), 6);
        (uint256 p0, uint256 c0) = sale.getMilestone(0);
        assertEq(p0, 150_000); assertEq(c0, 0);
        (uint256 p5, uint256 c5) = sale.getMilestone(5);
        assertEq(p5, 264_351); assertEq(c5, 135_800_000_000);
        assertEq(sale.getCurrentPriceUSD(), 150_000);
    }

    // ─── V2: addMilestone happy path ───────────────────────────────────

    function test_addMilestone_owner_appends_correctly() public {
        vm.prank(owner);
        sale.addMilestone(300_000, 200_000_000_000); // M6 = $0.30 @ $200K
        assertEq(sale.getMilestoneCount(), 7);
        (uint256 p, uint256 c) = sale.getMilestone(6);
        assertEq(p, 300_000); assertEq(c, 200_000_000_000);
    }

    function test_addMilestone_reverts_when_price_too_low() public {
        vm.prank(owner);
        vm.expectRevert(abi.encodeWithSelector(
            SaleContractV2.InvalidMilestonePrice.selector, 264_351, 264_351));
        sale.addMilestone(264_351, 200_000_000_000); // same as M5 price
    }

    function test_addMilestone_reverts_when_cap_too_low() public {
        vm.prank(owner);
        vm.expectRevert(abi.encodeWithSelector(
            SaleContractV2.InvalidMilestoneCap.selector, 135_800_000_000, 135_800_000_000));
        sale.addMilestone(300_000, 135_800_000_000); // same as M5 cap
    }

    function test_addMilestone_reverts_for_non_owner() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(
            Ownable.OwnableUnauthorizedAccount.selector, alice));
        sale.addMilestone(300_000, 200_000_000_000);
    }

    // ─── V2: addMilestoneAutoStep (+12%) ───────────────────────────────

    function test_autoStep_applies_12pct() public {
        // 264351 * 11200 / 10000 = 296073 (integer-truncated)
        uint256 expected = uint256(264_351) * 11_200 / 10_000;
        vm.prank(owner);
        sale.addMilestoneAutoStep(200_000_000_000);
        (uint256 p, uint256 c) = sale.getMilestone(6);
        assertEq(p, expected);
        assertEq(p, 296_073);
        assertEq(c, 200_000_000_000);
    }

    function test_autoStep_reverts_when_cap_too_low() public {
        vm.prank(owner);
        vm.expectRevert(abi.encodeWithSelector(
            SaleContractV2.InvalidMilestoneCap.selector, 100_000_000_000, 135_800_000_000));
        sale.addMilestoneAutoStep(100_000_000_000);
    }

    function test_autoStep_chainable_5_times() public {
        uint256 cap = 135_800_000_000;
        uint256 lastPrice = 264_351;
        for (uint256 i = 0; i < 5; i++) {
            cap += 50_000_000_000; // +$50K each step
            vm.prank(owner);
            sale.addMilestoneAutoStep(cap);
            uint256 expected = (lastPrice * 11_200) / 10_000;
            (uint256 p, ) = sale.getMilestone(6 + i);
            assertEq(p, expected);
            lastPrice = expected;
        }
        assertEq(sale.getMilestoneCount(), 11);
    }

    // ─── V2: auto-advance works beyond original 6 ──────────────────────

    function test_buy_advances_through_added_milestones() public {
        // Append M6/M7 so a single big buy can advance multiple steps.
        vm.startPrank(owner);
        sale.addMilestone(300_000, 200_000_000_000); // M6 @ $200K
        sale.addMilestone(350_000, 250_000_000_000); // M7 @ $250K
        vm.stopPrank();

        // alice buys $250K worth — should auto-advance to M7 by the end.
        vm.prank(alice);
        sale.buyTokens(250_000 * 1e6, address(usdc), 0);

        assertEq(sale.totalRevenue(), 250_000 * 1e6);
        assertEq(sale.currentMilestone(), 7);
        assertEq(sale.getCurrentPriceUSD(), 350_000);
    }

    function test_buy_after_extending_uses_new_price() public {
        // Reach M5 first (drive up totalRevenue past $135.8K).
        vm.prank(alice);
        sale.buyTokens(135_800 * 1e6, address(usdc), 0);
        assertEq(sale.currentMilestone(), 5);
        assertEq(sale.getCurrentPriceUSD(), 264_351);

        // Owner appends M6 at +12%.
        vm.prank(owner);
        sale.addMilestoneAutoStep(200_000_000_000);

        // Reach M6 with another buy.
        vm.prank(bob);
        sale.buyTokens(64_200 * 1e6, address(usdc), 0);
        assertEq(sale.currentMilestone(), 6);
        assertEq(sale.getCurrentPriceUSD(), uint256(264_351) * 11_200 / 10_000);
    }

    // ─── V2: getAllMilestones snapshot ─────────────────────────────────

    function test_getAllMilestones_returns_full_array() public {
        vm.prank(owner);
        sale.addMilestone(300_000, 200_000_000_000);
        SaleContractV2.Milestone[] memory all = sale.getAllMilestones();
        assertEq(all.length, 7);
        assertEq(all[5].priceUSD, 264_351);
        assertEq(all[6].priceUSD, 300_000);
    }

    // ─── V1 invariants still hold ──────────────────────────────────────

    function test_buy_basic_smoke() public {
        vm.prank(alice);
        sale.buyTokens(150 * 1e6, address(usdc), 0); // $150 → 1000 GT @ $0.15
        assertEq(gt.balanceOf(alice), 1000 * 1e18);
        assertEq(usdc.balanceOf(treasury), 150 * 1e6);
    }

    function test_pause_blocks_buys() public {
        vm.prank(owner);
        sale.pause();
        vm.prank(alice);
        vm.expectRevert();
        sale.buyTokens(150 * 1e6, address(usdc), 0);
    }

    function test_recoverToken_owner_only() public {
        vm.prank(owner);
        sale.recoverToken(address(gt));
        assertEq(gt.balanceOf(address(sale)), 0);
        assertEq(gt.balanceOf(treasury), 5_000_000 * 1e18);
    }

    function test_version() public view {
        assertEq(sale.VERSION(), 20000);
        assertEq(sale.version(), "2.0.0");
    }

    // ─── buyTokensFor: self-pay with explicit recipient (SDK#145 gap 2) ──

    function test_buyTokensFor_credits_recipient() public {
        uint256 usd = 150 * 1e6; // $150 → 1000 GT @ $0.15
        vm.prank(alice);
        uint256 out = sale.buyTokensFor(bob, usd, address(usdc), 0);

        assertEq(out, 1000 * 1e18, "returns minted amount");
        assertEq(gt.balanceOf(bob), 1000 * 1e18, "recipient gets GToken");
        assertEq(gt.balanceOf(alice), 0, "payer gets nothing");
        assertEq(usdc.balanceOf(treasury), usd, "payment pulled from payer");
        assertEq(sale.userTotalSpent(alice), usd, "cap charged to payer");
        assertEq(sale.userTotalSpent(bob), 0, "recipient cap untouched");
    }

    function test_buyTokensFor_zero_recipient_reverts() public {
        vm.prank(alice);
        vm.expectRevert(SaleContractV2.ZeroAddress.selector);
        sale.buyTokensFor(address(0), 150 * 1e6, address(usdc), 0);
    }

    function test_buyTokensFor_respects_slippage() public {
        // $150 yields exactly 1000 GT; requiring 1001 must revert.
        vm.prank(alice);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContractV2.SlippageExceeded.selector, 1000 * 1e18, 1001 * 1e18)
        );
        sale.buyTokensFor(bob, 150 * 1e6, address(usdc), 1001 * 1e18);
    }

    function test_buyTokens_still_credits_self() public {
        vm.prank(alice);
        sale.buyTokens(150 * 1e6, address(usdc), 0);
        assertEq(gt.balanceOf(alice), 1000 * 1e18, "legacy path unchanged");
    }

    // ─── release hardening: cap exemption / self-recipient / recipient event ──

    function test_buyTokensFor_rejects_self_recipient() public {
        vm.prank(alice);
        vm.expectRevert(SaleContractV2.ZeroAddress.selector);
        sale.buyTokensFor(address(sale), 150 * 1e6, address(usdc), 0);
    }

    function test_capExempt_skips_per_person_cap() public {
        // Lower cap to $100; exempt alice → she can exceed it (mirrors BuyHelper).
        vm.startPrank(owner);
        sale.setPerPersonCap(100 * 1e6);
        sale.setCapExempt(alice, true);
        vm.stopPrank();

        vm.startPrank(alice);
        sale.buyTokens(150 * 1e6, address(usdc), 0); // $150 > $100 cap, but exempt
        sale.buyTokens(150 * 1e6, address(usdc), 0);
        vm.stopPrank();
        assertEq(gt.balanceOf(alice), 2000 * 1e18, "exempt payer bypasses cap");
    }

    function test_cap_still_enforced_for_non_exempt() public {
        vm.prank(owner);
        sale.setPerPersonCap(100 * 1e6);
        vm.prank(alice);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContractV2.ExceedsPerPersonCap.selector, 150 * 1e6, 100 * 1e6)
        );
        sale.buyTokens(150 * 1e6, address(usdc), 0);
    }

    function test_setCapExempt_owner_only() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, alice));
        sale.setCapExempt(alice, true);
    }

    function test_TokensPurchasedFor_emitted_on_buyFor() public {
        vm.expectEmit(true, true, true, true);
        emit SaleContractV2.TokensPurchasedFor(alice, bob, address(usdc), 150 * 1e6, 1000 * 1e18, 150_000, 0);
        vm.prank(alice);
        sale.buyTokensFor(bob, 150 * 1e6, address(usdc), 0);
    }

    // ── audit #5: a newly-added milestone whose cap is already met advances now ──

    function test_addMilestone_advances_if_already_met() public {
        // Drive revenue past the last seeded milestone (M5 cap $135.8K).
        vm.prank(owner);
        sale.setPerPersonCap(10_000_000 * 1e6);
        usdc.mint(alice, 10_000_000 * 1e6);
        vm.prank(alice);
        sale.buyTokens(200_000 * 1e6, address(usdc), 0); // $200K revenue → advances to M5
        assertEq(sale.currentMilestone(), 5, "at last seeded milestone");

        // Append M6 with cap $150K (< $200K revenue): must auto-advance immediately.
        vm.prank(owner);
        sale.addMilestone(300_000, 150_000_000_000); // $0.30 @ $150K cap
        assertEq(sale.currentMilestone(), 6, "auto-advanced to already-met new milestone");
        assertEq(sale.getCurrentPriceUSD(), 300_000, "next buy uses new price, not stale");
    }
}
