/**
 * @file v3/handler.ts
 * @description
 *   HTTP handler for the v3 (EIP-3009 + EIP-712 BuyIntent) gasless purchase API.
 *
 *   Endpoint:
 *     POST /v3/relay   — gasless GToken / aPNTs purchase via BuyHelper
 *
 *   v3 vs v2:
 *     v2 used EIP-7702 delegation + Type-4 tx — blocked because no browser wallet
 *     exposes `wallet_signAuthorization` for dApp-driven pre-signing.
 *     v3 uses EIP-3009 `transferWithAuthorization` (built into Circle USDC) + a
 *     custom `BuyIntent` EIP-712 (signed via standard `eth_signTypedData_v4`).
 *     The relayer submits a regular EIP-1559 Type-2 tx calling
 *     `BuyHelper.executeBuy(...)`. Both signatures are verified ON-CHAIN inside
 *     BuyHelper (USDC checks its own; we check BuyIntent).
 *
 *   Off-chain verification here is a fast-fail gate to save gas on
 *   obviously-bad requests; on-chain is authoritative.
 */

import {
  createWalletClient,
  defineChain,
  encodeFunctionData,
  http,
  parseAbi,
  recoverTypedDataAddress,
  type Address,
  type Hex,
} from 'viem'
import { privateKeyToAccount } from 'viem/accounts'

import { SEPOLIA } from '../rules/whitelist.js'

// EIP-712 typed data for BuyIntent — mirrors BuyHelper.sol
export const BUY_INTENT_TYPES = {
  BuyIntent: [
    { name: 'buyer', type: 'address' },
    { name: 'paymentToken', type: 'address' },
    { name: 'paymentAmount', type: 'uint256' },
    { name: 'targetToken', type: 'address' },
    { name: 'recipient', type: 'address' },
    { name: 'minOut', type: 'uint256' },
    { name: 'deadline', type: 'uint256' },
    { name: 'nonce', type: 'bytes32' },
  ],
} as const

const EXECUTE_BUY_ABI = parseAbi([
  'function executeBuy((address buyer,address paymentToken,uint256 paymentAmount,address targetToken,address recipient,uint256 minOut,uint256 deadline,bytes32 nonce) intent, bytes buyIntentSig, (uint256 validAfter,uint8 v,bytes32 r,bytes32 s) transferAuth)',
])

// ─── Wire types from frontend ────────────────────────────────────────────────

export type V3RelayRequest = {
  intent: {
    buyer: Address
    paymentToken: Address
    paymentAmount: string  // bigint as decimal string
    targetToken: Address
    recipient: Address
    minOut: string
    deadline: number
    nonce: Hex            // 0x-prefixed 32-byte
  }
  /** 65-byte ECDSA r||s||v over the BuyIntent EIP-712 digest. */
  buyIntentSig: Hex
  /** Extras for USDC.transferWithAuthorization (the rest of the params come from `intent`). */
  transferAuth: {
    validAfter: number
    v: number
    r: Hex
    s: Hex
  }
}

export type V3Response =
  | { ok: true; txHash: Hex; matchedRule: string }
  | { ok: false; code: string; reason: string }

// ─── Handler ─────────────────────────────────────────────────────────────────

export async function handleV3Relay(body: V3RelayRequest, env: V3Env): Promise<V3Response> {
  // 1. Basic shape validation
  if (!body.intent || !body.buyIntentSig || !body.transferAuth) {
    return { ok: false, code: 'INVALID_SHAPE', reason: 'missing required fields' }
  }
  const i = body.intent
  if (!i.buyer || !i.paymentToken || !i.targetToken || !i.recipient || !i.nonce) {
    return { ok: false, code: 'INVALID_SHAPE', reason: 'missing intent field' }
  }

  // 2. Whitelist enforcement: only USDC payment + GToken or aPNTs target
  if (i.paymentToken.toLowerCase() !== SEPOLIA.USDC.toLowerCase()) {
    return { ok: false, code: 'NOT_WHITELISTED', reason: `paymentToken ${i.paymentToken} not whitelisted` }
  }
  const isGToken = i.targetToken.toLowerCase() === SEPOLIA.GTOKEN.toLowerCase()
  const isAPNTs = i.targetToken.toLowerCase() === SEPOLIA.APNTS.toLowerCase()
  if (!isGToken && !isAPNTs) {
    return { ok: false, code: 'NOT_WHITELISTED', reason: `targetToken ${i.targetToken} not whitelisted` }
  }

  // 3. Deadline check (cheap, before signature work)
  const nowSec = Math.floor(Date.now() / 1000)
  if (i.deadline < nowSec) {
    return { ok: false, code: 'EXPIRED', reason: `deadline ${i.deadline} < now ${nowSec}` }
  }

  // 4. Amount cap check (per-tx $864 = 864_000_000 in 6-decimal USDC)
  const paymentAmount = BigInt(i.paymentAmount)
  if (paymentAmount > 864_000_000n) {
    return { ok: false, code: 'NOT_WHITELISTED', reason: `paymentAmount ${paymentAmount} exceeds per-tx cap` }
  }
  if (paymentAmount === 0n) {
    return { ok: false, code: 'INVALID_SHAPE', reason: 'paymentAmount must be > 0' }
  }

  // 5. Off-chain verify BuyIntent signature (BuyHelper re-checks on-chain)
  const chainId = parseInt(env.CHAIN_ID)
  const intentMessage = {
    buyer: i.buyer,
    paymentToken: i.paymentToken,
    paymentAmount,
    targetToken: i.targetToken,
    recipient: i.recipient,
    minOut: BigInt(i.minOut),
    deadline: BigInt(i.deadline),
    nonce: i.nonce,
  }
  try {
    const recovered = await recoverTypedDataAddress({
      domain: {
        name: 'MyceliumBuyHelper',
        version: '1',
        chainId,
        verifyingContract: SEPOLIA.BUY_HELPER,
      },
      types: BUY_INTENT_TYPES,
      primaryType: 'BuyIntent',
      message: intentMessage,
      signature: body.buyIntentSig,
    })
    if (recovered.toLowerCase() !== i.buyer.toLowerCase()) {
      return { ok: false, code: 'SIGNATURE_INVALID', reason: `BuyIntent signer ${recovered} ≠ buyer ${i.buyer}` }
    }
  } catch (e: any) {
    return { ok: false, code: 'SIGNATURE_INVALID', reason: `BuyIntent verify threw: ${e?.message ?? e}` }
  }

  // 6. Build executeBuy calldata
  const callData = encodeFunctionData({
    abi: EXECUTE_BUY_ABI,
    functionName: 'executeBuy',
    args: [
      {
        buyer: i.buyer,
        paymentToken: i.paymentToken,
        paymentAmount,
        targetToken: i.targetToken,
        recipient: i.recipient,
        minOut: BigInt(i.minOut),
        deadline: BigInt(i.deadline),
        nonce: i.nonce,
      },
      body.buyIntentSig,
      {
        validAfter: BigInt(body.transferAuth.validAfter),
        v: body.transferAuth.v,
        r: body.transferAuth.r,
        s: body.transferAuth.s,
      },
    ],
  })

  // 7. Submit Type-2 (EIP-1559) tx
  const operator = privateKeyToAccount(env.OPERATOR_PK)
  const chain = defineChain({
    id: chainId,
    name: 'mycelium',
    nativeCurrency: { name: 'Ether', symbol: 'ETH', decimals: 18 },
    rpcUrls: { default: { http: [env.RPC_URL] } },
  })
  const walletClient = createWalletClient({
    account: operator,
    chain,
    transport: http(env.RPC_URL),
  })
  try {
    const txHash = await walletClient.sendTransaction({
      to: SEPOLIA.BUY_HELPER,
      data: callData,
      value: 0n,
    })
    return {
      ok: true,
      txHash,
      matchedRule: isGToken ? 'TOKEN_BUY → GToken' : 'TOKEN_BUY → aPNTs',
    }
  } catch (e: any) {
    return {
      ok: false,
      code: 'SUBMIT_FAILED',
      reason: e?.shortMessage ?? e?.message ?? String(e),
    }
  }
}

export type V3Env = {
  RPC_URL: string
  OPERATOR_PK: Hex
  CHAIN_ID: string
}
