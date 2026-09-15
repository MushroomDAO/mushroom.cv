// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {SaleContractV2} from "../src/SaleContractV2.sol";
import {APNTsSaleContract} from "../src/APNTsSaleContract.sol";
import {BuyHelper} from "../src/BuyHelper.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IUsdcView {
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

/**
 * @notice Release-gate E2E on a Sepolia fork: deploys a FRESH stack (the exact
 *  hardened contracts to be shipped) bound to the canonical GToken/aPNTs, then
 *  exercises every new/changed behavior end-to-end against real tokens:
 *    1-2. buyTokensFor → AirAccount, paid with USDC and with USDT (#21 core)
 *    3.   capExempt: the trusted helper bypasses the per-person cap
 *    4.   non-exempt payer is still capped
 *    5.   executeBuy onlyRelayer: a non-relayer is rejected
 *    6.   gasless (EIP-3009 + BuyIntent via relayer) credits the AirAccount
 *
 *  Run:
 *    forge test --match-contract PathAHardeningForkTest \
 *      --fork-url $SEPOLIA_RPC_URL -vv
 */
contract PathAHardeningForkTest is Test {
    // Canonical Path-A tokens on Sepolia.
    address constant GTOKEN = 0x20a051502a7AE6e40cfFd6EBe59057538E698984;
    address constant APNTS  = 0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b;
    address constant USDC   = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address constant USDT   = 0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0;

    bytes32 constant RECEIVE_WITH_AUTH_TYPEHASH = keccak256(
        "ReceiveWithAuthorization(address from,address to,uint256 value,uint256 validAfter,uint256 validBefore,bytes32 nonce)"
    );

    SaleContractV2 saleGT;
    APNTsSaleContract saleAP;
    BuyHelper helper;

    address owner = makeAddr("owner");
    address treasury = makeAddr("treasury");
    address relayer = makeAddr("relayer");
    address airaccount = makeAddr("airaccount"); // recipient ≠ payer
    address payer;
    uint256 payerPk;

    function setUp() public {
        (payer, payerPk) = makeAddrAndKey("payer-eoa");

        vm.startPrank(owner);
        saleGT = new SaleContractV2(GTOKEN, treasury, owner);
        saleGT.setPaymentToken(USDC, true);
        saleGT.setPaymentToken(USDT, true);
        saleGT.setWhitelistRequired(false);

        saleAP = new APNTsSaleContract(APNTS, treasury, 20_000, owner);
        saleAP.setPaymentToken(USDC, true);
        saleAP.setPaymentToken(USDT, true);
        vm.stopPrank();

        address[] memory relayerSet = new address[](1);
        relayerSet[0] = relayer;
        helper = new BuyHelper(USDC, GTOKEN, APNTS, address(saleGT), address(saleAP), owner, relayerSet);
        vm.prank(owner);
        saleGT.setCapExempt(address(helper), true);

        // Inventory + funding via cheatcodes (real canonical tokens on the fork).
        deal(GTOKEN, address(saleGT), 1_000_000 * 1e18);
        deal(APNTS, address(saleAP), 1_000_000 * 1e18);
        deal(USDC, payer, 10_000 * 1e6);
        deal(USDT, payer, 10_000 * 1e6);
    }

    // ── 1. self-pay buyTokensFor with USDC → AirAccount ──────────────────────
    function test_e2e_buyTokensFor_USDC_to_airaccount() public {
        vm.startPrank(payer);
        IERC20(USDC).approve(address(saleGT), 150 * 1e6);
        uint256 out = saleGT.buyTokensFor(airaccount, 150 * 1e6, USDC, 0);
        vm.stopPrank();

        assertEq(out, 1000 * 1e18, "returns minted amount");
        assertEq(IERC20(GTOKEN).balanceOf(airaccount), 1000 * 1e18, "AirAccount receives GToken");
        assertEq(IERC20(GTOKEN).balanceOf(payer), 0, "payer receives none");
        assertEq(IERC20(USDC).balanceOf(treasury), 150 * 1e6, "treasury paid from payer");
    }

    // ── 2. self-pay buyTokensFor with USDT (no EIP-3009) → AirAccount [#21] ───
    function test_e2e_buyTokensFor_USDT_to_airaccount() public {
        vm.startPrank(payer);
        IERC20(USDT).approve(address(saleGT), 150 * 1e6);
        saleGT.buyTokensFor(airaccount, 150 * 1e6, USDT, 0);
        vm.stopPrank();

        assertEq(IERC20(GTOKEN).balanceOf(airaccount), 1000 * 1e18, "AirAccount receives GToken via USDT");
        assertEq(IERC20(USDT).balanceOf(treasury), 150 * 1e6, "treasury paid in USDT");
    }

    // ── 3. capExempt: trusted helper bypasses the per-person cap ──────────────
    function test_e2e_capExempt_helper_bypasses_cap() public {
        deal(USDC, address(helper), 2_000 * 1e6);
        vm.startPrank(address(helper));
        IERC20(USDC).approve(address(saleGT), type(uint256).max);
        saleGT.buyTokens(800 * 1e6, USDC, 0);
        saleGT.buyTokens(800 * 1e6, USDC, 0); // cumulative $1600 > $864 cap — exempt OK
        vm.stopPrank();
        assertGt(IERC20(GTOKEN).balanceOf(address(helper)), 0, "exempt helper buys past cap");
    }

    // ── 4. non-exempt payer is still capped ──────────────────────────────────
    function test_e2e_nonexempt_payer_capped() public {
        vm.startPrank(payer);
        IERC20(USDC).approve(address(saleGT), type(uint256).max);
        vm.expectRevert(); // ExceedsPerPersonCap ($864 default)
        saleGT.buyTokens(900 * 1e6, USDC, 0);
        vm.stopPrank();
    }

    // ── 5. executeBuy onlyRelayer ────────────────────────────────────────────
    function test_e2e_executeBuy_rejects_non_relayer() public {
        BuyHelper.BuyIntent memory intent;
        BuyHelper.TransferAuthExtras memory auth =
            BuyHelper.TransferAuthExtras({validAfter: 0, v: 27, r: bytes32(0), s: bytes32(0)});
        vm.prank(payer);
        vm.expectRevert(abi.encodeWithSelector(BuyHelper.NotRelayer.selector, payer));
        helper.executeBuy(intent, hex"", auth);
    }

    // ── 6. gasless via relayer (EIP-3009 + BuyIntent) → AirAccount ────────────
    function test_e2e_gasless_into_airaccount() public {
        uint256 paid = 15 * 1e6; // $15 → 100 GT
        bytes32 nonce = keccak256("gasless-nonce-1");
        BuyHelper.BuyIntent memory intent = BuyHelper.BuyIntent({
            buyer: payer,
            paymentToken: USDC,
            paymentAmount: paid,
            targetToken: GTOKEN,
            recipient: airaccount,
            minOut: 0,
            deadline: block.timestamp + 600,
            nonce: nonce
        });
        bytes memory sig = _signBuyIntent(payerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) =
            _signTransferAuth(payerPk, payer, address(helper), paid, 0, intent.deadline, nonce);

        vm.prank(relayer);
        helper.executeBuy(intent, sig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));

        assertEq(IERC20(GTOKEN).balanceOf(airaccount), 100 * 1e18, "gasless credits AirAccount");
        assertEq(IERC20(USDC).balanceOf(address(helper)), 0, "no leftover USDC in helper");
    }

    // ── signing helpers (same scheme as BuyHelper_ForkSepolia) ───────────────
    function _signTransferAuth(
        uint256 pk,
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce
    ) internal view returns (uint8 v, bytes32 r, bytes32 s) {
        bytes32 usdcDomain = IUsdcView(USDC).DOMAIN_SEPARATOR();
        bytes32 structHash =
            keccak256(abi.encode(RECEIVE_WITH_AUTH_TYPEHASH, from, to, value, validAfter, validBefore, nonce));
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", usdcDomain, structHash));
        (v, r, s) = vm.sign(pk, digest);
    }

    function _signBuyIntent(uint256 pk, BuyHelper.BuyIntent memory intent) internal view returns (bytes memory) {
        bytes32 digest = helper.hashBuyIntent(intent);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, digest);
        return abi.encodePacked(r, s, v);
    }
}
