# Architecture Decision: Gasless Purchase via EIP-3009 + BuyHelper

**Status**: Accepted (2026-05-13)
**Supersedes**: P3/P4/P5 of `00-spec.md` (EIP-7702 + custom relayer path) — kept as v2 future direction, not active.

## Context

Original P1-P5 design used EIP-7702 (Pectra) + a custom relayer:
1. User EOA signs EIP-7702 Authorization to delegate to `AirAccountDelegate`.
2. User signs EIP-712 `ExecuteBatch` for `[approve(USDC), buyTokens(...)]`.
3. Relayer submits a Type-4 transaction with both, pays gas.

Implementation reached production-grade on Sepolia (contracts verified, 41 vitest + 33 Foundry tests passing). However during MetaMask integration testing on `launch.mushroom.cv/join-gasless` we hit a hard wall:

> **MetaMask (and Rabby, OKX, Coinbase Wallet) do NOT expose any dApp-facing RPC method to pre-sign an EIP-7702 Authorization separately from sending a Type-4 transaction.**

Evidence (each link verified 2026-05-13):
- viem maintainer jxom: "It is not possible to sign an authorization over JSON-RPC right now, so it won't be added into Viem until there is an ERC for it." — https://github.com/wevm/viem/discussions/3285
- MetaMask Smart Accounts Kit docs use `privateKeyToAccount` (local key) for `signAuthorization`, never a connected MM account — https://docs.metamask.io/smart-accounts-kit/get-started/smart-account-quickstart/eip7702/
- MetaMask's only 7702 JSON-RPC method is `wallet_sendCalls` (EIP-5792), which bundles the auth into a user-paid Type-4 tx — https://docs.metamask.io/wallet/reference/json-rpc-methods/wallet_sendcalls/
- All production 7702 toolchains (ZeroDev, Pimlico, Alchemy, Privy, Coinbase CDP) require a **local private key** or an **embedded wallet** — none works with a connected MetaMask.

Conclusion: the EIP-7702 + relayer flow is technically sound, but the **wallet ecosystem is not ready** to support it for users who hold their keys in a browser-extension wallet like MetaMask. There is no published ERC for the missing RPC, and no public roadmap from any wallet vendor.

For our actual user persona — **someone who deposits USDC/USDT from a CEX into a fresh MetaMask wallet and arrives at launch.mushroom.cv with no ETH** — we need a solution that works with their *existing wallet*, not one that asks them to migrate to AirAccount, Privy, or Rabby first. Early-stage users have low trust and are very reluctant to create new accounts.

## Decision

**Adopt EIP-3009 `transferWithAuthorization` + a custom `BuyHelper` contract + a thin relayer.**

### Why EIP-3009

Sepolia USDC is Circle's `FiatTokenV2` at `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238`. On-chain probing (2026-05-13) confirmed:

| Method | Result | Conclusion |
|---|---|---|
| `DOMAIN_SEPARATOR()` | returns hash | EIP-712 domain present |
| `version()` | `"2"` | Circle FiatTokenV2 |
| `nonces(addr)` (EIP-2612) | empty (`0x`) | **permit NOT supported** |
| `authorizationState(addr, bytes32)` (EIP-3009) | returns `false` | **transferWithAuthorization supported** |

EIP-3009 lets the user sign a typed-data message authorizing a transfer from themselves to a specific address, validated by the USDC contract on a later `transferWithAuthorization` call. The signature is a standard `eth_signTypedData_v4` payload that **every EVM wallet supports** (MetaMask, Rabby, OKX, hardware wallets, AirAccount, etc.).

### Why custom `BuyHelper`

The user signs:
1. **EIP-3009 `TransferWithAuthorization`** (USDC's own domain) — sends 15 USDC from user to `BuyHelper` contract.
2. **`BuyIntent` EIP-712** (our domain) — encodes `{targetToken, recipient, minOut, deadline, nonce}`.

`BuyHelper.executeBuy(transferAuthSig, buyIntent, buyIntentSig)` does the following on-chain:
1. `USDC.transferWithAuthorization(...)` — pulls USDC from user to `BuyHelper`.
2. `USDC.approve(saleContract, amount)`.
3. `saleContract.buyTokens(amount, USDC, buyIntent.minOut)` — `BuyHelper` receives the purchased token.
4. `purchasedToken.transfer(buyIntent.recipient, amount)` — delivers to user's specified address (defaults to `tx.origin`-equivalent = the user; can be a third party for 代购).

A relayer (operator wallet) submits this as a regular EIP-1559 Type-2 tx, paying gas itself. No EIP-7702 anywhere.

### One-signature variant (no 代购)

If the user does NOT need a custom recipient (the most common case), we can collapse to ONE signature by encoding the BuyIntent fields into the EIP-3009 `nonce` field as `nonce = keccak256(abi.encode(targetToken, minOut, deadline))`. `BuyHelper` recomputes and verifies. The recipient is fixed to the payer.

Frontend UX:
- Default: 1 MM popup (EIP-3009 only, recipient = self).
- Toggle "Send to different address" (代购): 2 MM popups (EIP-3009 + BuyIntent).

## Options considered

| # | Approach | One-sig | 代购 | Wallet RPC needed | AA account needed | Maturity | Fit for 5-18 roadshow |
|---|---|---|---|---|---|---|---|
| **A** ⭐ | **EIP-3009 + BuyHelper + relayer** | ✅¹ | ✅² | None (standard `eth_signTypedData_v4`) | None | Production (Uniswap / 1inch / CowSwap pattern, 3+ years) | **✅ 1.5 days** |
| B | ERC-4337 + AirAccount AA + SuperPaymaster | ✅ (single UserOp) | ✅ | None | **Yes** (user creates AA) | Production (Stackup / Pimlico / ZeroDev) | ⚠️ SuperPaymaster Sepolia not ready; user must onboard to AA |
| C | EIP-7702 + AirAccount embedded wallet + custom relayer | ✅ | ✅ | None (we control the key) | Yes (AirAccount embedded) | Production (Privy / Coinbase CDP pattern) | ⚠️ Requires AirAccount SDK integration; user must use AirAccount |
| D | EIP-7702 + MetaMask + custom relayer (original plan) | — | — | `wallet_signAuthorization` — **does not exist in any wallet** | None | **Blocked indefinitely** — no ERC, no wallet vendor roadmap | ❌ Impossible today |

¹ One sig when recipient = payer (most common case); two sigs when 代购 is enabled.
² 代购 = pay from wallet A, deliver to wallet B (third-party gift / agent purchase).

### Why not B (ERC-4337 + AA) for the primary user flow

The product-level argument: **early-stage users from CEX don't trust us enough to create a new account**. They want to use the wallet they already have (MetaMask, OKX). Asking them to "create an AirAccount AA first" adds onboarding friction and trust burden right when we need their first impression to feel familiar.

ERC-4337 + AirAccount + SuperPaymaster is the right architecture for **power users** who opt-in: they get programmable accounts, aPNTs gas credits, batched ops, etc. That's a separate product surface ("Mycelium Pro" / "AA flow"), reached through deeper engagement — not the initial purchase landing page.

So:
- **launch.mushroom.cv/join-gasless** (the public marketing/sale page) → **plan A** (EIP-3009, user's own EOA).
- **AirAccount onboarding + Mycelium Pro features** (later) → **plan B** (ERC-4337 + SuperPaymaster), as a parallel track.

Plans B and C are valuable future directions, but they are **a different product line**, not a replacement for the EOA-based public flow.

### Why not C (EIP-7702 + AirAccount embedded) for the primary user flow

Same product-level reason: requires migrating the user off MetaMask. Even if technically clean, the user-acquisition friction is unacceptable for the public funnel.

The existing AirAccountDelegate contract + relayer Type-4 code stays in the repo but is paused. If a future wave of wallet vendors adopts `wallet_signAuthorization`, we can reactivate it in one sprint.

## What changes

### Stays
- `SaleContractV2` (`0x3e4e0A66...`), `APNTsSaleContract` (`0xf1a5FE67...`), `GToken` (`0x4e6A1125...`), `aPNTs` (`0x4C4EC2e8...`) — unchanged.
- Relayer operator wallet (`0x4Bec0b1c...`, 0.5 ETH funded) — reused.
- Cloudflare Worker deployment infra — reused.
- `site/join.html` (regular non-gasless flow) — unchanged.

### Paused (kept in repo as v2 reference)
- `AirAccountDelegate.sol` (`0x0BC1A36d...`) — paused, no UI calls it.
- `services/relayer/src/v2/handler.ts` (`/v2/relay`, `/v2/revoke`) — paused.
- `site/join-gasless.html` — to be rewritten (or replaced by `site/join-gasless-v3.html`).
- Foundry fork tests `GaslessE2E_ForkSepolia.t.sol` — paused (kept for reference).

### New (deployed 2026-05-13)
- `contracts/src/BuyHelper.sol` — EIP-3009 entry + buy + recipient-split.
  Deployed Sepolia: **`0x578D6f74d8bDA18Cc3b834C1bd74674c529250e7`** (verified on Etherscan).
- `contracts/test/BuyHelper_ForkSepolia.t.sol` — 9 fork tests passing (happy paths A/B/C, replay, signer mismatch, expired, slippage, unsupported target, zero recipient).
- `services/relayer/src/v3/handler.ts` — `/v3/relay` endpoint.
- `services/relayer/src/pipeline/verifyEip3009.ts` and `verifyBuyIntent.ts`.
- Frontend: replace the 7702 signing flow with EIP-3009 + BuyIntent flow.
- Docs: this file; update `00-spec.md` to mark v1 as paused.

## Risks

- **EIP-3009 nonce reuse** — each tx uses a unique random `nonce` (bytes32); USDC contract enforces single-use via `_authorizationStates` mapping. Replay impossible.
- **`BuyHelper` left with stranded USDC if buy fails** — wrap steps 1-4 in a single transaction; if any step reverts, the whole tx reverts and USDC stays with user.
- **`BuyHelper` left with stranded purchased token if final transfer fails** — recipient is validated upfront (must be non-zero address); transfer is final ERC-20 standard call.
- **Relayer DoS via crafted unprofitable requests** — keep existing whitelist (only sponsor specific function selectors with whitelisted payment tokens and bounded amounts).
- **Recipient griefing** — user signs `recipient` themselves; relayer cannot change it.

## Acceptance criteria for v3

- [ ] User with 0 ETH and ≥ 15 USDC on Sepolia can buy 100 GT in one click + one MM popup.
- [ ] Optional second popup for 代购 (different recipient).
- [ ] Same flow works for buying aPNTs.
- [ ] Replay (same EIP-3009 signature twice) is blocked by USDC's `_authorizationStates`.
- [ ] Relayer rejects calldata not matching the whitelist.
- [ ] Operator wallet ETH balance is the only thing consumed; user pays 0 gas.
