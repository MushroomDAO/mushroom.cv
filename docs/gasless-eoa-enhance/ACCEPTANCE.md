# 验收测试手册 — Gasless EOA-Enhance (v2 — PAUSED)

> ⚠️ **STATUS: PAUSED (2026-05-13)** — 这份文档对应 EIP-7702 + relayer 路径，被钱包 RPC 标准空白阻塞。生产用 **v3 (EIP-3009 + BuyHelper)** 路径。验收请用 [ACCEPTANCE-v3.md](ACCEPTANCE-v3.md)。
>
> 本文档保留作为 v2 历史参考。

---

> **用法**：按这份文档**一步步**手动测试三条用户流程。每一步都有"做什么"+"看到什么"+"链上验证命令"。
>
> **目标**：在没有 ETH、只有 USDC 的 EOA 上，gasless 买到 GToken / aPNTs；并能撤销 EIP-7702 委托。

---

## 0. 准备 (前置条件)

### 0.1 钱包 + 网络

- 装 **MetaMask**（v11+ 支持 EIP-7702）
- 添加 **Sepolia 网络**（chainId 11155111）
- 新建（或选一个）测试钱包 — 用一个空钱包效果最好

### 0.2 关键合约地址（生产真实链上）

| 名称 | 地址 | 用途 |
|------|------|------|
| AirAccountDelegate | `0x0BC1A36d932e2E9efA33b98043a73b8Be1a6E9Fc` | EIP-7702 委托目标 |
| SaleContractV2 (GToken) | `0x3e4e0A663682a2d58d626D0057142328Ef0b626a` | 买 GToken |
| APNTsSaleContract | `0xf1a5FE670dbf6c5219000B30500a98F772EF1F14` | 买 aPNTs |
| GToken | `0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67` | 治理 + 门票 token |
| aPNTs | `0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772` | gas 信用 token |
| USDC (Sepolia) | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` | 支付 token |

### 0.3 拿测试 USDC

去 https://faucet.circle.com/ → Ethereum Sepolia → 输入你的钱包地址 → 领 10–100 USDC

**关键**：**不要往钱包里发 Sepolia ETH**——这才是"gasless"测试的意义。

### 0.4 打开测试页

打开 https://launch.mushroom.cv/join-gasless.html （或 Cloudflare preview URL）

> ⚠️ **预发布状态**：如果生产还没切到最新版本，先用 PR preview URL。问 Jason 拿。

---

## 1. 流程 A — Gasless 买 GToken（核心路径）

### Step 1.1 — 连接钱包

**操作**：点击页面中的 **Connect MetaMask** 按钮。

**预期看到**：
- MetaMask 弹窗 → 选择账户 → 确认连接
- 页面右上角 badge 从"● 未连接"变绿色"● Sepolia"
- 4 类余额刷新出来：ETH (≈ 0) / USDC (> 0) / GT (0) / aPNTs (0)
- 因 ETH 余额低，**黄色警告横幅出现**："你的 Sepolia ETH 余额低，建议使用 Gasless 模式"

**链上验证**（可选）：
```bash
RPC=$SEPOLIA_RPC_URL  # 替换为你的 Sepolia RPC URL（如 Alchemy/Infura/公共节点）
YOUR=<your-wallet-address>
cast balance $YOUR --rpc-url $RPC   # 应该 = 0 或很小
cast call 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238 'balanceOf(address)(uint256)' $YOUR --rpc-url $RPC
# 应该 ≥ 15000000 (即 ≥ $15)
```

### Step 1.2 — 选择 token + 输入金额

**操作**：
- 确认"② 选择标的"区段中 **GToken** 是高亮（黄色边框）
- 在"③ Gasless 购买"输入框填入 **15**（或点 $15 快捷按钮）

**预期看到**：
- "预计获得"显示 `100.0000 GT`（@ $0.15 起步价）
- "签 + 提交 Gasless 购买" 按钮变可点击

### Step 1.3 — 签 EIP-712 PurchaseIntent

**操作**：点击 **签 + 提交 Gasless 购买**。

**预期看到**（MetaMask 弹窗 1/2）：
```
Signature request

Domain
  name: AirAccountDelegate
  version: 1
  chainId: 11155111
  verifyingContract: <your-EOA-address>

Message
  calls: [
    { target: 0x1c7D4B19...USDC, value: 0, data: 0x095ea7b3... },  ← approve USDC
    { target: 0x3e4e0A66...SaleV2, value: 0, data: 0x71777f76... } ← buyTokens
  ]
  nonce: 0
  deadline: 1715XXXXX
```

**操作**：点击 **Sign**。

**预期看到**：页面日志显示 `✓ EIP-712 已签`。

### Step 1.4 — 签 EIP-7702 Authorization

**预期看到**（MetaMask 弹窗 2/2）：MetaMask 显示 EIP-7702 authorization signing UI（具体样式取决于 MetaMask 版本，Pectra 后通常是橙色高亮）：

```
Authorize delegation
  Contract: 0x0BC1A36d...DELEGATE
  Chain: Sepolia (11155111)
  Nonce: <your-tx-nonce>
```

**操作**：点 **Sign**。

**预期看到**：页面日志显示 `✓ EIP-7702 Authorization 已签`，然后 `③ 提交到 relayer...`。

### Step 1.5 — Relayer 提交

**预期看到**（成功）：
```
[HH:MM:SS] ✓ tx 已提交: 0xabc123...
[HH:MM:SS] 匹配规则: TOKEN_BUY → 0x3e4e0A66...3 (buyTokens(uint256,address,uint256))
[HH:MM:SS] 等待确认 → https://sepolia.etherscan.io/tx/0xabc123...
```

**操作**：点击 Etherscan 链接看 tx 详情。

**预期看到**（Etherscan）：
- Status: Success
- Transaction Type: **EIP-7702** (Type 4)
- AuthorizationList: 1 entry → AirAccountDelegate
- Internal Txns: 2 calls inside executeBatch
  - USDC.approve
  - SaleV2.buyTokens
- ERC20 Transfers:
  - USDC: from you → SaleV2: 15.00 USDC（实际是先 approve 后 transferFrom）
  - GToken: from SaleV2 → you: 100 GT

### Step 1.6 — 余额刷新

**预期看到**（约 15 秒后自动刷新）：
- USDC 余额减少 15
- GT 余额从 0 → 100.0000

**手动验证**：
```bash
cast call 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 'balanceOf(address)(uint256)' $YOUR --rpc-url $RPC
# 应该 = 100000000000000000000 (100 * 1e18)
```

### Step 1.7 — 在 MetaMask 中导入 GToken（可选）

**操作**：
- 切到 MetaMask → Tokens → Import
- 粘贴 `0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67`
- 应看到 100 GT 余额

**或**：在页面中点击 GToken 旁边的 📋 复制按钮，去 MetaMask 粘贴。

✅ **Step 1 验收通过**：你刚刚在没有 ETH 的钱包里完成了 GToken 购买。

---

## 2. 流程 B — Gasless 买 aPNTs

### Step 2.1 — 切到 aPNTs

**操作**：在"② 选择标的"区段点击 **aPNTs** 按钮。

**预期看到**：
- aPNTs 按钮变高亮（黄色边框）
- "销售合约"地址 link 变成 `0xf1a5FE67...F14`
- "Token 合约"地址 link 变成 `0x4C4EC2e8...772`

### Step 2.2 — 输入金额 + 签名 + 提交

**操作**：
- 输入金额 `10`（→ 预计获得 `500.00 aPNTs` @ $0.02）
- 点击 **签 + 提交 Gasless 购买**
- 同 Step 1.3 + 1.4：MetaMask 弹两次签名（PurchaseIntent + Authorization）
- 提交后等链上确认

**预期看到**：
- 日志显示 `✓ tx 已提交`，`匹配规则: TOKEN_BUY → 0xf1a5FE67... (buyAPNTs(uint256,address))`
- 余额刷新：USDC 减 10，**aPNTs 增加 500**

**手动验证**：
```bash
cast call 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772 'balanceOf(address)(uint256)' $YOUR --rpc-url $RPC
# 应该 = 500000000000000000000 (500 * 1e18)
```

✅ **Step 2 验收通过**

---

## 3. 流程 C — 解除委托（用户主权）

### Step 3.1 — 撤销前的状态确认

**链上验证**：你的 EOA 应该有 **code = AirAccountDelegate** 形态（EIP-7702 委托态）：
```bash
cast code $YOUR --rpc-url $RPC
# 应该返回 0xef010041fde128d7a7196b968875ca1491816d360d38b7 (= EIP-7702 prefix + delegate addr)
```

### Step 3.2 — 点击撤销

**操作**：滚到页面的"④ 解除委托"区段，点击 **签 + 提交解除委托** 红色按钮。

**预期看到**（MetaMask 弹窗）：EIP-7702 Authorization signing：
```
Authorize delegation
  Contract: 0x0000000000000000000000000000000000000000   ← 关键：零地址表示清除
  Chain: Sepolia
  Nonce: <next>
```

**操作**：点 **Sign**。

**预期看到**：
- 日志 `提交到 relayer /v2/revoke...`
- 然后 `✓ 委托已撤销: 0xdef456...`

### Step 3.3 — 撤销后的状态确认

**链上验证**：
```bash
cast code $YOUR --rpc-url $RPC
# 应该返回 0x （空）— 普通 EOA 恢复
```

也可以在 Etherscan 上看 tx：Authorization 那栏的 contract 是 `0x0000...0000`。

✅ **Step 3 验收通过**：你刚刚展示了用户主权——委托是可随时撤销的，relayer 阻止不了。

---

## 4. 反例测试 — 白名单边界

### 4.1 试试绕过：买非白名单 token

**操作**（这一步可以跳过；目的是验证安全）：
- 改 `RELAYER_URL` 指向 Postman / curl
- 构造一个 calls 里包含**任意第三方 ERC20 transfer**的 batch
- POST 到 `/v2/relay`

**预期看到**：HTTP 403
```json
{ "error": "Payment token 0xXXX not in whitelist", "code": "INTENT_PARSE_FAILED" }
```

即：relayer **不为任意操作付 gas**，只赞助白名单内的 3 种操作。

### 4.2 试试改 SaleContract

POST 到 `/v2/relay` 时把 calls 里的 sale target 改成一个**其他合约**：

**预期看到**：HTTP 403
```json
{ "error": "approve spender 0xXXX ≠ buy target 0xYYY", "code": "INTENT_PARSE_FAILED" }
```

✅ **白名单严格**

---

## 5. 总验收 ✅ Checklist

- [ ] 1. 钱包连接 + Sepolia + ETH 余额检测显示警告
- [ ] 2. **流程 A**：无 ETH 钱包用 $15 USDC 买到 **100 GT**（链上 Etherscan 可见）
- [ ] 3. **流程 B**：无 ETH 钱包用 $10 USDC 买到 **500 aPNTs**
- [ ] 4. **流程 C**：签 + 提交后，EOA 的 code 从 `0xef0100...` 回到 `0x`（空）
- [ ] 5. 余额自动刷新正常
- [ ] 6. 复制合约地址按钮工作
- [ ] 7. 反例：构造非白名单操作被 relayer 拒（403）

全勾上 → ✅ 验收通过，gasless 流程可上生产。

---

## 5.5 运维补充：如何**增加库存**

### 背景

当前 SaleV2 + APNTsSale 的初始库存（100 GT + 1000 aPNTs）是我用 **deployer 私钥**（`0xb5600060`，gToken/aPNTs 的 owner）从它的余额直接 transfer 到 sale 合约的。这是一次性的"启动"操作。

**未来要增加库存**有两条路径——你拍板用哪条：

| 路径 | 操作者 | 适合场景 |
|---|---|---|
| **A. Deployer 直接 transfer**（简单）| Jason / Anni 用 deployer 私钥 | 测试网快速补货 |
| **B. Treasury Safe 多签 transfer**（推荐）| Safe 多签人按门槛签 | **主网 + 路演后期资金透明操作** |

---

### 路径 A — Deployer 直接 transfer（当前用的方式）

**适用**：Sepolia 测试网，少量补货（如再加 200 GT）。

```bash
# 1. 加载 deployer 私钥（仅本地内存，不打印）
DEPLOYER_PK=$(grep '^DEPLOYER_PRIVATE_KEY=' /Users/jason/Dev/aastar/SuperPaymaster/.env.sepolia | cut -d'"' -f2)
RPC=$SEPOLIA_RPC_URL2   # from launch/.env.sepolia

# 2. 看 deployer 还剩多少
cast call 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'balanceOf(address)(uint256)' 0xb5600060e6de5E11D3636731964218E53caadf0E \
  --rpc-url $RPC
# 预期：约 1773e18 GT 剩余（deployer 持有 ~1873 - 100 已转）

cast call 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772 \
  'balanceOf(address)(uint256)' 0xb5600060e6de5E11D3636731964218E53caadf0E \
  --rpc-url $RPC
# 预期：约 16493e18 aPNTs 剩余

# 3. 补 200 GT 给 SaleV2
cast send 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'transfer(address,uint256)' \
  0x3e4e0A663682a2d58d626D0057142328Ef0b626a \
  200000000000000000000 \
  --private-key $DEPLOYER_PK --rpc-url $RPC

# 4. 补 5000 aPNTs 给 APNTsSale
cast send 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772 \
  'transfer(address,uint256)' \
  0xf1a5FE670dbf6c5219000B30500a98F772EF1F14 \
  5000000000000000000000 \
  --private-key $DEPLOYER_PK --rpc-url $RPC

# 5. 验证
cast call 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'balanceOf(address)(uint256)' 0x3e4e0A663682a2d58d626D0057142328Ef0b626a \
  --rpc-url $RPC
# 预期：300e18（原 100 + 新 200）
```

**优点**：单签，一行 cast 命令，秒级。
**缺点**：deployer 私钥控制所有库存——单点故障。

---

### 路径 B — Treasury Safe 多签 transfer（生产推荐）

**适用**：主网，或路演后想强化"资金 100% 走 Safe 多签"叙事时。

**前置一次性步骤（Bootstrap）**：把 deployer 手里的 token 挪到 Safe。

```bash
# Bootstrap-1: deployer 把所有剩余 GT 转给 Treasury Safe
DEPLOYER_PK=$(grep '^DEPLOYER_PRIVATE_KEY=' /Users/jason/Dev/aastar/SuperPaymaster/.env.sepolia | cut -d'"' -f2)
TREASURY=0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114
RPC=$SEPOLIA_RPC_URL2

# 先看 deployer 还有多少
DEPLOYER_GT=$(cast call 0x4e6A1125... 'balanceOf(address)(uint256)' \
  0xb5600060e6de5E11D3636731964218E53caadf0E --rpc-url $RPC)

# 全部转给 Safe
cast send 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'transfer(address,uint256)' $TREASURY $DEPLOYER_GT \
  --private-key $DEPLOYER_PK --rpc-url $RPC

# 同样把 deployer 的 aPNTs 全部转给 Safe
DEPLOYER_AP=$(cast call 0x4C4EC2e8... 'balanceOf(address)(uint256)' \
  0xb5600060e6de5E11D3636731964218E53caadf0E --rpc-url $RPC)

cast send 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772 \
  'transfer(address,uint256)' $TREASURY $DEPLOYER_AP \
  --private-key $DEPLOYER_PK --rpc-url $RPC
```

**Bootstrap 完成后**：未来所有补货都从 Safe 多签发起。

**日常补货流程**（Sepolia 上同样适用，Safe 链支持完全相同）：

1. 打开 Sepolia Safe UI：
   🔗 https://app.safe.global/home?safe=sep:0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114

2. 点 **New transaction → Transaction Builder**（不是 Send tokens！因为 Safe UI 默认不识别 MockGToken / 新 gToken 这种 token，需要走自定义合约调用）

3. 填：
   - **Enter Address or ENS**: `0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67`（要补 GToken）或 `0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772`（要补 aPNTs）
   - **Enter ABI**（清空后粘下面这段）：

     ```json
     [{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"}]
     ```

   - **Method**: 选 `transfer`
   - **to (address)**:
     - 补 GToken → `0x3e4e0A663682a2d58d626D0057142328Ef0b626a`（SaleV2）
     - 补 aPNTs  → `0xf1a5FE670dbf6c5219000B30500a98F772EF1F14`（APNTsSale）
   - **amount (uint256)**: 数值 × 10^18（例：补 200 个 token 写 `200000000000000000000`）
   - **ETH value**: `0`

4. **Add transaction → Create batch → Sign** → 等其他签名人达到多签门槛 → **Execute**

5. 验证库存：
```bash
cast call 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'balanceOf(address)(uint256)' 0x3e4e0A663682a2d58d626D0057142328Ef0b626a \
  --rpc-url $RPC
```

**优点**：多签透明、链上 trail 清晰、单签人丢私钥不影响、和 PR #6 路演叙事一致（"所有资金 Gnosis Safe 多签"）。
**缺点**：每次都要至少 2 个 owner 签（看你的 Safe 门槛配置），约 5–10 分钟。

---

### 决策建议（我的看法）

| 阶段 | 推荐路径 |
|---|---|
| **现在（路演前测试）** | 路径 A 直接 transfer，秒级补货，节省协作成本 |
| **路演后（5月底前）** | 跑一次 Bootstrap 把 deployer 余额全部转 Safe |
| **主网上线时** | 强制路径 B，deployer 私钥永远不持库存 |

要不要现在就跑 Bootstrap？跑完后这个文档里的"如何补货"操作步骤换成路径 B（更干净的故事），你说一声我立即操作。

---

## 6. 已知限制 + 后续

| 项 | 状态 |
|---|---|
| RELAYER_URL 占位 `mycelium-relayer.workers.dev` | ⏳ 等 wrangler deploy（P5 RUNBOOK §9 流程）|
| SuperPaymaster 集成 | ⏳ 后续——当前 relayer hot wallet 直接付 gas |
| `MILESTONE_CAPS` 前端硬编码 6 条 | David PR #6 留的 LOW，路演前不影响 |
| 多支付 token（USDT 等） | 主网时加 |
| join.html 与 join-gasless.html 融合 | UX 演进任务，不阻塞 |

---

## 7. 报障

遇到任何报错：
- 截图 MetaMask 弹窗
- 截图页面日志
- 截图 Etherscan tx 详情（如果有 tx hash）
- 联系 Jason 或在 GitHub issue 提交
