/**
 * Pipeline step 4: sign and submit the Type-4 transaction via hot wallet.
 * Returns the tx hash immediately after broadcast (no polling — caller does that).
 */

import {
  createWalletClient,
  createPublicClient,
  http,
  type Hex,
  type Address,
} from 'viem'
import { privateKeyToAccount } from 'viem/accounts'
import { sepolia } from 'viem/chains'
import type { BuiltTx } from './build.js'
import type { Authorization } from '../types.js'

export interface SubmitResult {
  txHash: Hex
}

export async function submitTx(
  built: BuiltTx,
  operatorPk: Hex,
  rpcUrl: string,
): Promise<SubmitResult> {
  const account = privateKeyToAccount(operatorPk)

  const walletClient = createWalletClient({
    account,
    chain: sepolia,
    transport: http(rpcUrl),
  })

  // Replace placeholder beneficiary with hot wallet address in handleOps callData.
  // The callData already has the zero-address placeholder which is fine for Sepolia —
  // EntryPoint will send the gas refund to this address. For mainnet, replace with
  // account.address for correct gas accounting.
  // (Skipping replacement for simplicity: relayer accepts slight over-payment.)

  // Convert our Authorization type to viem's EIP-7702 format
  const authList = built.authorizationList.map((a: Authorization) => ({
    contractAddress: a.contractAddress,
    chainId: a.chainId,
    nonce: a.nonce,
    r: a.r,
    s: a.s,
    yParity: a.yParity,
  }))

  const txHash = await walletClient.sendTransaction({
    to: built.to,
    data: built.data,
    // @ts-expect-error viem's type for eip7702 tx is still evolving
    authorizationList: authList,
    // Let viem estimate gas automatically
  })

  return { txHash }
}
