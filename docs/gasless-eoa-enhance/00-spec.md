# EOA-Enhance Gasless Purchase — Specification

> ⚠️ **STATUS: PAUSED (2026-05-13)** — the EIP-7702 + custom relayer design described in this file is **architecturally sound but operationally blocked**: no browser-extension wallet (MetaMask, Rabby, OKX, Coinbase Wallet) currently exposes a JSON-RPC method for dApps to pre-sign an EIP-7702 Authorization. See [`02-architecture-decision-eip3009.md`](02-architecture-decision-eip3009.md) for full evidence and the EIP-3009-based replacement (active).
>
> Code in this branch (`AirAccountDelegate.sol`, `v2/handler.ts`, `join-gasless.html`, `GaslessE2E_ForkSepolia.t.sol`) is kept as v2 reference for the day wallet vendors adopt `wallet_signAuthorization`. Do not delete.

---

> **目标**：让一个钱包里**只有 USDC（或将来 USDT）、没有 ETH 的 EOA 用户**，在 launch.mushroom.cv/join 上**完全 gasless** 地买到 GToken 或 aPNTs；并能随时**主权式撤销**自己的 EIP-7702 委托。
>
> **设计原则**：开源透明白名单（"我们只赞助这两件事"）+ 可扩展（未来加 token / NFT / 支付币种 / 费率）+ 标准合规（EIP-7702 + EIP-712 + ERC-4337 v0.7）+ MetaMask 友好。
>
> **文档地位**：本目录 `docs/gasless-eoa-enhance/` 是该 feature 的源真相。所有任务/组件状态以本目录为准。

---

## 1. 链上部署快照（Sepolia · 2026-05-11 19:47 锚定）

```jsonc
{
  // —— 核心 token ——
  "aPNTs":                "0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772",
  "gToken":               "0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67",
  "pnts":                 "0x83ca2b02f325B2C2e846BFe7582993acD10E5cc8",  // user 称之为 "mPNTs"

  // —— Paymaster 栈 ——
  "entryPoint":           "0x0000000071727De22E5E9d8BAf0edAc6f37da032",  // ERC-4337 v0.7
  "superPaymaster":       "0x33404ccD9559759b85302cFfB19e66dA25380aDf",  // 主入口（proxy）
  "spImpl":               "0x6B84C7A49E6A4fB139f279B148359E82dB6370eE",  // implementation
  "paymasterV4Impl":      "0xC2a08d1d6e14c7E1306c53A787CEDA50E69b2836",
  "paymasterFactory":     "0x9c80Fe26bDd01bEb958d6560fcbF2d1F511C4629",
  "anniPaymaster":        "0x1f0D4eF151a79948070D387BaC43b1321F0c41e3",

  // —— Registry / Identity / Reputation ——
  "registry":             "0xa62EFc8a9138617E245bd21BcF5b5E406D864525",
  "agentIdentityRegistry":"0x400624Fa1423612B5D16c416E1B4125699467d9a",
  "agentReputationRegistry":"0x2D82b2De1A0745454cDCf38f8c022f453d02Ca55",
  "reputationSystem":     "0xE25E29e32D62f8BE8a61EfD8C7f1d431B95FB8b3",
  "sbt":                  "0xA74820A243B34904290ae4e614cE9cCE6e242fA4",

  // —— Staking / DVT / 其他 ——
  "staking":              "0x197D243Ee21815a6419406B066626db94D8D7F99",
  "dvtValidator":         "0x70a06AC908e3589B0B9DC35D657D96Fa1F0Fb1f1",
  "blsAggregator":        "0x01E18f6460d1e4581E2c7Dd3A65e3eF26e962F16",
  "microPaymentChannel":  "0x5753e9675f68221cA901e495C1696e33F552ea36",
  "xPNTsFactory":         "0x0195f1f30276f1455F650207F9A1D2AAeABBEc7D",

  // —— 工具 ——
  "priceFeed":            "0x694AA1769357215DE4FAC081bf1f309aDC325306",
  "simpleAccountFactory": "0x91E60e0613810449d098b0b5Ec8b51A0FE8c8985",

  // —— 来源 hash ——
  "srcHash":              "cba6f5ac05ad5ee47782428648fc0691bb98ce8e4eb70444942a1fe8a3d85b31",
  "updateTime":           "2026-05-11 19:47:00"
}
```

**额外辅助合约**：
- `USDC (Sepolia)` = `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238`（Circle 官方）
- `MockGToken` = `0x25c78eF9830b9b7a705B1E5b19939dFB465fF37F`（V2 销售用，与上面 gToken 不同）
- `SaleContractV2` = `0xD2E2566566D459115D4159993E96c45c0d2cE6CD`（绑定 MockGToken）
- **`SaleContractV2` (NEW, gToken-bound)** = `0x3e4e0a663682a2d58d626d0057142328ef0b626a`（已部署 + verified, owner=ANNI, 库存 100 GT）— 取代 MockGToken 版本作为 gasless 流程的目标
- **`APNTsSaleContract`** = `0xf1a5fe670dbf6c5219000b30500a98f772ef1f14`（已部署 + verified, owner=ANNI, 价格 $0.02 / aPNTs, 库存 1000 aPNTs）
- **`AirAccountDelegate`** = `0x0BC1A36d932e2E9efA33b98043a73b8Be1a6E9Fc`（已部署 + verified, 2026-05-12, owner-less / immutable）

⚠ **未决问题**：
- 是否把 SaleContractV2 重新部署绑定到新 gToken `0x4e6A1125...`（替换 MockGToken）？或保持现状（USDC 直购走 MockGToken，gasless 也走同一个 sale）？— 见 §9 决策点 D1
- SP 实现合约 (`spImpl`) 是否 Etherscan verified？— 见 §9 决策点 D2

---

## 2. 用户故事 + 流程

### 流程 A — Gasless 买 GToken（核心）

```
[前端 join.html]
  detect: provider.getBalance(EOA) < gasFloor (0.001 ETH)
  show: "你没有 ETH 也能买 — 我们帮你付 gas（只针对这 2 个操作）"

  ① 用户签 EIP-712 typed "PurchaseIntent"
     domain: { name: "Mycelium Gasless Buy", version: "1", chainId, verifyingContract: AirAccountDelegate }
     primaryType: "PurchaseIntent"
     message: { kind: "GTOKEN", paymentToken: USDC, usdAmount, minTokensOut, nonce, deadline }

  ② 用户签 EIP-7702 Authorization
     { chainId, address: AirAccountDelegate, nonce }
     -> raw signature (r, s, yParity)

[Relayer / Cloudflare Worker]
  ③ POST /relay  body = { intent, intentSig, authorization }
  ④ 校验：
     - intent.kind ∈ Whitelist
     - intent.paymentToken ∈ {USDC}
     - intent.target = SaleContractV2 (GToken sale)
     - authorization.contract = AirAccountDelegate (除非 kind = REVOKE)
     - deadline 未过 / nonce 未用
     - 用户 USDC 余额 + allowance OK
  ⑤ 构造 Type-4 transaction：
     authorizationList = [authorization]
     to = EOA (now temporarily smart)
     data = AirAccountDelegate.executeBatch([
       (USDC, 0, approve(SaleContractV2, usdAmount)),
       (SaleContractV2, 0, buyTokens(usdAmount, USDC, minTokensOut))
     ])
  ⑥ relayer 代付 gas，提交 tx

[链上]
  - EOA 临时变成 AirAccountDelegate 形态
  - executeBatch 内调用 USDC.approve + SaleV2.buyTokens
  - GToken 转给 EOA
  - tx 完成后，EOA delegation 保留（除非用户后续 revoke）

[Frontend 提示]
  - 刷新余额，显示新购买的 GToken
  - 提醒："你的 EOA 现在仍指向 AirAccountDelegate，如需撤销见 §B"
```

### 流程 B — Gasless 买 aPNTs（与 A 相同模板）

差异：
- `intent.kind = "APNTS"`
- `intent.target = APNTsSaleContract`（待部署）
- `executeBatch` 第二个 call → `APNTsSaleContract.buyTokens(...)`
- 其他校验流程完全相同

### 流程 C — Gasless 撤销 EIP-7702 委托（用户主权）

```
[前端]
  显示按钮："解除委托 / Revoke Delegation"（中英文标签都要）
  解释："撤销后，你的 EOA 将不再委托给 AirAccountDelegate；任何 gasless 操作都需要重新授权。"

  ① 用户签 EIP-712 typed "RevokeIntent"
     domain 同上
     message: { kind: "REVOKE", nonce, deadline }

  ② 用户签 EIP-7702 Authorization
     { chainId, address: 0x0000000000000000000000000000000000000000, nonce }
     —— 关键：contract = ZERO address 表示**清除委托**

[Relayer]
  ③ POST /revoke  body = { intent, intentSig, authorization }
  ④ 校验：
     - intent.kind == "REVOKE"
     - authorization.contract == address(0)
  ⑤ 构造 Type-4 tx：
     authorizationList = [zero-authorization]
     to = EOA, data = 0x （no-op）
     ←—— 这一笔的唯一目的就是让链上处理 authorization，把 EOA code 清空

[链上]
  - EOA code 槽清空
  - 之后用户 wallet 再调用任何东西，都是普通 EOA

[Frontend]
  - 显示成功 + 解释："你的钱包已恢复普通 EOA 状态"
```

---

## 3. 架构分层

```
┌───────────────────────────────────────────────┐
│  Frontend (site/join.html + 可拆出 join.js)    │
│  - detect ETH balance, route to gasless or直购 │
│  - EIP-712 typed signing                       │
│  - EIP-7702 authorization signing              │
│  - call relayer + show result                  │
└──────────────────┬────────────────────────────┘
                   ↓ POST /relay /revoke
┌───────────────────────────────────────────────┐
│  Relayer (Cloudflare Worker)                   │
│  - Whitelist enforcement (扩展点见 §4)          │
│  - Replay protection (intent nonce + deadline) │
│  - SuperPaymaster integration (gas 代付)        │
│  - Construct + submit Type-4 tx                │
└──────────────────┬────────────────────────────┘
                   ↓ Type-4 tx
┌───────────────────────────────────────────────┐
│  On-chain (Sepolia)                            │
│  - EntryPoint v0.7                             │
│  - SuperPaymaster (0x33404ccD...)              │
│  - AirAccountDelegate (待部署)                  │
│  - SaleContractV2 / APNTsSaleContract          │
│  - gToken / aPNTs / USDC                       │
└───────────────────────────────────────────────┘
```

---

## 4. 白名单扩展性设计（关键）

**今天**只赞助 3 种操作。但白名单数据结构**预留 5 个扩展维度**：

```typescript
// services/relayer/src/whitelist.ts (待开发)

/** 一条白名单规则。整个白名单是 SponsorRule[] */
interface SponsorRule {
  /** 操作类型（kind）。每加一类要 review，但加新 kind 只是常量+处理函数 */
  kind: 'TOKEN_BUY' | 'NFT_MINT' | 'REVOKE' | string;  // ← 扩展点 D-1：新增 kind

  /** 目标合约（sale / NFT / 任意）。null 表示 kind=REVOKE 等无 target 场景 */
  target: Address | null;                              // ← 扩展点 D-2：每个 kind 可多 target

  /** 被调用的函数 selector。例：'buyTokens(uint256,address,uint256)' */
  functionSelector: string;                            // ← 扩展点 D-3：每个 target 可多 selector

  /** 允许的支付 token (ERC20)。空数组表示无支付 (revoke / 免费 mint) */
  paymentTokens: Address[];                            // ← 扩展点 D-4：USDC/USDT/未来更多
  
  /** 每笔费率（基点，10000=100%）— 给 relayer 自身的服务费 */
  feeBps?: number;                                     // ← 扩展点 D-5：默认 0
  feeRecipient?: Address;

  /** 单笔上限（防滥用，单位是支付 token 的 raw 数值，例 USDC 6dec） */
  maxAmountPerTx?: bigint;
  maxAmountPerUserPerDay?: bigint;

  /** 启用/禁用，便于热下线某条规则 */
  enabled: boolean;
}

/** 当前规则集（今天的 launch）。未来通过 PR 或 KV 热更新追加 */
const RULES: SponsorRule[] = [
  {
    kind: 'TOKEN_BUY',
    target: '0x3e4e0a663682a2d58d626d0057142328ef0b626a',  // SaleContractV2-new (gToken-bound)
    functionSelector: 'buyTokens(uint256,address,uint256)',
    paymentTokens: ['0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238'],  // USDC
    maxAmountPerTx: 864_000_000n,  // $864 per-person cap aligned with on-chain
    enabled: true,
  },
  {
    kind: 'TOKEN_BUY',
    target: '0xf1a5fe670dbf6c5219000b30500a98f772ef1f14',  // APNTsSaleContract
    functionSelector: 'buyAPNTs(uint256,address)',          // note: different selector from SaleV2
    paymentTokens: ['0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238'],
    maxAmountPerTx: 864_000_000n,
    enabled: true,
  },
  {
    kind: 'REVOKE',
    target: null,
    functionSelector: '',
    paymentTokens: [],
    enabled: true,
  },
];
```

**5 个扩展维度对照**：

| 维度 | 今天 | 将来扩展示例 |
|------|------|-------------|
| **D-1 操作 kind** | TOKEN_BUY / REVOKE | NFT_MINT / SBT_CLAIM / SUBSCRIBE_RENEW |
| **D-2 同 kind 多 target** | 2 个 sale | 第三个 sale / xPNTs / 任意社区铸币合约 |
| **D-3 同 target 多 selector** | 1 个 buyTokens | buyTokens / claimAirdrop / mintFor |
| **D-4 支付 token 多元化** | USDC | + USDT / DAI / 主网 ETH / 任意 6/18 dec ERC20 |
| **D-5 费率配置** | 默认 0%（路演期免费）| 后续可对部分操作收 0.1–0.5% 服务费维持 relayer 自营 |

每个维度都是**"加规则不改架构"**——白名单是数据，不是代码 fork。

---

## 5. EIP-712 签名 Schema

> 关键考量：MetaMask 显示要友好（人话）+ 防 replay + 防错链 + 防过期。

### 5.1 Domain（所有签名共用）

```typescript
const domain = {
  name: 'Mycelium Gasless Buy',
  version: '1',
  chainId: 11155111,  // Sepolia (主网时换)
  verifyingContract: AIRACCOUNT_DELEGATE,  // EOA 委托目标合约地址
};
```

### 5.2 PrimaryType: `PurchaseIntent`（流程 A/B 共用）

```typescript
const types = {
  PurchaseIntent: [
    { name: 'buyer',         type: 'address' },  // = EOA 自己，防 cross-user replay
    { name: 'kind',          type: 'string'  },  // 'TOKEN_BUY'
    { name: 'target',        type: 'address' },  // SaleContractV2 / APNTsSaleContract
    { name: 'paymentToken',  type: 'address' },  // USDC
    { name: 'usdAmount',     type: 'uint256' },  // 6dec
    { name: 'minTokensOut',  type: 'uint256' },  // 18dec, slippage guard
    { name: 'nonce',         type: 'uint256' },  // per-buyer counter
    { name: 'deadline',      type: 'uint256' },  // unix ts
  ],
};
```

### 5.3 PrimaryType: `RevokeIntent`（流程 C）

```typescript
const types = {
  RevokeIntent: [
    { name: 'buyer',    type: 'address' },
    { name: 'kind',     type: 'string'  },   // 'REVOKE'
    { name: 'nonce',    type: 'uint256' },
    { name: 'deadline', type: 'uint256' },
  ],
};
```

### 5.4 MetaMask 显示效果（示意）

```
═══ 签名请求 ═══
来自：Mycelium Gasless Buy (v1)
合约：0xAirAccountDelegate...

  买方：     0xYourAddress
  操作：     TOKEN_BUY
  目标合约：  0xD2E2566...（SaleContractV2）
  支付：     50.00 USDC
  最少获得：  333.33 GT
  过期时间：  2026-05-12 14:30 UTC

请确认这是你打算执行的操作。
```

中文版（前端可选切换语言显示提示，但签名内容仍是英文）。

---

## 6. 组件与任务拆解（可并行执行）

| 组件 | 任务 | 文件 | 依赖 | 并行编号 |
|------|------|------|------|---------|
| **C1 · AirAccountDelegate 合约** | 部署 EIP-7702 委托目标合约（executeBatch + receive ETH） | `contracts/src/AirAccountDelegate.sol` | — | **P1** |
| **C2 · AirAccountDelegate 测试 + 部署** | Foundry test + deploy script + Sepolia 部署 | `contracts/test/AirAccountDelegate.t.sol`、`contracts/script/DeployAirAccountDelegate.s.sol` | C1 | **P1** |
| **C3 · APNTsSaleContract 部署** | 部署到 Sepolia + accept USDC + 注入 aPNTs 库存 | `contracts/script/DeployAPNTsSale.s.sol` | — | **P1**（与 C1 平行） |
| **C4 · Relayer 白名单 + 扩展** | `whitelist.ts` + 校验逻辑 + `/relay` 扩展 + `/revoke` endpoint | `services/relayer/src/whitelist.ts`、`services/relayer/src/index.ts` | — | **P2**（与 P1 并行） |
| **C5 · Relayer EIP-712 验签 + 构造 Type-4** | typed-data verify + 构造 authorizationList + 提交 | `services/relayer/src/pipeline/{verify,build}.ts` | C4 | **P2** |
| **C6 · Frontend 入口检测 + 路由** | ETH balance 检测、UI 切换、token 类型选择器 | `site/join.html`（或拆 `site/join.js`） | — | **P3**（与 P1/P2 并行） |
| **C7 · Frontend 签名 UX** | EIP-712 typed signing + EIP-7702 authorization signing | `site/join.html` | C6 | **P3** |
| **C8 · Frontend Revoke 按钮** | 中英文双语 label / 解释 / 调 /revoke 接口 | `site/join.html` | C6 | **P3** |
| **C9 · 集成测试** | Foundry fork-Sepolia 跑通 A/B/C 三条路径 | `contracts/test/GaslessE2E.t.sol` | C1/C2/C3 + 部署 | **P4**（串行，依赖 P1 完成） |
| **C10 · Codex review + 修复** | 调用 codex 做安全 review，修复发现 | — | C5/C7/C9 | **P5** |
| **C11 · 生产部署 + wrangler config** | wrangler.toml vars 填入、`wrangler deploy` relayer | `services/relayer/wrangler.toml` | C5 部署完 | **P5** |
| **C12 · 文档 + 发布说明** | 完成 user-facing 指南 + 安全说明 | `docs/gasless-eoa-enhance/RUNBOOK.md` | C9 通过 | **P5** |

**并行阶段**：
- **P1**（C1+C2+C3）：合约部署，~2 天，独立无依赖
- **P2**（C4+C5）：Relayer 改造，~2 天，可与 P1 并行
- **P3**（C6+C7+C8）：Frontend 改造，~2 天，可与 P1/P2 并行
- **P4**（C9）：集成测试，~1 天，需 P1 完成
- **P5**（C10+C11+C12）：审计、上线、文档，~1 天

**预计总工期**：**4–5 天**（高度并行的话），**6–7 天**（保守串行）。

---

## 7. SuperPaymaster 集成方案（待 verify SP 源码后细化）

**当前未知**：
- SP `0x33404ccD...` 字节码 ~285 bytes（最小代理）→ implementation `0x6B84C7A4...`
- 两个合约 Etherscan **都未 verify** → 不能直接拿 ABI
- 需要从 SuperPaymaster 原 repo 找源码 或 等 David 同步 verify

**预设接入方式**：标准 ERC-4337 v0.7 paymaster 接口
```solidity
function validatePaymasterUserOp(
  PackedUserOperation calldata userOp,
  bytes32 userOpHash,
  uint256 maxCost
) external returns (bytes memory context, uint256 validationData);
```

Relayer 在构造 UserOp 时填 `paymasterAndData = abi.encodePacked(SP_ADDRESS, validUntil, validAfter, signature)`。

**待定**（决策点 D2/D3）：
- SP 是否需要 relayer signer 私钥签 userOpHash？或者直接 trust whitelist？
- 是否有 PNT 余额作为代付额度（per anniPaymaster 设计）？需要 relayer 自己持有 PNTs?

---

## 8. 安全设计

### 8.1 Replay 防护（多层）

| 层 | 机制 |
|---|------|
| **Intent (EIP-712)** | `nonce` per-buyer + `deadline` |
| **EIP-7702 Authorization** | EIP-7702 自带 nonce（链上 EOA nonce）|
| **UserOp** | EntryPoint 自己防 replay（nonce 槽）|
| **SuperPaymaster** | 之前 PR #84 加的 `burnFromWithOpHash` 用 opHash 一次性 |

### 8.2 资金安全

- Relayer hot wallet（OPERATOR_PK）只放 wrangler secret
- SuperPaymaster 自己有 ETH 余额上限 / per-block 上限
- 任何一条白名单规则都有 `maxAmountPerTx` + `maxAmountPerUserPerDay`

### 8.3 用户主权

- **任何时候用户可签 REVOKE 撤销委托** — 这是 EIP-7702 的本质，谁也夺不走
- 撤销后即使 relayer 想继续帮该 EOA 发 7702 tx 也无效（因为 EOA 必须再签新 authorization）
- AirAccountDelegate 合约应该 **immutable**，不引入 upgrade 风险

### 8.4 透明性

- AirAccountDelegate / APNTsSale 全部 **Etherscan verify**
- 白名单规则（`whitelist.ts`）在 GitHub 公开
- Relayer logs 关键操作（仅 metadata，不存私钥/原始签名）

### 8.5 防滥用

- Per-address rate limit（KV 维护，1h 内 N 次）
- Global rate limit（每小时 N 次）
- 单笔金额 hard cap

---

## 9. 决策点（需 user 拍板）

| ID | 问题 | 选项 | 待 |
|----|------|------|---|
| **D1** | gToken：用现在的 MockGToken (`0x25c78eF9...`, 855K supply, owner=ANNI) 还是切到新部署 gToken (`0x4e6A1125...`, 2200 supply, owner=?)? | (a) 保持 MockGToken — 改动小 (b) 切到新 gToken — 需要重部 SaleV2 + 转移库存 + 站点全切 | user |
| **D2** | SP 实现源码哪来？ | (a) 从 SuperPaymaster repo clone 一份 (b) 等 David Etherscan verify 后从链上拿 | user / David |
| **D3** | Relayer 是否需要持有 PNTs 作为 paymaster 代付额度？ | 看 SP 设计 — verify 后再答 | 等 SP verify |
| **D4** | 单笔上限 + 日上限定多少？ | 提议：单笔 = $864（与 on-chain perPersonCap 对齐）；日上限 = $864 × 5 = $4320 | user |
| **D5** | Relayer 域名 — 用 `mycelium-relayer.workers.dev`（默认）还是绑自定义 (`relayer.mushroom.cv`)? | 默认就好，自定义路演后做 | user |

---

## 10. 时间线 + 里程碑

| 里程碑 | 完成标志 | 目标日期 |
|-------|---------|---------|
| **M0** spec 通过 | 本文档 user approved + PR 提交 | 2026-05-12 |
| **M1** 合约 ready | AirAccountDelegate + APNTsSale 部署 Sepolia + verified | M0 + 2 天 |
| **M2** Relayer ready | 白名单 + EIP-712 + Type-4 构造 + deployed to Cloudflare | M0 + 3 天 |
| **M3** Frontend ready | join.html 三流程 + ETH 检测 + Revoke 按钮 | M0 + 3 天 |
| **M4** 端到端测试通过 | fork-Sepolia + 真实 MetaMask 手动测三流程 | M0 + 4 天 |
| **M5** Codex review 过 | Critical/High 0，所有 Medium 跟 issue | M0 + 5 天 |
| **M6** 上线 | launch.mushroom.cv 默认走 gasless 路径 | M0 + 5 天 |

---

## 11. Open Issues / 风险

1. ⚠ **Sepolia EIP-7702 支持** — Pectra 升级后 Sepolia 已支持，但要确认 Alchemy RPC 不拒绝 Type-4 tx（之前部署 SaleContract 用 ANNI 是因为 deployer 是 7702 委托过的）
2. ⚠ **AirAccountDelegate 必须 immutable** — 一旦有用户 delegate 了，再升级合约的成本极高
3. ⚠ **Frontend EIP-712 + 7702 双签** — 用户体验上是 "签 2 次"，需要清晰说明
4. ⚠ **MetaMask 是否支持 EIP-7702 Authorization 签名 UI** — Pectra 后 MetaMask 4.x 支持，需测 Sepolia 实际 UX
5. ⚠ **撤销路径滥用** — 用户撤销后可在前端立即重新 delegate（重复签名）—— 这是用户主权范围，relayer 不阻止

---

## 12. 附录：相关文档 / 历史决策

- 同目录 [`RUNBOOK.md`](./RUNBOOK.md) — 上线后 oncall 手册（健康检查 / 库存 / 紧急停售 / 故障排查）✅
- 同目录 [`ACCEPTANCE.md`](./ACCEPTANCE.md) — **验收测试手册**（按步骤手动测三流程 + 反例）✅
- `5-18/07-sale-status-and-todos.md` — 销售路径整体现状（含 USDC 直购）
- `docs/gasless-buy-plan.md` — 早期 gasless 设计稿（被本 spec 取代/继承）

## 13. 实施进度（截至 2026-05-12）

| 组件 | 状态 |
|------|------|
| P1-C1 AirAccountDelegate 合约 + 14/14 单元测试 | ✅ |
| P1-C2 部署 + verified Sepolia | ✅ `0x0BC1A36d...` (redeploy 2026-05-13 — domain pinned to IMPLEMENTATION for MetaMask compat) |
| P1-C3a SaleContractV2 (gToken-bound) 重部署 + 注入 100 GT | ✅ `0x3e4e0A66...` |
| P1-C3b APNTsSaleContract 部署 + 注入 1000 aPNTs | ✅ `0xf1a5FE67...` |
| P2-C4 Relayer 白名单 + 11/11 vitest | ✅ |
| P2-C5 EIP-712 verify + `/v2/relay` + `/v2/revoke` + 15/15 vitest | ✅ |
| P3-C6/7/8 join-gasless.html 三流程 UI + nav 接入 | ✅ |
| P4-C9 fork-Sepolia E2E 集成测试 4/4 | ✅ |
| P5 RUNBOOK + 验收文档 | ✅ |
| **wrangler deploy relayer + RELAYER_URL 替换** | ⏸️ 等 user / 路演后 |
| **launch.mushroom.cv 切到本 branch** | ⏸️ 等 PR merge |
| **Codex security review** | ⏸️ |

**测试总计**：合约 14 + 5 + 4 = 23 个 Foundry test, Relayer 11 + 8 + 7 = 26 vitest. 全部通过。
