import { describe, it, expect } from 'vitest'
import { encodeFunctionData, parseAbi, type Address, type Hex } from 'viem'
import { signTypedData, privateKeyToAddress } from 'viem/accounts'
import {
  verifyExecuteBatchSignature,
  EXECUTE_BATCH_TYPES,
  buildDomain,
} from '../src/pipeline/verify712.js'
import { SEPOLIA } from '../src/rules/whitelist.js'
import type { Call } from '../src/pipeline/extractIntent.js'

const TEST_PK = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80' as const // anvil#0
const TEST_ADDR = privateKeyToAddress(TEST_PK)

// IMPLEMENTATION pin: AirAccountDelegate contract address used as
// EIP-712 domain.verifyingContract (constant; MetaMask-compatible).
const IMPL = SEPOLIA.AIRACCOUNT_DELEGATE

const APPROVE = parseAbi(['function approve(address spender, uint256 amount)'])

function buildCall(): Call {
  return {
    target: SEPOLIA.USDC,
    value: 0n,
    data: encodeFunctionData({
      abi: APPROVE,
      functionName: 'approve',
      args: [SEPOLIA.SALE_V2_NEW, 50_000_000n],
    }),
  }
}

async function sign(
  calls: Call[],
  nonce: bigint,
  deadline: bigint,
  verifyingContract: Address,
  pk: `0x${string}` = TEST_PK,
): Promise<Hex> {
  return signTypedData({
    privateKey: pk,
    domain: buildDomain(11155111, verifyingContract),
    types: EXECUTE_BATCH_TYPES,
    primaryType: 'ExecuteBatch',
    message: { calls, nonce, deadline },
  })
}

describe('verifyExecuteBatchSignature', () => {
  const calls = [buildCall()]
  const deadline = BigInt(Math.floor(Date.now() / 1000) + 3600)

  it('accepts a valid signature (domain pinned to IMPLEMENTATION address)', async () => {
    const sig = await sign(calls, 0n, deadline, IMPL)
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls,
      nonce: 0n,
      deadline,
      signature: sig,
    })
    expect(r.ok).toBe(true)
    if (r.ok) expect(r.recovered.toLowerCase()).toBe(TEST_ADDR.toLowerCase())
  })

  it('rejects when domain.verifyingContract differs between signer and verifier', async () => {
    // Frontend signed with a wrong verifyingContract — recovered signer won't match the buyer.
    const sig = await sign(calls, 0n, deadline, '0x0000000000000000000000000000000000000001' as Address)
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls,
      nonce: 0n,
      deadline,
      signature: sig,
    })
    expect(r.ok).toBe(false)
    if (!r.ok) expect(r.reason).toMatch(/recovered.*≠.*buyer/)
  })

  it('rejects expired deadline', async () => {
    const past = BigInt(Math.floor(Date.now() / 1000) - 60)
    const sig = await sign(calls, 0n, past, IMPL)
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls,
      nonce: 0n,
      deadline: past,
      signature: sig,
    })
    expect(r.ok).toBe(false)
  })

  it('rejects empty calls', async () => {
    const sig = await sign([], 0n, deadline, IMPL)
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls: [],
      nonce: 0n,
      deadline,
      signature: sig,
    })
    expect(r.ok).toBe(false)
  })

  it('rejects wrong signature (bit-flipped)', async () => {
    let sig = await sign(calls, 0n, deadline, IMPL)
    const flipped = (sig.slice(0, 30) + (sig[30] === '0' ? '1' : '0') + sig.slice(31)) as Hex
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls,
      nonce: 0n,
      deadline,
      signature: flipped,
    })
    expect(r.ok).toBe(false)
  })

  it('rejects nonce-mismatched signature', async () => {
    const sig = await sign(calls, 0n, deadline, IMPL)
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls,
      nonce: 1n, // signed for 0, verifying as 1
      deadline,
      signature: sig,
    })
    expect(r.ok).toBe(false)
  })

  it('rejects invalid signature length', async () => {
    const r = await verifyExecuteBatchSignature({
      buyer: TEST_ADDR,
      verifyingContract: IMPL,
      chainId: 11155111,
      calls,
      nonce: 0n,
      deadline,
      signature: '0xdeadbeef' as Hex,
    })
    expect(r.ok).toBe(false)
  })
})
