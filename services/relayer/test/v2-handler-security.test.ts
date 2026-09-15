/**
 * @file v2-handler-security.test.ts
 * @description
 *   Codex security review post-fix tests:
 *   - MEDIUM: /v2/relay  enforces chainId == sepolia.id
 *   - MEDIUM: /v2/relay  verifies authorization signer == buyer
 *   - MEDIUM: /v2/revoke enforces chainId == sepolia.id
 *   - MEDIUM: /v2/revoke verifies authorization signer == buyer
 *
 *   The HIGH "RevokeIntent EIP-712" test was removed: industry standard
 *   (Alchemy, Revoke.cash, MetaMask) is a single EIP-7702 Authorization
 *   for revoke. The authorization's chainId + nonce (single-use) +
 *   contract-address fields provide sufficient protocol-level replay
 *   protection; layering a second EIP-712 signature is overengineering
 *   and hurts UX.
 */

import { describe, it, expect } from 'vitest'
import { encodeFunctionData, parseAbi, type Hex } from 'viem'
import { privateKeyToAccount, signTypedData, signAuthorization } from 'viem/accounts'
import { handleV2Relay, handleV2Revoke } from '../src/v2/handler.js'
import { EXECUTE_BATCH_TYPES, buildDomain } from '../src/pipeline/verify712.js'
import { SEPOLIA } from '../src/rules/whitelist.js'

const BUYER_PK = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80' as const
const BUYER = privateKeyToAccount(BUYER_PK).address

const OTHER_PK = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d' as const // anvil#1
const OTHER = privateKeyToAccount(OTHER_PK).address

const ENV = {
  RPC_URL: 'http://invalid-rpc',
  OPERATOR_PK: '0x' + '11'.repeat(32) as Hex,
}

const APPROVE = parseAbi(['function approve(address,uint256)'])
const BUY = parseAbi(['function buyTokens(uint256,address,uint256)'])

function buildBuyGTokenCalls() {
  return [
    {
      target: SEPOLIA.USDC,
      value: 0n,
      data: encodeFunctionData({ abi: APPROVE, functionName: 'approve', args: [SEPOLIA.SALE_V2_NEW, 15_000_000n] }),
    },
    {
      target: SEPOLIA.SALE_V2_NEW,
      value: 0n,
      data: encodeFunctionData({ abi: BUY, functionName: 'buyTokens', args: [15_000_000n, SEPOLIA.USDC, 0n] }),
    },
  ]
}

async function signExecuteBatch(
  calls: any[],
  nonce: bigint,
  deadline: bigint,
  pk: `0x${string}`,
  verifyingContract: `0x${string}` = SEPOLIA.AIRACCOUNT_DELEGATE,
) {
  return signTypedData({
    privateKey: pk,
    domain: buildDomain(11155111, verifyingContract),
    types: EXECUTE_BATCH_TYPES,
    primaryType: 'ExecuteBatch',
    message: { calls, nonce, deadline },
  })
}

describe('handleV2Relay — Codex MEDIUM fixes', () => {
  const deadline = BigInt(Math.floor(Date.now() / 1000) + 1800)

  it('rejects chainId mismatch', async () => {
    const calls = buildBuyGTokenCalls()
    const sig = await signExecuteBatch(calls.map(c => ({ ...c, value: 0n })), 0n, deadline, BUYER_PK)
    const auth = await signAuthorization({
      privateKey: BUYER_PK,
      chainId: 1, // ← wrong chain (mainnet)
      address: SEPOLIA.AIRACCOUNT_DELEGATE,
      nonce: 0,
    })
    const r = await handleV2Relay({
      buyer: BUYER,
      calls: calls.map(c => ({ ...c, value: c.value as any })),
      deadline: Number(deadline),
      signature: sig,
      authorization: {
        chainId: auth.chainId,
        address: (auth.contractAddress ?? (auth as any).address),
        nonce: auth.nonce,
        r: auth.r as Hex,
        s: auth.s as Hex,
        yParity: (auth.yParity ?? (auth as any).v) as 0 | 1,
      },
    }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('CHAIN_ID_MISMATCH')
  })

  it('rejects authorization signed by non-buyer', async () => {
    const calls = buildBuyGTokenCalls()
    const sig = await signExecuteBatch(calls.map(c => ({ ...c, value: 0n })), 0n, deadline, BUYER_PK)
    // Authorization signed by OTHER, not BUYER
    const auth = await signAuthorization({
      privateKey: OTHER_PK,
      chainId: 11155111,
      address: SEPOLIA.AIRACCOUNT_DELEGATE,
      nonce: 0,
    })
    const r = await handleV2Relay({
      buyer: BUYER, // ← buyer is BUYER, but auth was signed by OTHER
      calls: calls.map(c => ({ ...c, value: c.value as any })),
      deadline: Number(deadline),
      signature: sig,
      authorization: {
        chainId: auth.chainId,
        address: (auth.contractAddress ?? (auth as any).address),
        nonce: auth.nonce,
        r: auth.r as Hex,
        s: auth.s as Hex,
        yParity: (auth.yParity ?? (auth as any).v) as 0 | 1,
      },
    }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('AUTH_SIGNER_MISMATCH')
  })
})

describe('handleV2Revoke — Codex MEDIUM fixes', () => {
  it('rejects revoke with chainId mismatch', async () => {
    const auth = await signAuthorization({
      privateKey: BUYER_PK,
      chainId: 1, // wrong chain
      address: '0x0000000000000000000000000000000000000000',
      nonce: 0,
    })
    const r = await handleV2Revoke({
      buyer: BUYER,
      authorization: {
        chainId: auth.chainId,
        address: (auth.contractAddress ?? (auth as any).address),
        nonce: auth.nonce,
        r: auth.r as Hex,
        s: auth.s as Hex,
        yParity: (auth.yParity ?? (auth as any).v) as 0 | 1,
      },
    }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('CHAIN_ID_MISMATCH')
  })

  it('rejects revoke authorization signed by non-buyer', async () => {
    // OTHER signs the revoke auth, but request claims BUYER as the buyer
    const auth = await signAuthorization({
      privateKey: OTHER_PK,
      chainId: 11155111,
      address: '0x0000000000000000000000000000000000000000',
      nonce: 0,
    })
    const r = await handleV2Revoke({
      buyer: BUYER,
      authorization: {
        chainId: auth.chainId,
        address: (auth.contractAddress ?? (auth as any).address),
        nonce: auth.nonce,
        r: auth.r as Hex,
        s: auth.s as Hex,
        yParity: (auth.yParity ?? (auth as any).v) as 0 | 1,
      },
    }, ENV)
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.code).toBe('AUTH_SIGNER_MISMATCH')
  })
})
