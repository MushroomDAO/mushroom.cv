/**
 * @file v2/handler.ts
 * @description
 *   HTTP handlers for the v2 (EIP-7702 + EIP-712) gasless purchase API.
 *
 *   Endpoints:
 *     POST /v2/relay   — gasless TOKEN_BUY via AirAccountDelegate
 *     POST /v2/revoke  — gasless EIP-7702 delegation revocation
 *
 *   v2 vs v1:
 *     v1 (/relay) is ERC-4337 + SuperPaymaster path — kept as-is (currently
 *     gated by INFRA_NOT_READY). Operationally inactive.
 *     v2 is raw EIP-7702 with relayer-paid gas — used by the new launch flow.
 *
 *   SuperPaymaster integration: deferred. The relayer's own OPERATOR_PK pays gas
 *   directly. When SP is integrated, only the build/submit step changes — the
 *   verification and whitelist logic stay intact.
 */

import {
  createPublicClient,
  createWalletClient,
  encodeFunctionData,
  http,
  parseAbi,
  type Address,
  type Hex,
  type SignAuthorizationReturnType,
} from 'viem'
import { recoverAuthorizationAddress } from 'viem/utils'
import { privateKeyToAccount } from 'viem/accounts'
import { sepolia } from 'viem/chains'

import type { Call } from '../pipeline/extractIntent.js'
import { extractTokenBuyIntent } from '../pipeline/extractIntent.js'
import { verifyExecuteBatchSignature } from '../pipeline/verify712.js'
import { matchWhitelist, RULES_SEPOLIA, SEPOLIA, type SponsorRule } from '../rules/whitelist.js'

const EXECUTE_BATCH_ABI = parseAbi([
  'function executeBatch((address target, uint256 value, bytes data)[] calls, uint256 deadline, bytes signature)',
  'function nonce() view returns (uint256)',
])

// ─── Wire types from frontend ────────────────────────────────────────────────

export type V2RelayRequest = {
  /** EOA address (buyer). */
  buyer: Address
  /** Batched calls to execute via AirAccountDelegate.executeBatch. */
  calls: Call[]
  /** Buyer-signed deadline (Unix seconds). */
  deadline: number
  /** Buyer's EIP-712 signature over ExecuteBatch (65 bytes, r||s||v hex). */
  signature: Hex
  /** EIP-7702 authorization signed by the EOA. */
  authorization: {
    chainId: number
    address: Address // = AirAccountDelegate
    nonce: number
    r: Hex
    s: Hex
    yParity: 0 | 1
  }
}

export type V2RevokeRequest = {
  buyer: Address
  /** EIP-7702 authorization with `address: 0x0...0` to clear delegation.
   *  EIP-7702's chainId + nonce + contract-address fields provide the protocol-
   *  level replay protection: the auth is single-use (consumed on first tx),
   *  chain-bound, and the captured-replay scenario yields zero damage since
   *  the user already intended to revoke. Industry standard is single-sign;
   *  no separate EIP-712 RevokeIntent is added (verified by reviewing
   *  Alchemy / Revoke.cash / MetaMask flows). */
  authorization: {
    chainId: number
    address: Address // expected to be address(0)
    nonce: number
    r: Hex
    s: Hex
    yParity: 0 | 1
  }
}

export type V2Response =
  | { ok: true; txHash: Hex; matchedRule: string }
  | { ok: false; code: string; reason: string }

// ─── /v2/relay handler ───────────────────────────────────────────────────────

export async function handleV2Relay(body: V2RelayRequest, env: V2Env): Promise<V2Response> {
  // 1. Basic shape validation
  if (!body.buyer || !body.calls || !body.signature) {
    return { ok: false, code: 'INVALID_SHAPE', reason: 'missing required fields' }
  }
  if (body.authorization.address.toLowerCase() !== SEPOLIA.AIRACCOUNT_DELEGATE.toLowerCase()) {
    return {
      ok: false,
      code: 'WRONG_DELEGATE',
      reason: `authorization.address must be AirAccountDelegate (${SEPOLIA.AIRACCOUNT_DELEGATE})`,
    }
  }
  // Codex MEDIUM-1 fix: enforce chain id matches our configured chain
  if (body.authorization.chainId !== sepolia.id) {
    return {
      ok: false,
      code: 'CHAIN_ID_MISMATCH',
      reason: `authorization.chainId ${body.authorization.chainId} ≠ ${sepolia.id}`,
    }
  }
  // Codex MEDIUM-2 fix: recover authorization signer and require == buyer
  const authSigner = await recoverAuthorizationAddress({
    authorization: {
      chainId: body.authorization.chainId,
      address: body.authorization.address,
      nonce: body.authorization.nonce,
      r: body.authorization.r,
      s: body.authorization.s,
      yParity: body.authorization.yParity,
    },
  }).catch(() => null)
  if (!authSigner || authSigner.toLowerCase() !== body.buyer.toLowerCase()) {
    return {
      ok: false,
      code: 'AUTH_SIGNER_MISMATCH',
      reason: `authorization signer ${authSigner} ≠ buyer ${body.buyer}`,
    }
  }

  // 2. Extract intent from batch
  const extraction = extractTokenBuyIntent(
    body.calls,
    [SEPOLIA.USDC], // hard-coded paymentTokens for now; later read from rule
  )
  if (!extraction.ok) {
    return { ok: false, code: 'INTENT_PARSE_FAILED', reason: extraction.reason }
  }

  // 3. Match whitelist
  const match = matchWhitelist(extraction.intent)
  if (!match.matched) {
    return { ok: false, code: 'NOT_WHITELISTED', reason: match.reason }
  }

  // 4. Read on-chain nonce for the EOA (must match what user signed)
  const publicClient = createPublicClient({ chain: sepolia, transport: http(env.RPC_URL) })
  let onChainNonce: bigint
  try {
    onChainNonce = await publicClient.readContract({
      address: body.buyer,
      abi: EXECUTE_BATCH_ABI,
      functionName: 'nonce',
    }) as bigint
  } catch {
    // Most likely the EOA isn't yet delegated → nonce slot is 0.
    onChainNonce = 0n
  }

  // 5. Verify EIP-712 signature (off-chain pre-check; on-chain re-checks anyway).
  //    verifyingContract = AirAccountDelegate IMPLEMENTATION address (constant,
  //    not the EOA). MetaMask refuses to sign typed data where verifyingContract
  //    equals one of the user's own accounts, so the on-chain domain is pinned
  //    to the impl address via an immutable.
  const verify = await verifyExecuteBatchSignature({
    buyer: body.buyer,
    verifyingContract: SEPOLIA.AIRACCOUNT_DELEGATE,
    chainId: body.authorization.chainId,
    calls: body.calls,
    nonce: onChainNonce,
    deadline: BigInt(body.deadline),
    signature: body.signature,
  })
  if (!verify.ok) {
    return { ok: false, code: 'SIGNATURE_INVALID', reason: verify.reason }
  }

  // 6. Build executeBatch calldata
  const executeBatchData = encodeFunctionData({
    abi: EXECUTE_BATCH_ABI,
    functionName: 'executeBatch',
    args: [body.calls, BigInt(body.deadline), body.signature],
  })

  // 7. Build and submit Type-4 tx (relayer pays gas)
  return submitType4Tx({
    rpcUrl: env.RPC_URL,
    operatorPk: env.OPERATOR_PK,
    buyer: body.buyer,
    authorization: body.authorization,
    callData: executeBatchData,
    matchedRule: describeRule(match.rule),
  })
}

// ─── /v2/revoke handler ──────────────────────────────────────────────────────

export async function handleV2Revoke(body: V2RevokeRequest, env: V2Env): Promise<V2Response> {
  // 1. Validate authorization shape — contract MUST be zero for revoke
  const ZERO = '0x0000000000000000000000000000000000000000'
  if (body.authorization.address.toLowerCase() !== ZERO) {
    return {
      ok: false,
      code: 'INVALID_REVOKE_AUTH',
      reason: 'authorization.address must be 0x0...0 for revoke',
    }
  }
  // Codex MEDIUM-1 fix: enforce chain id matches our configured chain
  if (body.authorization.chainId !== sepolia.id) {
    return {
      ok: false,
      code: 'CHAIN_ID_MISMATCH',
      reason: `authorization.chainId ${body.authorization.chainId} ≠ ${sepolia.id}`,
    }
  }
  // Codex MEDIUM-2 fix: recover authorization signer == buyer
  const authSigner = await recoverAuthorizationAddress({
    authorization: {
      chainId: body.authorization.chainId,
      address: body.authorization.address,
      nonce: body.authorization.nonce,
      r: body.authorization.r,
      s: body.authorization.s,
      yParity: body.authorization.yParity,
    },
  }).catch(() => null)
  if (!authSigner || authSigner.toLowerCase() !== body.buyer.toLowerCase()) {
    return {
      ok: false,
      code: 'AUTH_SIGNER_MISMATCH',
      reason: `authorization signer ${authSigner} ≠ buyer ${body.buyer}`,
    }
  }
  // 2. Whitelist match (just confirms REVOKE rule is enabled)
  const match = matchWhitelist({
    kind: 'REVOKE',
    target: null,
    functionSelector: null,
    paymentToken: null,
    paymentAmount: null,
  })
  if (!match.matched) {
    return { ok: false, code: 'NOT_WHITELISTED', reason: match.reason }
  }

  // 3. Submit Type-4 tx with empty calldata (authorization processing only)
  return submitType4Tx({
    rpcUrl: env.RPC_URL,
    operatorPk: env.OPERATOR_PK,
    buyer: body.buyer,
    authorization: body.authorization,
    callData: '0x' as Hex,
    matchedRule: 'REVOKE',
  })
}

// ─── Type-4 tx submission ────────────────────────────────────────────────────

type SubmitArgs = {
  rpcUrl: string
  operatorPk: Hex
  buyer: Address
  authorization: V2RelayRequest['authorization']
  callData: Hex
  matchedRule: string
}

async function submitType4Tx(args: SubmitArgs): Promise<V2Response> {
  const operator = privateKeyToAccount(args.operatorPk)
  const walletClient = createWalletClient({
    account: operator,
    chain: sepolia,
    transport: http(args.rpcUrl),
  })

  // Reconstruct EIP-7702 authorization in viem's expected format.
  const auth: SignAuthorizationReturnType = {
    chainId: args.authorization.chainId,
    address: args.authorization.address,
    nonce: args.authorization.nonce,
    r: args.authorization.r,
    s: args.authorization.s,
    yParity: args.authorization.yParity,
  }

  try {
    const txHash = await walletClient.sendTransaction({
      type: 'eip7702' as any, // viem ≥ 2.21 supports Type-4
      authorizationList: [auth],
      to: args.buyer, // calls EOA with delegate code
      data: args.callData,
      value: 0n,
    } as any)
    return { ok: true, txHash, matchedRule: args.matchedRule }
  } catch (e: any) {
    return {
      ok: false,
      code: 'SUBMIT_FAILED',
      reason: e?.shortMessage ?? e?.message ?? String(e),
    }
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

function describeRule(rule: SponsorRule): string {
  if (rule.kind === 'REVOKE') return 'REVOKE'
  return `${rule.kind} → ${rule.target} (${rule.functionSignature})`
}

// ─── Env ──────────────────────────────────────────────────────────────────────

export type V2Env = {
  RPC_URL: string
  OPERATOR_PK: Hex
}
