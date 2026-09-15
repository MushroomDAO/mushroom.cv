/**
 * @file verify712.ts
 * @description
 *   Off-chain EIP-712 verification of the buyer's ExecuteBatch signature.
 *   Mirrors the on-chain `AirAccountDelegate._recoverEcdsa()` so we can reject
 *   bad/expired signatures *before* spending gas to submit a Type-4 tx.
 *
 *   On-chain is still authoritative — this is a fast-fail gate only.
 */

import {
  recoverTypedDataAddress,
  type Address,
  type Hex,
  type TypedDataDomain,
  getAddress,
} from 'viem'
import type { Call } from './extractIntent.js'

/**
 * EIP-712 typed data for the ExecuteBatch primary type.
 *
 * Mirrors AirAccountDelegate.sol typehash:
 *   ExecuteBatch(Call[] calls, uint256 nonce, uint256 deadline)
 *   Call(address target, uint256 value, bytes data)
 */
export const EXECUTE_BATCH_TYPES = {
  ExecuteBatch: [
    { name: 'calls', type: 'Call[]' },
    { name: 'nonce', type: 'uint256' },
    { name: 'deadline', type: 'uint256' },
  ],
  Call: [
    { name: 'target', type: 'address' },
    { name: 'value', type: 'uint256' },
    { name: 'data', type: 'bytes' },
  ],
} as const

export type VerifyParams = {
  /** EOA expected to have signed. */
  buyer: Address
  /** Chain id (Sepolia = 11155111). */
  chainId: number
  /** AirAccountDelegate IMPLEMENTATION address — pinned `verifyingContract`.
   *  Must equal the deployed delegate contract address; the on-chain
   *  AirAccountDelegate.domainSeparator() bakes this in as an immutable
   *  (so MetaMask doesn't refuse to sign — MM blocks typed data where
   *  `verifyingContract` equals one of the user's own accounts). */
  verifyingContract: Address
  /** Batched calls. */
  calls: Call[]
  /** The buyer's expected nonce (relayer reads from chain or trusts intent). */
  nonce: bigint
  /** Unix-timestamp expiration for the signature. */
  deadline: bigint
  /** 65-byte ECDSA signature in r || s || v form. */
  signature: Hex
}

export type VerifyResult =
  | { ok: true; recovered: Address }
  | { ok: false; reason: string }

/** Build the EIP-712 domain matching AirAccountDelegate.domainSeparator(). */
export function buildDomain(chainId: number, verifyingContract: Address): TypedDataDomain {
  return {
    name: 'AirAccountDelegate',
    version: '1',
    chainId,
    verifyingContract,
  }
}

/**
 * Verify an ExecuteBatch signature off-chain.
 *
 * `verifyingContract` MUST equal the deployed AirAccountDelegate implementation
 * address (the contract's `IMPLEMENTATION` immutable, baked into runtime
 * bytecode). The relayer enforces this in its caller (handleV2Relay), so this
 * function just trusts the value passed in.
 */
export async function verifyExecuteBatchSignature(
  params: VerifyParams,
): Promise<VerifyResult> {
  if (params.calls.length === 0) {
    return { ok: false, reason: 'empty calls' }
  }
  if (params.signature.length !== 132) {
    return { ok: false, reason: `signature must be 65 bytes (0x + 130 hex chars), got ${params.signature.length}` }
  }
  // Deadline check (cheap, do early).
  const nowSec = BigInt(Math.floor(Date.now() / 1000))
  if (params.deadline < nowSec) {
    return { ok: false, reason: `deadline ${params.deadline} is in the past (now=${nowSec})` }
  }

  try {
    const recovered = await recoverTypedDataAddress({
      domain: buildDomain(params.chainId, params.verifyingContract),
      types: EXECUTE_BATCH_TYPES,
      primaryType: 'ExecuteBatch',
      message: {
        calls: params.calls,
        nonce: params.nonce,
        deadline: params.deadline,
      },
      signature: params.signature,
    })
    if (recovered.toLowerCase() !== params.buyer.toLowerCase()) {
      return {
        ok: false,
        reason: `recovered ${recovered} ≠ buyer ${params.buyer}`,
      }
    }
    return { ok: true, recovered: getAddress(recovered) }
  } catch (e: any) {
    return { ok: false, reason: `signature verification threw: ${e?.message ?? String(e)}` }
  }
}

