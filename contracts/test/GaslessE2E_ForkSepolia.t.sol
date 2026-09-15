// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {AirAccountDelegate} from "../src/AirAccountDelegate.sol";
import {SaleContractV2} from "../src/SaleContractV2.sol";
import {APNTsSaleContract} from "../src/APNTsSaleContract.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/**
 * @notice Fork-Sepolia integration tests for the gasless EOA-enhance flow.
 *
 *  Tests the three user flows end-to-end against ACTUAL deployed contracts:
 *    A. Buy GToken via SaleContractV2 (gToken-bound)
 *    B. Buy aPNTs via APNTsSaleContract
 *    C. Revoke EIP-7702 delegation (just authorization processing; tested by behavior)
 *
 *  Note: Foundry's EIP-7702 cheatcode (vm.signAndAttachDelegation) requires
 *  Pectra-aware EVM. We instead simulate the delegation by `vm.etch`-ing the
 *  AirAccountDelegate code onto the buyer EOA and signing with that EOA's key
 *  — semantically equivalent for the on-chain executeBatch logic.
 *
 *  Run:
 *    forge test --match-contract GaslessE2EForkSepoliaTest \
 *      --fork-url $SEPOLIA_RPC_URL2 -vv
 */
contract GaslessE2EForkSepoliaTest is Test {
    // Canonical deployed addresses
    address constant DELEGATE   = 0x0BC1A36d932e2E9efA33b98043a73b8Be1a6E9Fc;
    address constant SALE_V2    = 0x3e4e0A663682a2d58d626D0057142328Ef0b626a;
    address constant APNTS_SALE = 0xf1a5FE670dbf6c5219000B30500a98F772EF1F14;
    address constant GTOKEN     = 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67;
    address constant APNTS      = 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772;
    address constant USDC       = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;

    // Buyer = synthetic EOA we control (we'll etch delegate code onto it)
    address buyer;
    uint256 buyerPk;

    function setUp() public {
        (buyer, buyerPk) = makeAddrAndKey("buyer-gasless-e2e");

        // Simulate EIP-7702: copy AirAccountDelegate code onto buyer EOA.
        vm.etch(buyer, address(DELEGATE).code);

        // Give buyer some USDC (no ETH on purpose — this is the gasless scenario).
        deal(USDC, buyer, 200 * 1e6); // 200 USDC for tests
        // Verify buyer has 0 ETH.
        assertEq(buyer.balance, 0);
    }

    // ─── helpers ─────────────────────────────────────────────────────────────

    function _sign(
        AirAccountDelegate.Call[] memory calls,
        uint256 deadline,
        uint256 nonce
    ) internal view returns (bytes memory) {
        bytes32 digest = AirAccountDelegate(payable(buyer)).hashExecuteBatch(calls, nonce, deadline);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(buyerPk, digest);
        return abi.encodePacked(r, s, v);
    }

    function _executeAs(address sender, AirAccountDelegate.Call[] memory calls, bytes memory sig, uint256 deadline) internal {
        vm.prank(sender); // simulates relayer calling EOA.executeBatch
        AirAccountDelegate(payable(buyer)).executeBatch(calls, deadline, sig);
    }

    // ─── A. Buy GToken (gasless) ─────────────────────────────────────────────

    function test_flowA_buy_gtoken_gasless() public {
        // Pre-state
        uint256 buyerGtBefore = IERC20(GTOKEN).balanceOf(buyer);
        uint256 saleInvBefore = IERC20(GTOKEN).balanceOf(SALE_V2);
        assertGe(saleInvBefore, 5e18, "sale should have inventory");

        // Build calls: [approve(USDC, SaleV2, 15), buyTokens(15, USDC, 0)]
        uint256 usdAmount = 15 * 1e6;
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](2);
        calls[0] = AirAccountDelegate.Call({
            target: USDC,
            value: 0,
            data: abi.encodeWithSignature("approve(address,uint256)", SALE_V2, usdAmount)
        });
        calls[1] = AirAccountDelegate.Call({
            target: SALE_V2,
            value: 0,
            data: abi.encodeWithSignature("buyTokens(uint256,address,uint256)", usdAmount, USDC, uint256(0))
        });

        uint256 deadline = block.timestamp + 600;
        uint256 nonceBefore = AirAccountDelegate(payable(buyer)).nonce();
        bytes memory sig = _sign(calls, deadline, nonceBefore);

        // Relayer (a fresh address with ETH for gas) calls executeBatch
        address relayer = makeAddr("relayer");
        vm.deal(relayer, 1 ether);
        _executeAs(relayer, calls, sig, deadline);

        // Post-state
        uint256 buyerGtAfter = IERC20(GTOKEN).balanceOf(buyer);
        assertGt(buyerGtAfter, buyerGtBefore, "buyer should receive GT");

        // At $0.15/GT, $15 = 100 GT
        assertEq(buyerGtAfter - buyerGtBefore, 100 * 1e18);

        // Nonce bumped
        assertEq(AirAccountDelegate(payable(buyer)).nonce(), nonceBefore + 1);
    }

    // ─── B. Buy aPNTs (gasless) ──────────────────────────────────────────────

    function test_flowB_buy_apnts_gasless() public {
        uint256 buyerAPBefore = IERC20(APNTS).balanceOf(buyer);

        uint256 usdAmount = 10 * 1e6; // $10
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](2);
        calls[0] = AirAccountDelegate.Call({
            target: USDC,
            value: 0,
            data: abi.encodeWithSignature("approve(address,uint256)", APNTS_SALE, usdAmount)
        });
        calls[1] = AirAccountDelegate.Call({
            target: APNTS_SALE,
            value: 0,
            data: abi.encodeWithSignature("buyAPNTs(uint256,address)", usdAmount, USDC)
        });

        uint256 deadline = block.timestamp + 600;
        bytes memory sig = _sign(calls, deadline, AirAccountDelegate(payable(buyer)).nonce());

        address relayer = makeAddr("relayer-b");
        vm.deal(relayer, 1 ether);
        _executeAs(relayer, calls, sig, deadline);

        // At $0.02/aPNTs, $10 = 500 aPNTs
        assertEq(IERC20(APNTS).balanceOf(buyer) - buyerAPBefore, 500 * 1e18);
    }

    // ─── C. Replay protection (incidental check, related to revoke security) ──

    function test_flowC_replay_blocked() public {
        uint256 usdAmount = 5 * 1e6;
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](2);
        calls[0] = AirAccountDelegate.Call({
            target: USDC,
            value: 0,
            data: abi.encodeWithSignature("approve(address,uint256)", SALE_V2, usdAmount)
        });
        calls[1] = AirAccountDelegate.Call({
            target: SALE_V2,
            value: 0,
            data: abi.encodeWithSignature("buyTokens(uint256,address,uint256)", usdAmount, USDC, uint256(0))
        });

        uint256 deadline = block.timestamp + 600;
        uint256 nonce0 = AirAccountDelegate(payable(buyer)).nonce();
        bytes memory sig = _sign(calls, deadline, nonce0);

        address relayer = makeAddr("relayer-c");
        vm.deal(relayer, 1 ether);
        _executeAs(relayer, calls, sig, deadline);

        // Same sig + same nonce should now fail
        vm.expectRevert(); // InvalidSigner: digest is for nonce 0 but contract expects 1
        vm.prank(relayer);
        AirAccountDelegate(payable(buyer)).executeBatch(calls, deadline, sig);
    }

    // ─── Sanity: deployed contracts are alive and verified ──────────────────

    function test_deployed_state_alive() public view {
        // AirAccountDelegate
        assertEq(AirAccountDelegate(payable(DELEGATE)).NAME(), "AirAccountDelegate");
        assertEq(AirAccountDelegate(payable(DELEGATE)).VERSION(), "1");

        // SaleContractV2
        assertEq(SaleContractV2(SALE_V2).version(), "2.0.0");

        // APNTsSaleContract — has aPNTs reference + priceUSD = $0.02
        assertEq(address(APNTsSaleContract(APNTS_SALE).aPNTs()), APNTS);
        assertEq(APNTsSaleContract(APNTS_SALE).priceUSD(), 20_000);
    }
}
