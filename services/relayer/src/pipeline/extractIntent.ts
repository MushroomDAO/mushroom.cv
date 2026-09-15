/**
 * @file extractIntent.ts
 * @description
 *   Given a batched `executeBatch(calls)` operation submitted to AirAccountDelegate,
 *   extract the buyer's intent in a shape the whitelist can match.
 *
 *   Today we recognize two intent kinds:
 *
 *   1. TOKEN_BUY (2 calls):
 *      - call[0] = ERC20.approve(saleContract, amount)
 *      - call[1] = saleContract.<buySelector>(usdAmount, ...)
 *
 *   2. REVOKE (0 calls + authorization.contract = 0x0)
 *      handled separately, not via this function.
 *
 *   This is intentionally restrictive — extending requires adding a new pattern here.
 */

import { decodeFunctionData, parseAbi, type Address, type Hex, getAddress } from 'viem'
import type { Intent } from '../rules/whitelist.js'

const APPROVE_ABI = parseAbi(['function approve(address spender, uint256 amount)'])
const BUY_TOKENS_ABI = parseAbi([
  'function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)',
])
const BUY_APNTS_ABI = parseAbi([
  'function buyAPNTs(uint256 usdAmount, address paymentToken)',
])

export type Call = {
  target: Address
  value: bigint
  data: Hex
}

export type IntentExtractionResult =
  | { ok: true; intent: Intent }
  | { ok: false; reason: string }

/**
 * Parses a 2-call batch and extracts the intent.
 *
 * @param calls          The batch of calls user wants to execute.
 * @param paymentTokens  Whitelisted ERC20 payment tokens (used to identify call[0]).
 */
export function extractTokenBuyIntent(
  calls: Call[],
  paymentTokens: readonly Address[],
): IntentExtractionResult {
  if (calls.length !== 2) {
    return { ok: false, reason: `Expected 2 calls (approve + buy), got ${calls.length}` }
  }

  const approveCall = calls[0]!
  const buyCall = calls[1]!

  // ── Call 0: must be ERC20.approve to a whitelisted payment token ──
  if (approveCall.value !== 0n) {
    return { ok: false, reason: 'approve call must have value=0' }
  }
  const paymentToken = approveCall.target
  if (!paymentTokens.some(pt => pt.toLowerCase() === paymentToken.toLowerCase())) {
    return {
      ok: false,
      reason: `Payment token ${paymentToken} not in whitelist`,
    }
  }
  let approveSpender: Address
  let approveAmount: bigint
  try {
    const decoded = decodeFunctionData({ abi: APPROVE_ABI, data: approveCall.data })
    approveSpender = decoded.args[0] as Address
    approveAmount = decoded.args[1] as bigint
  } catch {
    return { ok: false, reason: 'Call[0] data is not approve(address,uint256)' }
  }

  // ── Call 1: must be saleContract.buyTokens OR .buyAPNTs ──
  if (buyCall.value !== 0n) {
    return { ok: false, reason: 'buy call must have value=0' }
  }
  if (approveSpender.toLowerCase() !== buyCall.target.toLowerCase()) {
    return {
      ok: false,
      reason: `approve spender ${approveSpender} ≠ buy target ${buyCall.target}`,
    }
  }
  const selector = (buyCall.data.slice(0, 10).toLowerCase()) as Hex

  // Try buyTokens(uint256, address, uint256) first
  try {
    const decoded = decodeFunctionData({ abi: BUY_TOKENS_ABI, data: buyCall.data })
    const usdAmount = decoded.args[0] as bigint
    const buyPaymentToken = decoded.args[1] as Address
    if (buyPaymentToken.toLowerCase() !== paymentToken.toLowerCase()) {
      return {
        ok: false,
        reason: `buyTokens.paymentToken ${buyPaymentToken} ≠ approve target ${paymentToken}`,
      }
    }
    if (approveAmount < usdAmount) {
      return {
        ok: false,
        reason: `approve amount ${approveAmount} < buy usdAmount ${usdAmount}`,
      }
    }
    return {
      ok: true,
      intent: {
        kind: 'TOKEN_BUY',
        target: getAddress(buyCall.target),
        functionSelector: selector,
        paymentToken: getAddress(paymentToken),
        paymentAmount: usdAmount,
      },
    }
  } catch {
    // fall through to buyAPNTs
  }

  // Try buyAPNTs(uint256, address)
  try {
    const decoded = decodeFunctionData({ abi: BUY_APNTS_ABI, data: buyCall.data })
    const usdAmount = decoded.args[0] as bigint
    const buyPaymentToken = decoded.args[1] as Address
    if (buyPaymentToken.toLowerCase() !== paymentToken.toLowerCase()) {
      return {
        ok: false,
        reason: `buyAPNTs.paymentToken ${buyPaymentToken} ≠ approve target ${paymentToken}`,
      }
    }
    if (approveAmount < usdAmount) {
      return {
        ok: false,
        reason: `approve amount ${approveAmount} < buy usdAmount ${usdAmount}`,
      }
    }
    return {
      ok: true,
      intent: {
        kind: 'TOKEN_BUY',
        target: getAddress(buyCall.target),
        functionSelector: selector,
        paymentToken: getAddress(paymentToken),
        paymentAmount: usdAmount,
      },
    }
  } catch {
    return {
      ok: false,
      reason: `Call[1] data does not match any known buy ABI (selector=${selector})`,
    }
  }
}
