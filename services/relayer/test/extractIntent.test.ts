import { describe, it, expect } from 'vitest'
import { encodeFunctionData, parseAbi, type Address, type Hex } from 'viem'
import { extractTokenBuyIntent, type Call } from '../src/pipeline/extractIntent.js'
import { SEPOLIA } from '../src/rules/whitelist.js'

const APPROVE = parseAbi(['function approve(address spender, uint256 amount)'])
const BUY_TOKENS = parseAbi([
  'function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)',
])
const BUY_APNTS = parseAbi(['function buyAPNTs(uint256 usdAmount, address paymentToken)'])

const PAYMENT_TOKENS = [SEPOLIA.USDC] as const

function mkApprove(spender: Address, amount: bigint, target: Address = SEPOLIA.USDC): Call {
  return {
    target,
    value: 0n,
    data: encodeFunctionData({ abi: APPROVE, functionName: 'approve', args: [spender, amount] }),
  }
}

function mkBuyTokens(saleAddr: Address, usd: bigint, paymentToken: Address = SEPOLIA.USDC): Call {
  return {
    target: saleAddr,
    value: 0n,
    data: encodeFunctionData({
      abi: BUY_TOKENS,
      functionName: 'buyTokens',
      args: [usd, paymentToken, 0n],
    }),
  }
}

function mkBuyAPNTs(saleAddr: Address, usd: bigint, paymentToken: Address = SEPOLIA.USDC): Call {
  return {
    target: saleAddr,
    value: 0n,
    data: encodeFunctionData({
      abi: BUY_APNTS,
      functionName: 'buyAPNTs',
      args: [usd, paymentToken],
    }),
  }
}

describe('extractTokenBuyIntent', () => {
  it('extracts GToken buy intent', () => {
    const calls: Call[] = [
      mkApprove(SEPOLIA.SALE_V2_NEW, 50_000_000n),
      mkBuyTokens(SEPOLIA.SALE_V2_NEW, 50_000_000n),
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(true)
    if (r.ok) {
      expect(r.intent.kind).toBe('TOKEN_BUY')
      expect(r.intent.target).toBe(SEPOLIA.SALE_V2_NEW)
      expect(r.intent.paymentAmount).toBe(50_000_000n)
      expect(r.intent.paymentToken).toBe(SEPOLIA.USDC)
    }
  })

  it('extracts aPNTs buy intent', () => {
    const calls: Call[] = [
      mkApprove(SEPOLIA.APNTS_SALE, 30_000_000n),
      mkBuyAPNTs(SEPOLIA.APNTS_SALE, 30_000_000n),
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(true)
    if (r.ok) {
      expect(r.intent.kind).toBe('TOKEN_BUY')
      expect(r.intent.target).toBe(SEPOLIA.APNTS_SALE)
      expect(r.intent.paymentAmount).toBe(30_000_000n)
    }
  })

  it('rejects wrong call count', () => {
    const r = extractTokenBuyIntent([mkApprove(SEPOLIA.SALE_V2_NEW, 1n)], PAYMENT_TOKENS)
    expect(r.ok).toBe(false)
  })

  it('rejects non-whitelisted payment token', () => {
    const FAKE = '0x0000000000000000000000000000000000000099' as Address
    const calls: Call[] = [
      mkApprove(SEPOLIA.SALE_V2_NEW, 50n, FAKE),
      mkBuyTokens(SEPOLIA.SALE_V2_NEW, 50n, FAKE),
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(false)
  })

  it('rejects approve/buy target mismatch (potential gas griefing)', () => {
    const OTHER_SALE = '0x0000000000000000000000000000000000000001' as Address
    const calls: Call[] = [
      mkApprove(SEPOLIA.SALE_V2_NEW, 50n),
      mkBuyTokens(OTHER_SALE, 50n), // approves Sale V2 but buys from OTHER_SALE
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(false)
  })

  it('rejects when approve amount < buy usdAmount', () => {
    const calls: Call[] = [
      mkApprove(SEPOLIA.SALE_V2_NEW, 10_000_000n),
      mkBuyTokens(SEPOLIA.SALE_V2_NEW, 50_000_000n),
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(false)
  })

  it('rejects ETH-value approve (must be value=0)', () => {
    const calls: Call[] = [
      { ...mkApprove(SEPOLIA.SALE_V2_NEW, 50n), value: 1n },
      mkBuyTokens(SEPOLIA.SALE_V2_NEW, 50n),
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(false)
  })

  it('rejects junk data in call[1]', () => {
    const calls: Call[] = [
      mkApprove(SEPOLIA.SALE_V2_NEW, 50n),
      { target: SEPOLIA.SALE_V2_NEW, value: 0n, data: '0xdeadbeef' as Hex },
    ]
    const r = extractTokenBuyIntent(calls, PAYMENT_TOKENS)
    expect(r.ok).toBe(false)
  })
})
