// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {AirAccountDelegate} from "../src/AirAccountDelegate.sol";

/// @dev Simple target contract for testing batch calls.
contract Counter {
    uint256 public count;
    function inc() external payable { count++; }
    function add(uint256 n) external { count += n; }
    function boom() external pure { revert("nope"); }
}

contract AirAccountDelegateTest is Test {
    AirAccountDelegate logic;
    Counter counter;

    // Test EOA — we'll etch the delegate code onto this address to simulate EIP-7702.
    address eoa;
    uint256 eoaPk;

    function setUp() public {
        // Deploy the logic contract (we'll never call it directly — only via etched copy).
        logic = new AirAccountDelegate();
        counter = new Counter();

        // Create a test EOA with a known private key.
        (eoa, eoaPk) = makeAddrAndKey("eoa");

        // Simulate EIP-7702: copy delegate's code onto the EOA address.
        vm.etch(eoa, address(logic).code);
        // Fund the EOA with some ETH for `value`-bearing calls.
        vm.deal(eoa, 10 ether);
    }

    // ─── helpers ─────────────────────────────────────────────────────────────

    function _sign(
        AirAccountDelegate.Call[] memory calls,
        uint256 nonce,
        uint256 deadline
    ) internal view returns (bytes memory) {
        bytes32 digest = _digest(calls, nonce, deadline);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(eoaPk, digest);
        return abi.encodePacked(r, s, v);
    }

    function _digest(
        AirAccountDelegate.Call[] memory calls,
        uint256 nonce,
        uint256 deadline
    ) internal view returns (bytes32) {
        // Compute Call[] hash array.
        bytes32 CALL_TYPEHASH = keccak256("Call(address target,uint256 value,bytes data)");
        bytes32[] memory callHashes = new bytes32[](calls.length);
        for (uint256 i = 0; i < calls.length; i++) {
            callHashes[i] = keccak256(
                abi.encode(CALL_TYPEHASH, calls[i].target, calls[i].value, keccak256(calls[i].data))
            );
        }
        bytes32 EXECUTE_BATCH_TYPEHASH = keccak256(
            "ExecuteBatch(Call[] calls,uint256 nonce,uint256 deadline)Call(address target,uint256 value,bytes data)"
        );
        bytes32 structHash = keccak256(
            abi.encode(
                EXECUTE_BATCH_TYPEHASH,
                keccak256(abi.encodePacked(callHashes)),
                nonce,
                deadline
            )
        );
        bytes32 DOMAIN_TYPEHASH = keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );
        bytes32 domSep = keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes("AirAccountDelegate")),
                keccak256(bytes("1")),
                block.chainid,
                address(logic) // verifyingContract = IMPLEMENTATION address (constant; MM-compatible)
            )
        );
        return keccak256(abi.encodePacked("\x19\x01", domSep, structHash));
    }

    function _single(address target, uint256 value, bytes memory data)
        internal pure returns (AirAccountDelegate.Call[] memory)
    {
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](1);
        calls[0] = AirAccountDelegate.Call({target: target, value: value, data: data});
        return calls;
    }

    // ─── happy path ──────────────────────────────────────────────────────────

    function test_executeBatch_single_call() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory sig = _sign(calls, 0, deadline);

        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);

        assertEq(counter.count(), 1);
        assertEq(AirAccountDelegate(payable(eoa)).nonce(), 1);
    }

    function test_executeBatch_with_value() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0.5 ether, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory sig = _sign(calls, 0, deadline);

        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);

        assertEq(counter.count(), 1);
        assertEq(address(counter).balance, 0.5 ether);
    }

    function test_executeBatch_multi_call() public {
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](3);
        calls[0] = AirAccountDelegate.Call(address(counter), 0, abi.encodeWithSelector(Counter.inc.selector));
        calls[1] = AirAccountDelegate.Call(address(counter), 0, abi.encodeWithSelector(Counter.add.selector, 10));
        calls[2] = AirAccountDelegate.Call(address(counter), 0, abi.encodeWithSelector(Counter.inc.selector));
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory sig = _sign(calls, 0, deadline);

        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);

        assertEq(counter.count(), 12);
    }

    // ─── replay & nonce ──────────────────────────────────────────────────────

    function test_replay_blocked_by_nonce() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory sig = _sign(calls, 0, deadline);

        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);
        assertEq(AirAccountDelegate(payable(eoa)).nonce(), 1);

        // Second attempt with the same nonce-0 signature must fail.
        vm.expectRevert(); // signer mismatch (digest is for nonce 0 but contract now expects nonce 1)
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);
    }

    function test_sequential_calls_with_fresh_nonces() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;

        for (uint256 i = 0; i < 5; i++) {
            bytes memory sig = _sign(calls, i, deadline);
            AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);
        }

        assertEq(counter.count(), 5);
        assertEq(AirAccountDelegate(payable(eoa)).nonce(), 5);
    }

    // ─── validation errors ───────────────────────────────────────────────────

    function test_expired_deadline_reverts() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp - 1;
        bytes memory sig = _sign(calls, 0, deadline);

        vm.expectRevert(
            abi.encodeWithSelector(
                AirAccountDelegate.ExpiredDeadline.selector, deadline, block.timestamp
            )
        );
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);
    }

    function test_empty_calls_reverts() public {
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](0);
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory sig = _sign(calls, 0, deadline);

        vm.expectRevert(AirAccountDelegate.EmptyCalls.selector);
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);
    }

    function test_invalid_signature_length_reverts() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory badSig = hex"deadbeef"; // 4 bytes

        vm.expectRevert(
            abi.encodeWithSelector(AirAccountDelegate.InvalidSignatureLength.selector, 4)
        );
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, badSig);
    }

    function test_wrong_signer_reverts() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes32 digest = _digest(calls, 0, deadline);

        // Sign with a DIFFERENT key (attacker).
        (, uint256 attackerPk) = makeAddrAndKey("attacker");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(attackerPk, digest);
        bytes memory wrongSig = abi.encodePacked(r, s, v);

        vm.expectRevert();
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, wrongSig);
    }

    function test_failed_call_reverts_with_index() public {
        AirAccountDelegate.Call[] memory calls = new AirAccountDelegate.Call[](2);
        calls[0] = AirAccountDelegate.Call(address(counter), 0, abi.encodeWithSelector(Counter.inc.selector));
        calls[1] = AirAccountDelegate.Call(address(counter), 0, abi.encodeWithSelector(Counter.boom.selector));
        uint256 deadline = block.timestamp + 1 hours;
        bytes memory sig = _sign(calls, 0, deadline);

        vm.expectRevert(); // CallFailed(1, ...)
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, sig);

        // counter.inc was rolled back too (whole tx reverts).
        assertEq(counter.count(), 0);
    }

    // ─── ETH receive ─────────────────────────────────────────────────────────

    function test_receive_eth() public {
        (bool ok, ) = eoa.call{value: 1 ether}("");
        assertTrue(ok);
        assertEq(eoa.balance, 11 ether);
    }

    // ─── helpers exposed ─────────────────────────────────────────────────────

    function test_hashExecuteBatch_view_matches_offchain() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;

        bytes32 onchain = AirAccountDelegate(payable(eoa)).hashExecuteBatch(calls, 0, deadline);
        bytes32 offchain = _digest(calls, 0, deadline);
        assertEq(onchain, offchain);
    }

    function test_domain_separator_uses_implementation_address() public view {
        // Pinned to IMPLEMENTATION so MetaMask (which blocks signing when
        // verifyingContract == one of the user's accounts) accepts it.
        bytes32 sep = AirAccountDelegate(payable(eoa)).domainSeparator();
        bytes32 DOMAIN_TYPEHASH = keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );
        bytes32 expected = keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes("AirAccountDelegate")),
                keccak256(bytes("1")),
                block.chainid,
                address(logic)
            )
        );
        assertEq(sep, expected);
        // Sanity: IMPLEMENTATION() view returns the same constant from both copies.
        assertEq(AirAccountDelegate(payable(eoa)).IMPLEMENTATION(), address(logic));
    }

    function test_version_strings() public view {
        assertEq(AirAccountDelegate(payable(eoa)).NAME(), "AirAccountDelegate");
        assertEq(AirAccountDelegate(payable(eoa)).VERSION(), "1");
    }

    // ─── Codex gap fixes: low-s & invalid v ────────────────────────────────

    function test_executeBatch_rejects_high_s_signature() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes32 digest = _digest(calls, 0, deadline);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(eoaPk, digest);

        // Flip s into the high-s half (EIP-2 disallowed).
        // secp256k1 N = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141
        bytes32 N = bytes32(uint256(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141));
        bytes32 highS = bytes32(uint256(N) - uint256(s));
        // Flipping s also flips v parity to keep the same valid signer pair.
        uint8 newV = v == 27 ? 28 : 27;
        bytes memory malleable = abi.encodePacked(r, highS, newV);

        // Contract's _recoverEcdsa returns address(0) on high-s → InvalidSigner reverts
        vm.expectRevert();
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, malleable);
    }

    function test_executeBatch_rejects_invalid_v_ecrecover_zero() public {
        AirAccountDelegate.Call[] memory calls = _single(
            address(counter), 0, abi.encodeWithSelector(Counter.inc.selector)
        );
        uint256 deadline = block.timestamp + 1 hours;
        bytes32 digest = _digest(calls, 0, deadline);
        (, bytes32 r, bytes32 s) = vm.sign(eoaPk, digest);

        // Pass v = 0 — _recoverEcdsa normalizes v<27 to v+27, so v=0 becomes v=27
        // which still might recover a valid (but wrong) signer.
        // To reliably test ecrecover→0, use v=99 (out of range) which ecrecover rejects.
        bytes memory invalidV = abi.encodePacked(r, s, uint8(99));

        vm.expectRevert();
        AirAccountDelegate(payable(eoa)).executeBatch(calls, deadline, invalidV);
    }
}
