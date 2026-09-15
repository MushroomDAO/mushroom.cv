// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title BuyHelper
 * @notice Gasless purchase helper for Mycelium SaleContractV2 / APNTsSaleContract.
 *
 *   Flow:
 *     1. User signs EIP-3009 `TransferWithAuthorization` against USDC: pays N USDC from
 *        themselves to this BuyHelper. (Standard `eth_signTypedData_v4`, MetaMask-friendly.)
 *     2. User signs `BuyIntent` (our own EIP-712 typed-data) committing to:
 *        {paymentToken, paymentAmount, targetToken, recipient, minOut, deadline, nonce}.
 *     3. Relayer submits a single Type-2 (EIP-1559) tx calling `executeBuy(...)`:
 *          a. Verifies the BuyIntent signature (signer must == buyer).
 *          b. Calls USDC.transferWithAuthorization → pulls USDC from buyer to this contract.
 *          c. Approves the relevant sale contract and calls its buy function.
 *          d. Forwards the purchased token to `recipient` (defaults to buyer; can be a third
 *             party for "代购" / gift purchases).
 *
 *   No EIP-7702. No smart account. Works with any wallet that supports `signTypedData_v4`
 *   (MetaMask, Rabby, OKX, Coinbase Wallet, hardware wallets, embedded wallets, ...).
 *
 *   Replay protection: USDC's own `_authorizationStates` mapping marks `nonce` as used on
 *   first call; second submission of the same EIP-3009 signature reverts in USDC. Our
 *   BuyIntent nonce is bound to the same `nonce` for symmetry (any reuse is dead on arrival
 *   because USDC rejects it).
 */
interface IUSDC {
    // receiveWithAuthorization (not transferWithAuthorization): it requires
    // msg.sender == to, so only this contract (inside executeBuy) can consume the
    // buyer's EIP-3009 signature — a front-runner cannot submit it directly to USDC.
    function receiveWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}

interface ISaleContractV2 {
    function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut) external;
}

interface IAPNTsSale {
    function buyAPNTs(uint256 usdAmount, address paymentToken) external;
}

contract BuyHelper is ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;

    // =============================================================
    //                       IMMUTABLES
    // =============================================================

    address public immutable USDC;
    address public immutable GTOKEN;
    address public immutable APNTS;
    address public immutable SALE_GT;
    address public immutable SALE_AP;

    bytes32 public immutable DOMAIN_SEPARATOR;

    /// @notice Whitelisted relayer operators allowed to call executeBuy. The helper
    /// is cap-exempt on the sale, so a public entry would let anyone bypass the
    /// per-person cap; only these trusted DVT relay operators may submit. Owner can
    /// add/remove to rotate hot wallets or onboard new DVT nodes without redeploying.
    mapping(address => bool) public isRelayer;

    // =============================================================
    //                        CONSTANTS
    // =============================================================

    string public constant NAME = "MyceliumBuyHelper";
    string public constant VERSION = "1";

    /// keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
    bytes32 public constant DOMAIN_TYPEHASH =
        0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f;

    /// keccak256("BuyIntent(address buyer,address paymentToken,uint256 paymentAmount,address targetToken,address recipient,uint256 minOut,uint256 deadline,bytes32 nonce)")
    bytes32 public constant BUY_INTENT_TYPEHASH = keccak256(
        "BuyIntent(address buyer,address paymentToken,uint256 paymentAmount,address targetToken,address recipient,uint256 minOut,uint256 deadline,bytes32 nonce)"
    );

    // =============================================================
    //                          EVENTS
    // =============================================================

    event BuyExecuted(
        address indexed buyer,
        address indexed targetToken,
        address indexed recipient,
        uint256 paymentAmount,
        uint256 receivedAmount
    );
    event RelayerUpdated(address indexed relayer, bool allowed);

    // =============================================================
    //                          ERRORS
    // =============================================================

    error UnsupportedPaymentToken(address paymentToken);
    error UnsupportedTargetToken(address targetToken);
    error ZeroRecipient();
    error Expired(uint256 deadline, uint256 nowTs);
    error InvalidSignatureLength(uint256 length);
    error InvalidBuyIntentSigner(address recovered, address expected);
    error BelowMinOut(uint256 received, uint256 minOut);
    error NotRelayer(address caller);
    error ZeroRelayer();

    // =============================================================
    //                       CONSTRUCTOR
    // =============================================================

    constructor(
        address usdc,
        address gtoken,
        address apnts,
        address saleGT,
        address saleAP,
        address initialOwner,
        address[] memory relayers
    ) Ownable(initialOwner) {
        USDC = usdc;
        GTOKEN = gtoken;
        APNTS = apnts;
        SALE_GT = saleGT;
        SALE_AP = saleAP;
        for (uint256 i = 0; i < relayers.length; i++) {
            if (relayers[i] == address(0)) revert ZeroRelayer();
            isRelayer[relayers[i]] = true;
            emit RelayerUpdated(relayers[i], true);
        }

        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes(NAME)),
                keccak256(bytes(VERSION)),
                block.chainid,
                address(this)
            )
        );
    }

    // =============================================================
    //                          STRUCTS
    // =============================================================

    struct BuyIntent {
        address buyer;
        address paymentToken;
        uint256 paymentAmount;
        address targetToken;
        address recipient;
        uint256 minOut;
        uint256 deadline;
        bytes32 nonce;
    }

    struct TransferAuthExtras {
        uint256 validAfter;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    // =============================================================
    //                       MAIN ENTRY
    // =============================================================

    /**
     * @notice Execute a gasless buy.
     * @param intent          The buy intent (signed by buyer via EIP-712).
     * @param buyIntentSig    65-byte ECDSA signature (r||s||v) over the BuyIntent digest.
     * @param transferAuth    Extras needed for USDC.transferWithAuthorization
     *                        (validAfter + v/r/s; the rest of params come from `intent`).
     *
     * @dev The relayer must pass the buyer's EIP-3009 USDC signature in `transferAuth`.
     *      `intent.deadline` is used as `validBefore`. `intent.nonce` is used as the
     *      EIP-3009 nonce — so the same nonce protects both replay surfaces.
     */
    function executeBuy(
        BuyIntent calldata intent,
        bytes calldata buyIntentSig,
        TransferAuthExtras calldata transferAuth
    ) external nonReentrant {
        // 0. Access control: only a whitelisted relayer may submit. The helper is
        // cap-exempt on the sale, so a public entry would let anyone bypass the
        // per-person cap. Per-buyer limits are enforced by the relayer off-chain.
        if (!isRelayer[msg.sender]) revert NotRelayer(msg.sender);

        // 1. Sanity checks
        if (intent.paymentToken != USDC) revert UnsupportedPaymentToken(intent.paymentToken);
        if (intent.targetToken != GTOKEN && intent.targetToken != APNTS) {
            revert UnsupportedTargetToken(intent.targetToken);
        }
        if (intent.recipient == address(0)) revert ZeroRecipient();
        if (block.timestamp > intent.deadline) revert Expired(intent.deadline, block.timestamp);
        if (buyIntentSig.length != 65) revert InvalidSignatureLength(buyIntentSig.length);

        // 2. Verify BuyIntent signature
        bytes32 digest = _hashBuyIntent(intent);
        address recovered = _recover(digest, buyIntentSig);
        if (recovered != intent.buyer) revert InvalidBuyIntentSigner(recovered, intent.buyer);

        // 3. Pull USDC from buyer via EIP-3009 receiveWithAuthorization. Because
        // receiveWithAuthorization enforces msg.sender == to (== this contract),
        // the buyer's signed authorization cannot be front-run / replayed directly
        // against USDC by anyone else — closing the "funds stranded in helper" grief.
        // (USDC verifies the signature itself; the signed typed-data is
        // ReceiveWithAuthorization, so the buyer/SDK must sign that primaryType.)
        IUSDC(USDC).receiveWithAuthorization(
            intent.buyer,
            address(this),
            intent.paymentAmount,
            transferAuth.validAfter,
            intent.deadline,
            intent.nonce,
            transferAuth.v,
            transferAuth.r,
            transferAuth.s
        );

        // 4. Approve sale contract + call its buy function
        address sale = intent.targetToken == GTOKEN ? SALE_GT : SALE_AP;
        IERC20(USDC).forceApprove(sale, intent.paymentAmount);

        uint256 balanceBefore = IERC20(intent.targetToken).balanceOf(address(this));
        if (intent.targetToken == GTOKEN) {
            ISaleContractV2(sale).buyTokens(intent.paymentAmount, USDC, intent.minOut);
        } else {
            // APNTsSaleContract doesn't take minOut; we enforce slippage in step 5 below.
            IAPNTsSale(sale).buyAPNTs(intent.paymentAmount, USDC);
        }

        // 5. Forward ONLY the freshly purchased amount (balance delta) to recipient,
        // so any token pre-stranded in this contract isn't mis-delivered and minOut /
        // the emitted amount stay accurate. targetToken is constrained to GTOKEN/APNTS
        // (checked in step 1) — both standard, non-fee-on-transfer ERC20s — so the
        // delta equals exactly what the recipient receives.
        uint256 received = IERC20(intent.targetToken).balanceOf(address(this)) - balanceBefore;
        if (received < intent.minOut) revert BelowMinOut(received, intent.minOut);
        IERC20(intent.targetToken).safeTransfer(intent.recipient, received);

        emit BuyExecuted(
            intent.buyer,
            intent.targetToken,
            intent.recipient,
            intent.paymentAmount,
            received
        );
    }

    // =============================================================
    //                    RELAYER MANAGEMENT
    // =============================================================

    /// @notice Add a relayer operator to the whitelist. Owner-only.
    function addRelayer(address relayer) external onlyOwner {
        if (relayer == address(0)) revert ZeroRelayer();
        isRelayer[relayer] = true;
        emit RelayerUpdated(relayer, true);
    }

    /// @notice Remove a relayer operator from the whitelist. Owner-only.
    function removeRelayer(address relayer) external onlyOwner {
        isRelayer[relayer] = false;
        emit RelayerUpdated(relayer, false);
    }

    /// @notice Recover any ERC20 stranded in this contract to `to`. Owner-only
    /// defense-in-depth — the contract should hold no balance between buys, but this
    /// covers accidental transfers or any edge that leaves funds parked here.
    function sweepToken(address token, address to) external onlyOwner {
        if (to == address(0)) revert ZeroRecipient();
        IERC20(token).safeTransfer(to, IERC20(token).balanceOf(address(this)));
    }

    // =============================================================
    //                    HASHING / RECOVERY
    // =============================================================

    function hashBuyIntent(BuyIntent calldata intent) external view returns (bytes32) {
        return _hashBuyIntent(intent);
    }

    function _hashBuyIntent(BuyIntent calldata intent) internal view returns (bytes32) {
        bytes32 structHash = keccak256(
            abi.encode(
                BUY_INTENT_TYPEHASH,
                intent.buyer,
                intent.paymentToken,
                intent.paymentAmount,
                intent.targetToken,
                intent.recipient,
                intent.minOut,
                intent.deadline,
                intent.nonce
            )
        );
        return keccak256(abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, structHash));
    }

    function _recover(bytes32 digest, bytes calldata signature) internal pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := calldataload(signature.offset)
            s := calldataload(add(signature.offset, 32))
            v := byte(0, calldataload(add(signature.offset, 64)))
        }
        if (v < 27) v += 27;
        // EIP-2 low-s enforcement
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return address(0);
        }
        return ecrecover(digest, v, r, s);
    }
}
