/**
 * @file v3-handler.test.ts
 * @description Vitest unit tests for /v3/relay handler (EIP-3009 + BuyIntent flow).
 */

import { describe, it, expect } from 'vitest'
import { type Hex, type Address, keccak256, toHex } from 'viem'
import { privateKeyToAccount, signTypedData } from 'viem/accounts'
import { handleV3Relay, BUY_INTENT_TYPES, type V3RelayRequest } from '../src/v3/handler.js'
import { SEPOLIA } from '../src/rules/whitelist.js'

const BUYER_PK = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80' as const
const BUYER = privateKeyToAccount(BUYER_PK).address as Address

const OTHER_PK = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d' as const

const ENV = {
  CHAIN_ID: '11155111', // Sepolia — must match the EIP-712 domain chainId in signBuyIntent
  RPC_URL: 'http://invalid-rpc',
  OPERATOR_PK: '0x' + '11'.repeat(32) as Hex,
}

async function signBuyIntent(intent: V3RelayRequest['intent'], pk: `0x${string}` = BUYER_PK): Promise<Hex> {
  return signTypedData({
    privateKey: pk,
    domain: {
      name: 'MyceliumBuyHelper',
      version: '1',
      chainId: 11155111,
      verifyingContract: SEPOLIA.BUY_HELPER,
    },
    types: BUY_INTENT_TYPES,
    primaryType: 'BuyIntent',
    message: {
      buyer: intent.buyer,
      paymentToken: intent.paymentToken,
      paymentAmount: BigInt(intent.paymentAmount),
      targetToken: intent.targetToken,
      recipient: intent.recipient,
      minOut: BigInt(intent.minOut),
      deadline: BigInt(intent.deadline),
      nonce: intent.nonce,
    },
  })
}

function buildRequest(overrides: Partial<V3RelayRequest['intent']> = {}): V3RelayRequest['intent'] {
  const deadline = Math.floor(Date.now() / 1000) + 600
  return {
    buyer: BUYER,
    paymentToken: SEPOLIA.USDC,
    paymentAmount: '15000000', // 15 USDC (6 decimals)
    targetToken: SEPOLIA.GTOKEN,
    recipient: BUYER,
    minOut: '0',
    deadline,
    nonce: keccak256(toHex(Math.random().toString())),
    ...overrides,
  }
}

const FAKE_TRANSFER_AUTH = {
  validAfter: 0,
  v: 27,
  r: '0x' + '00'.repeat(32) as Hex,
  s: '0x' + '00'.repeat(32) as Hex,
}

describe('handleV3Relay — shape + whitelist', () => {
  it('rejects missing intent', async () => {
    const r = await handleV3Relay({ buyIntentSig: '0x', transferAuth: FAKE_TRANSFER_AUTH } as any, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('INVALID_SHAPE')
  })

  it('rejects non-USDC paymentToken', async () => {
    const intent = buildRequest({ paymentToken: '0x0000000000000000000000000000000000000001' as Address })
    const sig = await signBuyIntent(intent)
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('NOT_WHITELISTED')
  })

  it('rejects non-GToken/non-aPNTs targetToken', async () => {
    const intent = buildRequest({ targetToken: '0x0000000000000000000000000000000000000002' as Address })
    const sig = await signBuyIntent(intent)
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('NOT_WHITELISTED')
  })

  it('accepts GToken target', async () => {
    const intent = buildRequest({ targetToken: SEPOLIA.GTOKEN })
    const sig = await signBuyIntent(intent)
    // Will fail at SUBMIT_FAILED (invalid RPC) — that's past all our gates, so the
    // gates passed. We just check the failure mode.
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('SUBMIT_FAILED')
  })

  it('accepts aPNTs target', async () => {
    const intent = buildRequest({ targetToken: SEPOLIA.APNTS })
    const sig = await signBuyIntent(intent)
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    if (r.ok === false) expect(r.code).toBe('SUBMIT_FAILED')
  })
})

describe('handleV3Relay — deadline + amount caps', () => {
  it('rejects expired deadline', async () => {
    const intent = buildRequest({ deadline: Math.floor(Date.now() / 1000) - 60 })
    const sig = await signBuyIntent(intent)
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('EXPIRED')
  })

  it('rejects paymentAmount > $864 cap', async () => {
    const intent = buildRequest({ paymentAmount: '900000000' }) // $900
    const sig = await signBuyIntent(intent)
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('NOT_WHITELISTED')
  })

  it('rejects paymentAmount == 0', async () => {
    const intent = buildRequest({ paymentAmount: '0' })
    const sig = await signBuyIntent(intent)
    const r = await handleV3Relay({ intent, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('INVALID_SHAPE')
  })
})

describe('handleV3Relay — signature verification', () => {
  it('rejects BuyIntent signed by non-buyer', async () => {
    const intent = buildRequest()
    const wrongSig = await signBuyIntent(intent, OTHER_PK) // signed by attacker
    const r = await handleV3Relay({ intent, buyIntentSig: wrongSig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) {
      expect(r.code).toBe('SIGNATURE_INVALID')
      expect(r.reason).toMatch(/signer.*≠ buyer/)
    }
  })

  it('rejects BuyIntent with tampered amount', async () => {
    const intent = buildRequest()
    const sig = await signBuyIntent(intent)
    // Relayer tries to claim a different amount than what user signed
    const tampered = { ...intent, paymentAmount: '20000000' }
    const r = await handleV3Relay({ intent: tampered, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('SIGNATURE_INVALID')
  })

  it('rejects BuyIntent with tampered recipient (代购 protection)', async () => {
    const intent = buildRequest({ recipient: BUYER })
    const sig = await signBuyIntent(intent)
    // Malicious relayer tries to redirect tokens to itself
    const tampered = { ...intent, recipient: '0xdeadbeef00000000000000000000000000000000' as Address }
    const r = await handleV3Relay({ intent: tampered, buyIntentSig: sig, transferAuth: FAKE_TRANSFER_AUTH }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('SIGNATURE_INVALID')
  })
})
