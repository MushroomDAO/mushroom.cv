/**
 * @file whitelist.ts
 * @description
 *   The relayer's open & transparent sponsorship whitelist.
 *
 *   We only sponsor gas for operations that match a rule below. Today there are
 *   exactly 3 kinds of allowed operations:
 *
 *     - TOKEN_BUY of GToken (via SaleContractV2 / buyTokens)
 *     - TOKEN_BUY of aPNTs  (via APNTsSaleContract / buyAPNTs)
 *     - REVOKE (EIP-7702 authorization with contract = address(0))
 *
 *   The rule data structure supports 5 extension dimensions without architectural
 *   change (see spec § 4): kind / target / functionSelector / paymentTokens /
 *   feeBps. Add new rules by appending to RULES below.
 *
 *   "Adding a rule" is a code change → PR → review → deploy. There is no on-chain
 *   admin path to mutate this without code review. That's intentional — sponsorship
 *   is a trust-mediated function.
 */

import type { Address, Hex } from 'viem'
import { getAddress, toFunctionSelector } from 'viem'

// ─── Types ───────────────────────────────────────────────────────────────────

export type SponsorRule = {
  /** Operation kind. Extension point D-1. */
  readonly kind: 'TOKEN_BUY' | 'NFT_MINT' | 'REVOKE' | string
  /** Target contract address. `null` for kind=REVOKE (no target). */
  readonly target: Address | null
  /** Function signature (e.g. 'buyTokens(uint256,address,uint256)'). Empty for REVOKE. */
  readonly functionSignature: string
  /** Lowercased function selector (4-byte hex). Computed from functionSignature. */
  readonly functionSelector: Hex | null
  /** Whitelisted payment tokens. Empty for REVOKE. */
  readonly paymentTokens: Address[]
  /** Optional per-tx fee charged by relayer (basis points). 0 = free. */
  readonly feeBps: number
  /** Optional recipient for the fee. */
  readonly feeRecipient: Address | null
  /** Optional max single-call amount (in payment token's smallest unit). */
  readonly maxAmountPerTx: bigint | null
  /** Optional max amount per (user, day) — enforced via KV rate limiter. */
  readonly maxAmountPerUserPerDay: bigint | null
  /** Enabled toggle for hot-disabling a rule without redeploying. */
  readonly enabled: boolean
}

/**
 * The buyer's intent, parsed from EIP-712 typed data. Used by the matcher.
 *
 * (Subset of fields used for whitelist matching only — full intent includes nonce, deadline.)
 */
export type Intent = {
  kind: SponsorRule['kind']
  target: Address | null
  /** The 4-byte selector that the relayer is being asked to invoke on `target`. */
  functionSelector: Hex | null
  paymentToken: Address | null
  /** Payment amount in payment token's smallest unit. null for REVOKE. */
  paymentAmount: bigint | null
}

// ─── Sepolia addresses (canonical) ───────────────────────────────────────────

// Path A (2026-06-21): sale stack redeployed bound to the canonical SuperPaymaster
// GToken / aPNTs. GTOKEN/APNTS/SALE_V2_NEW/APNTS_SALE/BUY_HELPER all rebound here.
export const SEPOLIA = {
  USDC: getAddress('0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238'),
  GTOKEN: getAddress('0x20a051502a7AE6e40cfFd6EBe59057538E698984'),
  APNTS: getAddress('0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b'),
  SALE_V2_NEW: getAddress('0x29eE47dEBD0E60d426352415749b4899057D913F'),
  APNTS_SALE: getAddress('0x136654d4141d151e9C237af65E98c03e22afc142'),
  AIRACCOUNT_DELEGATE: getAddress('0x0BC1A36d932e2E9efA33b98043a73b8Be1a6E9Fc'),
  BUY_HELPER: getAddress('0x0EA2AEd239574F4e875Ae570C67825da845E7e66'),
} as const

// ─── Helper: build a rule with auto-computed selector ───────────────────────

function rule(input: {
  kind: SponsorRule['kind']
  target: Address | null
  functionSignature: string
  paymentTokens: Address[]
  feeBps?: number
  feeRecipient?: Address | null
  maxAmountPerTx?: bigint | null
  maxAmountPerUserPerDay?: bigint | null
  enabled?: boolean
}): SponsorRule {
  return {
    kind: input.kind,
    target: input.target,
    functionSignature: input.functionSignature,
    functionSelector: input.functionSignature
      ? (toFunctionSelector(input.functionSignature).toLowerCase() as Hex)
      : null,
    paymentTokens: input.paymentTokens.map(getAddress),
    feeBps: input.feeBps ?? 0,
    feeRecipient: input.feeRecipient ?? null,
    maxAmountPerTx: input.maxAmountPerTx ?? null,
    maxAmountPerUserPerDay: input.maxAmountPerUserPerDay ?? null,
    enabled: input.enabled ?? true,
  }
}

// ─── The active rule set (Sepolia) ───────────────────────────────────────────

/**
 * 默认 cap:
 *  - maxAmountPerTx = $864 (per-tx, matches on-chain SaleContractV2.perPersonCapUSD)
 *
 * No per-day cap: it was previously declared ($4320) but never enforced (rateLimit
 * counts hourly request frequency, not cumulative USD), and a per-day cap is
 * sybil-able anyway (one person, many wallets). Per-person limits are the on-chain
 * perPersonCapUSD (per wallet); broader distribution is controlled by opening/closing
 * the sale (SaleContractV2 Pausable) to a known group.
 */
const CAP_PER_TX_USDC_6DEC = 864_000_000n // $864 in 6-decimal USDC

export const RULES_SEPOLIA: readonly SponsorRule[] = [
  // —— rule A: buy GToken via SaleContractV2 (new, gToken-bound) ——
  rule({
    kind: 'TOKEN_BUY',
    target: SEPOLIA.SALE_V2_NEW,
    functionSignature: 'buyTokens(uint256,address,uint256)',
    paymentTokens: [SEPOLIA.USDC],
    maxAmountPerTx: CAP_PER_TX_USDC_6DEC,
  }),

  // —— rule B: buy aPNTs via APNTsSaleContract ——
  rule({
    kind: 'TOKEN_BUY',
    target: SEPOLIA.APNTS_SALE,
    functionSignature: 'buyAPNTs(uint256,address)',
    paymentTokens: [SEPOLIA.USDC],
    maxAmountPerTx: CAP_PER_TX_USDC_6DEC,
  }),

  // —— rule C: revoke EIP-7702 delegation (authorization.contract = 0x0) ——
  rule({
    kind: 'REVOKE',
    target: null,
    functionSignature: '',
    paymentTokens: [],
    // Revoke costs ~21k gas; no per-user dollar cap, but rate-limited at the
    // HTTP layer (see rateLimit.ts) to prevent denial-of-service.
  }),
] as const

// ─── Matcher ─────────────────────────────────────────────────────────────────

export type WhitelistMatch =
  | { matched: true; rule: SponsorRule }
  | { matched: false; reason: string }

/**
 * Match an intent against the active whitelist.
 *
 * Returns a successful match only if **all** of these hold:
 *   1. Some rule has the same `kind`.
 *   2. If kind ≠ REVOKE: target / selector / paymentToken match the rule.
 *   3. Rule is `enabled`.
 *   4. paymentAmount ≤ maxAmountPerTx (when defined).
 *
 * Per-user-per-day caps are checked downstream by the rate limiter (with KV state).
 */
export function matchWhitelist(intent: Intent, rules: readonly SponsorRule[] = RULES_SEPOLIA): WhitelistMatch {
  for (const r of rules) {
    if (!r.enabled) continue
    if (r.kind !== intent.kind) continue

    // REVOKE has no target / selector / payment.
    if (r.kind === 'REVOKE') {
      if (intent.target !== null) {
        return { matched: false, reason: 'REVOKE intent must not specify target' }
      }
      return { matched: true, rule: r }
    }

    // TOKEN_BUY / NFT_MINT / etc.: full match required.
    if (!intent.target || !r.target) continue
    if (intent.target.toLowerCase() !== r.target.toLowerCase()) continue
    if (!intent.functionSelector || !r.functionSelector) continue
    if (intent.functionSelector.toLowerCase() !== r.functionSelector.toLowerCase()) continue
    if (!intent.paymentToken) continue
    if (!r.paymentTokens.some(p => p.toLowerCase() === intent.paymentToken!.toLowerCase())) continue

    if (r.maxAmountPerTx != null && intent.paymentAmount != null) {
      if (intent.paymentAmount > r.maxAmountPerTx) {
        return {
          matched: false,
          reason: `Amount ${intent.paymentAmount} exceeds per-tx cap ${r.maxAmountPerTx}`,
        }
      }
    }

    return { matched: true, rule: r }
  }
  return { matched: false, reason: `No whitelist rule matches kind=${intent.kind}` }
}
