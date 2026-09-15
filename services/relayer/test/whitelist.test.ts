import { describe, it, expect } from 'vitest'
import { getAddress, type Address } from 'viem'
import { matchWhitelist, RULES_SEPOLIA, SEPOLIA, type Intent } from '../src/rules/whitelist.js'

describe('matchWhitelist', () => {
  const validBuyGToken: Intent = {
    kind: 'TOKEN_BUY',
    target: SEPOLIA.SALE_V2_NEW,
    functionSelector: '0x71777f76', // buyTokens(uint256,address,uint256) selector
    paymentToken: SEPOLIA.USDC,
    paymentAmount: 50_000_000n, // $50
  }

  const validBuyAPNTs: Intent = {
    kind: 'TOKEN_BUY',
    target: SEPOLIA.APNTS_SALE,
    functionSelector: '0x4d8f3acb', // buyAPNTs(uint256,address) selector — placeholder, replaced in test
    paymentToken: SEPOLIA.USDC,
    paymentAmount: 30_000_000n, // $30
  }

  const validRevoke: Intent = {
    kind: 'REVOKE',
    target: null,
    functionSelector: null,
    paymentToken: null,
    paymentAmount: null,
  }

  it('accepts GToken purchase with correct selector', () => {
    // Replace placeholder with the actual computed selector from the rule.
    const rule = RULES_SEPOLIA.find(r => r.target === SEPOLIA.SALE_V2_NEW)!
    const intent = { ...validBuyGToken, functionSelector: rule.functionSelector }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(true)
    if (result.matched) {
      expect(result.rule.kind).toBe('TOKEN_BUY')
      expect(result.rule.target).toBe(SEPOLIA.SALE_V2_NEW)
    }
  })

  it('accepts aPNTs purchase with correct selector', () => {
    const rule = RULES_SEPOLIA.find(r => r.target === SEPOLIA.APNTS_SALE)!
    const intent = { ...validBuyAPNTs, functionSelector: rule.functionSelector }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(true)
    if (result.matched) expect(result.rule.target).toBe(SEPOLIA.APNTS_SALE)
  })

  it('accepts REVOKE intent', () => {
    const result = matchWhitelist(validRevoke)
    expect(result.matched).toBe(true)
    if (result.matched) expect(result.rule.kind).toBe('REVOKE')
  })

  it('rejects unknown kind', () => {
    const intent: Intent = { ...validBuyGToken, kind: 'UNKNOWN_KIND' }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(false)
  })

  it('rejects wrong target', () => {
    const rule = RULES_SEPOLIA.find(r => r.target === SEPOLIA.SALE_V2_NEW)!
    const intent: Intent = {
      ...validBuyGToken,
      target: getAddress('0x0000000000000000000000000000000000000001') as Address,
      functionSelector: rule.functionSelector,
    }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(false)
  })

  it('rejects wrong function selector', () => {
    const intent = {
      ...validBuyGToken,
      functionSelector: '0xdeadbeef' as `0x${string}`,
    }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(false)
  })

  it('rejects non-whitelisted payment token', () => {
    const rule = RULES_SEPOLIA.find(r => r.target === SEPOLIA.SALE_V2_NEW)!
    const intent: Intent = {
      ...validBuyGToken,
      paymentToken: getAddress('0x0000000000000000000000000000000000000099') as Address,
      functionSelector: rule.functionSelector,
    }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(false)
  })

  it('rejects amount over per-tx cap', () => {
    const rule = RULES_SEPOLIA.find(r => r.target === SEPOLIA.SALE_V2_NEW)!
    const intent: Intent = {
      ...validBuyGToken,
      functionSelector: rule.functionSelector,
      paymentAmount: 1_000_000_000n, // $1000 > $864 cap
    }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(false)
    if (!result.matched) expect(result.reason).toMatch(/per-tx cap/)
  })

  it('rejects REVOKE that incorrectly specifies a target', () => {
    const intent: Intent = {
      ...validRevoke,
      target: SEPOLIA.SALE_V2_NEW,
    }
    const result = matchWhitelist(intent)
    expect(result.matched).toBe(false)
  })

  it('skips disabled rules', () => {
    const disabled = RULES_SEPOLIA.map(r => ({ ...r, enabled: false }))
    const result = matchWhitelist(validRevoke, disabled)
    expect(result.matched).toBe(false)
  })

  it('TOKEN_BUY rule defines a 4-byte selector', () => {
    for (const r of RULES_SEPOLIA) {
      if (r.kind !== 'REVOKE') {
        expect(r.functionSelector).toMatch(/^0x[0-9a-f]{8}$/)
      } else {
        expect(r.functionSelector).toBeNull()
      }
    }
  })
})
