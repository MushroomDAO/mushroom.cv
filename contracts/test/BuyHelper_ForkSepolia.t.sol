// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {BuyHelper} from "../src/BuyHelper.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IUsdcView {
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function authorizationState(address authorizer, bytes32 nonce) external view returns (bool);
}

/**
 * @notice Fork-Sepolia tests for BuyHelper — exercises the full EIP-3009 + BuyIntent flow
 *         against the *actual deployed* Mycelium contracts.
 *
 *  Run:
 *    forge test --match-contract BuyHelperForkSepoliaTest \
 *      --fork-url $SEPOLIA_RPC_URL2 -vv
 */
contract BuyHelperForkSepoliaTest is Test {
    // Current canonical deployed stack on Sepolia (Path A + buyTokensFor + hardening).
    // NOTE: this is a live-bound integration test; refresh these after each redeploy.
    address constant SALE_GT  = 0x86aC0278fAFA3Bf51e18426937A264e16B78bce4;
    address constant SALE_AP  = 0x1cE31924EE7e0296d6b739d0bC96B354CA55b30C;
    address constant GTOKEN   = 0x20a051502a7AE6e40cfFd6EBe59057538E698984;
    address constant APNTS    = 0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b;
    address constant USDC     = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;

    // EIP-3009 TransferWithAuthorization typehash (per USDC FiatTokenV2).
    bytes32 constant RECEIVE_WITH_AUTH_TYPEHASH = keccak256(
        "ReceiveWithAuthorization(address from,address to,uint256 value,uint256 validAfter,uint256 validBefore,bytes32 nonce)"
    );

    BuyHelper helper;

    // Buyer = synthetic EOA we control (with known privkey for signing).
    address buyer;
    uint256 buyerPk;

    // Recipient = different address for 代购 tests.
    address recipient;

    function setUp() public {
        (buyer, buyerPk) = makeAddrAndKey("buyer-eip3009-e2e");
        recipient = makeAddr("recipient-daigou");

        // relayer set = this test contract, so executeBuy calls (made by it) pass onlyRelayer.
        address[] memory relayers = new address[](1);
        relayers[0] = address(this);
        helper = new BuyHelper(USDC, GTOKEN, APNTS, SALE_GT, SALE_AP, address(this), relayers);

        // Fund buyer with USDC; no ETH on purpose (this is the gasless scenario).
        deal(USDC, buyer, 1000 * 1e6); // 1000 USDC
        assertEq(buyer.balance, 0, "buyer must have zero ETH");
    }

    // ─── helpers ────────────────────────────────────────────────────────────

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
        bytes32 structHash = keccak256(
            abi.encode(RECEIVE_WITH_AUTH_TYPEHASH, from, to, value, validAfter, validBefore, nonce)
        );
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", usdcDomain, structHash));
        (v, r, s) = vm.sign(pk, digest);
    }

    function _signBuyIntent(uint256 pk, BuyHelper.BuyIntent memory intent)
        internal view returns (bytes memory)
    {
        bytes32 digest = helper.hashBuyIntent(intent);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, digest);
        return abi.encodePacked(r, s, v);
    }

    function _makeIntent(
        address paymentToken,
        uint256 paymentAmount,
        address targetToken,
        address recipient_,
        uint256 minOut,
        bytes32 nonce
    ) internal view returns (BuyHelper.BuyIntent memory) {
        return BuyHelper.BuyIntent({
            buyer: buyer,
            paymentToken: paymentToken,
            paymentAmount: paymentAmount,
            targetToken: targetToken,
            recipient: recipient_,
            minOut: minOut,
            deadline: block.timestamp + 600,
            nonce: nonce
        });
    }

    // ─── A. Buy GToken, recipient = self ─────────────────────────────────────

    function test_buyGToken_recipientSelf() public {
        uint256 paid = 15 * 1e6; // $15
        bytes32 nonce = keccak256("nonce-A");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, GTOKEN, buyer, 0, nonce);
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        uint256 buyerGtBefore = IERC20(GTOKEN).balanceOf(buyer);
        uint256 buyerUsdcBefore = IERC20(USDC).balanceOf(buyer);

        // Relayer (anyone) calls executeBuy.
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));

        // GToken: 100 GT @ $0.15
        assertEq(IERC20(GTOKEN).balanceOf(buyer) - buyerGtBefore, 100 * 1e18, "buyer should receive 100 GT");
        assertEq(buyerUsdcBefore - IERC20(USDC).balanceOf(buyer), paid, "buyer should be debited 15 USDC");
        assertEq(IERC20(USDC).balanceOf(address(helper)), 0, "helper holds no leftover USDC");
        assertEq(IERC20(GTOKEN).balanceOf(address(helper)), 0, "helper holds no leftover GToken");
    }

    // ─── B. Buy aPNTs, recipient = self ──────────────────────────────────────

    function test_buyAPNTs_recipientSelf() public {
        uint256 paid = 10 * 1e6; // $10
        bytes32 nonce = keccak256("nonce-B");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, APNTS, buyer, 0, nonce);
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        uint256 apBefore = IERC20(APNTS).balanceOf(buyer);
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));

        // aPNTs: 500 at $0.02
        assertEq(IERC20(APNTS).balanceOf(buyer) - apBefore, 500 * 1e18, "buyer should receive 500 aPNTs");
    }

    // ─── C. 代购: A pays, B receives ──────────────────────────────────────────

    function test_buyGToken_recipientThirdParty() public {
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-C");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, GTOKEN, recipient, 0, nonce);
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        assertEq(IERC20(GTOKEN).balanceOf(buyer), 0, "buyer pre = 0");
        assertEq(IERC20(GTOKEN).balanceOf(recipient), 0, "recipient pre = 0");

        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));

        assertEq(IERC20(GTOKEN).balanceOf(buyer), 0, "buyer keeps nothing");
        assertEq(IERC20(GTOKEN).balanceOf(recipient), 100 * 1e18, "recipient gets 100 GT");
    }

    // ─── D. Replay blocked (USDC enforces single-use nonce) ─────────────────

    function test_replay_blocked() public {
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-D");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, GTOKEN, buyer, 0, nonce);
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));

        // USDC's _authorizationStates marks nonce as used; second call must revert.
        assertTrue(IUsdcView(USDC).authorizationState(buyer, nonce), "nonce consumed in USDC");
        vm.expectRevert();
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));
    }

    // ─── E. Wrong buyer signs BuyIntent → reverts ───────────────────────────

    function test_buyIntent_wrong_signer_reverts() public {
        (, uint256 otherPk) = makeAddrAndKey("attacker");
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-E");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, GTOKEN, buyer, 0, nonce);
        // BuyIntent signed by attacker, not buyer
        bytes memory intentSig = _signBuyIntent(otherPk, intent);
        // Transfer auth still signed by the real buyer (otherwise USDC rejects first)
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        vm.expectRevert(); // InvalidBuyIntentSigner
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));
    }

    // ─── F. Expired deadline → reverts ──────────────────────────────────────

    function test_expired_reverts() public {
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-F");
        BuyHelper.BuyIntent memory intent = BuyHelper.BuyIntent({
            buyer: buyer,
            paymentToken: USDC,
            paymentAmount: paid,
            targetToken: GTOKEN,
            recipient: buyer,
            minOut: 0,
            deadline: block.timestamp - 1, // already expired
            nonce: nonce
        });
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        vm.expectRevert(); // Expired
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));
    }

    // ─── G. minOut slippage protection ──────────────────────────────────────

    function test_belowMinOut_reverts() public {
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-G");
        // Demand 101 GT but $15 only buys 100 GT at $0.15
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, GTOKEN, buyer, 101 * 1e18, nonce);
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        // SaleContractV2 has its own SlippageExceeded check first; either revert is fine.
        vm.expectRevert();
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));
    }

    // ─── H. Unsupported targetToken → reverts ────────────────────────────────

    function test_unsupportedTarget_reverts() public {
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-H");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, USDC, buyer, 0, nonce); // target = USDC (invalid)
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        vm.expectRevert(); // UnsupportedTargetToken
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));
    }

    // ─── I. Zero recipient → reverts ────────────────────────────────────────

    function test_zeroRecipient_reverts() public {
        uint256 paid = 15 * 1e6;
        bytes32 nonce = keccak256("nonce-I");
        BuyHelper.BuyIntent memory intent = _makeIntent(USDC, paid, GTOKEN, address(0), 0, nonce);
        bytes memory intentSig = _signBuyIntent(buyerPk, intent);
        (uint8 v, bytes32 r, bytes32 s) = _signTransferAuth(
            buyerPk, buyer, address(helper), paid, 0, intent.deadline, nonce
        );

        vm.expectRevert(); // ZeroRecipient
        helper.executeBuy(intent, intentSig, BuyHelper.TransferAuthExtras({validAfter: 0, v: v, r: r, s: s}));
    }
}
