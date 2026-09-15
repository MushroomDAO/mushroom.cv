// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

/**
 * @title AirAccountDelegate
 * @author Mycelium Protocol
 * @notice Minimal EIP-7702 delegation target for gasless purchases.
 *
 * @dev Design model:
 *   An EOA signs an EIP-7702 Authorization to delegate to this contract.
 *   After delegation, the EOA's address has THIS contract's CODE but the EOA's STORAGE.
 *
 *   Once delegated, anyone (e.g. relayer) can call `EOA.executeBatch(calls, deadline, signature)`.
 *   Authorization comes from the EOA-signed EIP-712 `ExecuteBatch` digest, which is verified
 *   against `address(this)` — which IS the EOA when delegated. This means: only the EOA's
 *   private key can authorize batches against its own delegated address.
 *
 *   EIP-712 domain.verifyingContract = the immutable IMPLEMENTATION address (NOT the EOA).
 *   Why: MetaMask refuses to sign typed data whose `verifyingContract` equals one of the
 *   wallet's own accounts (phishing protection introduced in MM 11.x). By pinning the
 *   domain to the implementation contract address (baked into the bytecode at deploy
 *   time via `address(this)` in the constructor), both off-chain signer and on-chain
 *   verifier agree on the same constant, and MetaMask allows the signature.
 *
 *   Replay protection:
 *     - per-EOA `nonce` (stored on EOA's storage slot 0 of THIS contract)
 *     - `deadline` enforces expiration
 *
 *   No owner / no upgrade — fully immutable. Once an EOA delegates to this address,
 *   the rules can never change (this is the right tradeoff for user sovereignty).
 *
 *   To revoke: the EOA signs a new EIP-7702 Authorization with `contract = address(0)`.
 *   That tx clears the delegation. This contract has no `revoke()` function because
 *   revocation lives in the EIP-7702 protocol layer, not in user code.
 */
contract AirAccountDelegate {

    // =============================================================
    //                         CONSTANTS
    // =============================================================

    string public constant NAME = "AirAccountDelegate";
    string public constant VERSION = "1";

    /// @dev EIP-712 typehash for ExecuteBatch.
    /// keccak256("ExecuteBatch(Call[] calls,uint256 nonce,uint256 deadline)Call(address target,uint256 value,bytes data)")
    bytes32 public constant EXECUTE_BATCH_TYPEHASH = keccak256(
        "ExecuteBatch(Call[] calls,uint256 nonce,uint256 deadline)Call(address target,uint256 value,bytes data)"
    );

    /// @dev EIP-712 typehash for the inner Call struct.
    /// keccak256("Call(address target,uint256 value,bytes data)")
    bytes32 public constant CALL_TYPEHASH = keccak256(
        "Call(address target,uint256 value,bytes data)"
    );

    /// @dev EIP-712 domain typehash (no salt).
    /// keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
    bytes32 public constant DOMAIN_TYPEHASH = keccak256(
        "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
    );

    // =============================================================
    //                        IMMUTABLES
    // =============================================================

    /// @notice The implementation contract address — used as `verifyingContract` in the
    ///         EIP-712 domain. Set once at construction (= original deployment address),
    ///         and baked into the runtime bytecode so it stays constant even when this
    ///         code runs under an EOA via EIP-7702.
    address public immutable IMPLEMENTATION;

    constructor() {
        IMPLEMENTATION = address(this);
    }

    // =============================================================
    //                          STORAGE
    // =============================================================

    /// @notice Per-EOA execution nonce. Increments on every successful executeBatch.
    /// @dev When delegated via EIP-7702, this storage slot lives on the EOA, not on the
    ///      logic contract. So each EOA has its own counter.
    uint256 public nonce;

    // =============================================================
    //                         STRUCTS
    // =============================================================

    struct Call {
        address target;
        uint256 value;
        bytes data;
    }

    // =============================================================
    //                          EVENTS
    // =============================================================

    event BatchExecuted(uint256 indexed newNonce, uint256 numCalls);

    // =============================================================
    //                          ERRORS
    // =============================================================

    error ExpiredDeadline(uint256 deadline, uint256 nowTs);
    error InvalidSignatureLength(uint256 length);
    error InvalidSigner(address recovered, address expected);
    error CallFailed(uint256 index, bytes returnData);
    error EmptyCalls();

    // =============================================================
    //                  EXECUTE (THE ONE PUBLIC ENTRY)
    // =============================================================

    /**
     * @notice Execute a batch of calls on behalf of the delegated EOA.
     * @dev The signature must be over the EIP-712 hash of ExecuteBatch, signed by the
     *      EOA's private key (i.e. recoverable address == address(this) when delegated).
     * @param calls     Array of {target, value, data} calls to execute sequentially.
     * @param deadline  Unix timestamp after which the signature is rejected.
     * @param signature 65-byte ECDSA signature (r || s || v) over the EIP-712 digest.
     */
    function executeBatch(
        Call[] calldata calls,
        uint256 deadline,
        bytes calldata signature
    ) external payable {
        // 1. Cheap checks first.
        if (block.timestamp > deadline) revert ExpiredDeadline(deadline, block.timestamp);
        if (calls.length == 0) revert EmptyCalls();
        if (signature.length != 65) revert InvalidSignatureLength(signature.length);

        // 2. Compute the EIP-712 digest.
        bytes32 digest = _hashExecuteBatch(calls, nonce, deadline);

        // 3. Recover signer.
        address recovered = _recoverEcdsa(digest, signature);
        if (recovered != address(this)) revert InvalidSigner(recovered, address(this));

        // 4. Bump nonce BEFORE external calls (CEI).
        uint256 newNonce = nonce + 1;
        nonce = newNonce;

        // 5. Execute calls.
        for (uint256 i = 0; i < calls.length; i++) {
            (bool ok, bytes memory ret) = calls[i].target.call{value: calls[i].value}(calls[i].data);
            if (!ok) revert CallFailed(i, ret);
        }

        emit BatchExecuted(newNonce, calls.length);
    }

    // =============================================================
    //                     HASHING HELPERS (view)
    // =============================================================

    /// @notice Returns the EIP-712 domain separator. Pinned to IMPLEMENTATION so MetaMask
    ///         (which blocks signing where `verifyingContract` is one of the user's own
    ///         accounts) will accept the request.
    function domainSeparator() public view returns (bytes32) {
        return keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes(NAME)),
                keccak256(bytes(VERSION)),
                block.chainid,
                IMPLEMENTATION
            )
        );
    }

    /// @notice Returns the typed-data hash for an ExecuteBatch authorization.
    /// @dev Use this to construct the digest the user should sign off-chain.
    function hashExecuteBatch(
        Call[] calldata calls,
        uint256 _nonce,
        uint256 deadline
    ) external view returns (bytes32) {
        return _hashExecuteBatch(calls, _nonce, deadline);
    }

    function _hashExecuteBatch(
        Call[] calldata calls,
        uint256 _nonce,
        uint256 deadline
    ) internal view returns (bytes32) {
        // Hash the Call[] array (per EIP-712 array hashing rules).
        bytes32[] memory callHashes = new bytes32[](calls.length);
        for (uint256 i = 0; i < calls.length; i++) {
            callHashes[i] = keccak256(
                abi.encode(
                    CALL_TYPEHASH,
                    calls[i].target,
                    calls[i].value,
                    keccak256(calls[i].data)
                )
            );
        }
        bytes32 structHash = keccak256(
            abi.encode(
                EXECUTE_BATCH_TYPEHASH,
                keccak256(abi.encodePacked(callHashes)),
                _nonce,
                deadline
            )
        );
        return keccak256(abi.encodePacked("\x19\x01", domainSeparator(), structHash));
    }

    // =============================================================
    //                  ECDSA RECOVERY (no external lib)
    // =============================================================

    function _recoverEcdsa(bytes32 digest, bytes calldata signature) internal pure returns (address) {
        // 65-byte signature: r (32) || s (32) || v (1)
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := calldataload(signature.offset)
            s := calldataload(add(signature.offset, 32))
            v := byte(0, calldataload(add(signature.offset, 64)))
        }
        // Normalize v if compact (27/28 vs 0/1)
        if (v < 27) v += 27;
        // EIP-2 low-s enforcement (reject malleable signatures).
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return address(0);
        }
        return ecrecover(digest, v, r, s);
    }

    // =============================================================
    //                       RECEIVE / FALLBACK
    // =============================================================

    /// @notice Accept ETH (in case a delegated EOA needs to receive ETH).
    receive() external payable {}
}
