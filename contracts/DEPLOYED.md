# Deployed Contracts

## Sepolia — 审计修复 (EIP-3009 receiveWithAuth + balance-delta, 2026-06-24) — CURRENT

Codex 全面审计后重部署：BuyHelper 改用 `receiveWithAuthorization`（防 EIP-3009 抢跑致用户资金卡死）
+ balance-delta received + owner `sweepToken`；SaleContractV2 milestone 追加后即时推进。
⚠️ **签名格式变**：SDK/前端的 EIP-3009 primaryType 须 `TransferWithAuthorization` → `ReceiveWithAuthorization`。

| Contract | Address |
|---|---|
| GToken (canonical) | `0x20a051502a7AE6e40cfFd6EBe59057538E698984` |
| aPNTs (canonical) | `0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b` |
| SaleContractV2 | `0xA563fA13E2353aE7D65FCE37F4801288CD11FC3e` |
| APNTsSaleContract | `0x9cF028D17b40E5249Ce119a2E642A6eC91a285D0` |
| BuyHelper (receiveWithAuth, 3 DVT relayer) | `0x8d08fBD8297355BC93397820AE1CfFD884BEaA00` |
| USDC | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` |
| USDT | `0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0` |
| Deployer / treasury / owner | `0xb5600060e6de5E11D3636731964218E53caadf0E` |

- 库存：500 GT / 5000 aPNTs；USDC+USDT accepted；`capExempt[BuyHelper]`=true；`isRelayer` dvt1/2/3=true。
- 发布门：非 fork 138 + fork E2E 15/15（receiveWithAuth 实测）+ Codex GO（PR #26）。
- 周知：`scripts/release-notify.sh --changes addr,sig`（SDK 改签名 typehash + 换地址；DVT 换 `RELAY_BUY_HELPER`）。

## Sepolia — buyTokensFor + 发布门 hardening (2026-06-23) — superseded by the above

Sale stack redeployed: adds `buyTokensFor` / `buyAPNTsFor` (self-pay with an explicit
recipient — buy into AirAccount, aastar-sdk#145 gap 2) + release-gate hardening
(cap-exempt BuyHelper, `executeBuy` onlyRelayer whitelist of the 3 DVT operators,
recipient events, CEI fixes). Same canonical SuperPaymaster GToken / aPNTs.

| Contract | Address |
|---|---|
| GToken (canonical, SuperPaymaster) | `0x20a051502a7AE6e40cfFd6EBe59057538E698984` |
| aPNTs (canonical) | `0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b` |
| SaleContractV2 (→ canonical GToken) | `0x86aC0278fAFA3Bf51e18426937A264e16B78bce4` |
| APNTsSaleContract (→ canonical aPNTs) | `0x1cE31924EE7e0296d6b739d0bC96B354CA55b30C` |
| BuyHelper (gasless, 3 DVT relayer whitelist) | `0xF78f898413ef069C870A554f47B66eC6D9c5B429` |
| USDC (payment) | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` |
| USDT (payment) | `0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0` |
| Deployer / treasury / owner | `0xb5600060e6de5E11D3636731964218E53caadf0E` |

- Prices: GToken $0.15 · aPNTs $0.02. Inventory: 500 GT → SaleV2, 5000 aPNTs → APNTsSale.
- gasless relayer = **DVT relay** (3 operators dvt1/2/3, AAStarCommunity/dvt#5); BuyHelper
  `isRelayer` whitelist = those 3. Old Cloudflare Worker (`0x4Bec0b1c…`) deprecated.
- On-chain verified: `isRelayer[dvt1/2/3]`=true, `capExempt[BuyHelper]`=true, USDC+USDT
  accepted, whitelistRequired=false, inventory funded, owner can add/removeRelayer.
- Released through the gate: tests + self-review + Codex ×3 (GO) + fork E2E 6/6 (PRs #22/#23/#24).
- Note: supplier was EIP-7702 delegated; revoked before deploy (tx `0xd77e0281…`).

## Sepolia — Path A (canonical-bound stack, 2026-06-21) — superseded by the above

Sale stack redeployed bound to the **canonical SuperPaymaster GToken / aPNTs** (the
authoritative ecosystem tokens), replacing the earlier test-token-bound deployment.

| Contract | Address |
|---|---|
| GToken (canonical, SuperPaymaster) | `0x20a051502a7AE6e40cfFd6EBe59057538E698984` |
| aPNTs (canonical) | `0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b` |
| SaleContractV2 (→ canonical GToken) | `0x29eE47dEBD0E60d426352415749b4899057D913F` |
| APNTsSaleContract (→ canonical aPNTs) | `0x136654d4141d151e9C237af65E98c03e22afc142` |
| BuyHelper (gasless, → canonical + new sales) | `0x0EA2AEd239574F4e875Ae570C67825da845E7e66` |
| USDC (payment) | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` |
| Deployer / treasury / owner | `0xb5600060e6de5E11D3636731964218E53caadf0E` |

- Prices: GToken $0.15 · aPNTs $0.02. Inventory funded: 500 GT → SaleV2, 5000 aPNTs → APNTsSale.
- Verified on-chain: self-pay buy succeeded (canonical GT received). Gasless requires the
  relayer whitelist to be updated to the new BuyHelper + canonical tokens.
- **TODO (relayer)**: whitelist BuyHelper `0x0EA2AE…`, sales `0x29eE47…`/`0x136654…`, and
  target tokens `0x20a051…`/`0x9e66B…` in `services/relayer` (whitelist.ts + wrangler.toml).

## Sepolia Testnet (legacy — test-token-bound, superseded by Path A above)

| Contract | Address | Etherscan |
|---|---|---|
| GToken (SuperPaymaster) | 0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0 | [link](https://sepolia.etherscan.io/address/0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0) |
| SaleContract v1.2.1 | 0x9cA2520D4Fa7e207211Ef5903E7918F06B3faDBA | [link](https://sepolia.etherscan.io/address/0x9ca2520d4fa7e207211ef5903e7918f06b3fadba) |

Treasury (Safe): 0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114
Owner (deployer): 0xEcAACb915f7D92e9916f449F7ad42BD0408733c9
Accepted Payment: USDC (0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238)
Whitelist: Disabled (open sale)
Starting Price: $0.15 / GToken
Inventory: 4,200,000 GT

## Deployment Details (v1.2.1)

- Network: Sepolia (Chain ID: 11155111)
- Deploy Date: 2026-04-09
- Constructor Args: `(gToken=0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0, treasury=0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114, owner=0xEcAACb915f7D92e9916f449F7ad42BD0408733c9)`
- Post-deploy config:
  - `setPaymentToken(USDC, true)` - USDC accepted
  - `setWhitelistRequired(false)` - open sale
  - `mint(saleContract, 4_200_000e18)` - GToken inventory loaded
- Verified on Etherscan: Yes
- Security: Codex-reviewed (3 rounds), 79 tests pass

## Deprecated

| Contract | Address | Reason |
|---|---|---|
| SaleContract v1.0.0 | 0x1da9e61ABa8363Efe7D2910d96662fDc544eE2E7 | superseded by v1.2.1 |
| SaleContract v1.0.0 | 0x6b9f8132389Ac377dBd097656a8F55bCf46E5889 | superseded by v1.2.1 |
