# 验收测试手册 — Gasless 购买 v3 (EIP-3009 + BuyHelper)

> **用法**：按这份文档**一步步**手动测试。每一步都有「做什么」「看到什么」「链上验证命令」。
>
> **目标**：在 MetaMask 里、只有 USDC 没有 ETH 的钱包上，**两次签名**完成 gasless 购买 GToken / aPNTs；可选择「代购」给第三方地址。

---

## 0. 准备

### 0.1 钱包 + 网络

- **MetaMask** 任何近期版本（无特殊 EIP-7702 要求）
- 添加 **Sepolia 网络**（chainId 11155111）
- 用一个**空钱包**效果最直观（证明完全 gasless）

### 0.2 关键合约地址（Sepolia · 链上真实部署）

| 名称 | 地址 | 用途 |
|---|---|---|
| **BuyHelper** | `0x578D6f74d8bDA18Cc3b834C1bd74674c529250e7` | gasless 入口 |
| SaleContractV2 (GToken) | `0x3e4e0A663682a2d58d626D0057142328Ef0b626a` | 买 GToken |
| APNTsSaleContract | `0xf1a5FE670dbf6c5219000B30500a98F772EF1F14` | 买 aPNTs |
| GToken | `0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67` | 治理 + 门票 |
| aPNTs | `0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772` | gas 信用 token |
| USDC (Sepolia) | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` | 支付 |

Relayer: `https://mycelium-relayer.jhfnetboy.workers.dev`

### 0.3 拿测试 USDC

去 https://faucet.circle.com/ → Ethereum Sepolia → 输入钱包地址 → 领 10–100 USDC。

**关键**：不要往钱包里发 Sepolia ETH。

### 0.4 打开测试页

https://launch.mushroom.cv/join-gasless

---

## 1. 流程 A — 买 GToken，收件人 = 自己（默认）

### Step 1.1 连接钱包

操作：点 **Connect MetaMask** → MetaMask 弹「请求连接」→ 选你的 Sepolia 钱包 → Connect。

预期看到：
- 顶部徽章变绿「● 已连接」
- 地址 / Sepolia ETH（应为 0）/ USDC 余额显示出来
- 黄色提示「⚠ Sepolia ETH 余额低，建议使用 Gasless 模式」

### Step 1.2 选币 + 输金额

- 标的选 **GToken**（默认）
- 在「支付金额」输入 **15**（即 $15）
- 「预计获得」显示 **100.00 GT**（$0.15 一个）

### Step 1.3 不勾代购，点购买

确认 **代购** 复选框**未勾**（默认）。点 **签 + 提交 Gasless 购买**。

#### 第一次 MetaMask 弹窗 — EIP-3009 USDC TransferWithAuthorization

弹窗 title：**Signature request**（不是 Confirm transaction —— 这一步是签字，不发 tx）。

预期看到：
```
USDC.TransferWithAuthorization {
  from:        <你的地址>
  to:          0x578D6f74...50e7  (BuyHelper)
  value:       15000000  (= 15 USDC，6 decimals)
  validAfter:  0
  validBefore: <timestamp, ~30 min after now>
  nonce:       0x<random 32B>
}
```

操作：点 **Sign**。

日志里看到：`① ✓ EIP-3009 已签`。

#### 第二次 MetaMask 弹窗 — BuyIntent EIP-712

弹窗 title：**Signature request**。

预期看到：
```
MyceliumBuyHelper.BuyIntent {
  buyer:         <你的地址>
  paymentToken:  0x1c7D4B19...7238  (USDC)
  paymentAmount: 15000000
  targetToken:   0x4e6A1125...3B67  (GToken)
  recipient:     <你的地址>  ← 关键：跟 buyer 同
  minOut:        0
  deadline:      <timestamp>
  nonce:         <same 32B as above>
}
```

操作：点 **Sign**。

日志里看到：`② ✓ BuyIntent 已签` → `③ 提交到 relayer...`。

### Step 1.4 等 tx 落链

预期看到日志：
- `✓ tx 已提交: 0x...`
- `匹配规则: TOKEN_BUY → GToken`
- `等待确认 → https://sepolia.etherscan.io/tx/0x...`

### Step 1.5 链上验证

```bash
# 你应该收到 100 GT
cast call 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'balanceOf(address)(uint256)' <你的地址> --rpc-url $RPC
# → 100000000000000000000  (= 100 * 1e18)

# USDC 应该少了 15
cast call 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238 \
  'balanceOf(address)(uint256)' <你的地址> --rpc-url $RPC

# Etherscan: tx 的 from 应该是 operator (0x4Bec0b1c...), 不是你
# 你的 ETH 余额仍然是 0
```

✅ **Step 1 通过**：你没有 ETH，没付 gas，但收到了 GToken。

---

## 2. 流程 B — 买 aPNTs

### Step 2.1

- 标的选 **aPNTs**
- 输入 **10**（$10）
- 预计获得 **500 aPNTs**（$0.02 一个）
- 不勾代购
- 点购买 → 两次 MetaMask 签名（同 1.3）

### Step 2.2 验证

```bash
cast call 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772 \
  'balanceOf(address)(uint256)' <你的地址> --rpc-url $RPC
# → 500000000000000000000  (= 500 * 1e18)
```

✅ **Step 2 通过**：aPNTs 收到。

---

## 3. 流程 C — 代购（A 付 USDC，B 收 GToken）

### Step 3.1 准备

- 你需要**两个** Sepolia 地址（A 是你 connected 的，B 是你想送 GToken 的人）
- B 不需要任何 ETH 或 USDC，可以是全新地址

### Step 3.2 操作

- 标的：**GToken**
- 金额：**15**
- 勾上 **代购：发送给其他地址**
- 在出现的输入框里粘 B 地址
- 点购买

第二次 MM 弹窗里关键字段：
```
recipient: <B 地址>   ← 不是你的地址
```

### Step 3.3 验证

```bash
# B 地址收到 100 GT
cast call 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67 \
  'balanceOf(address)(uint256)' <B 地址> --rpc-url $RPC
# → 100000000000000000000

# 你（A）的 GToken 余额不变（除了之前 Step 1 的 100 GT）
# 你的 USDC 减少 15
```

✅ **Step 3 通过**：代购成功。A 付，B 收。

---

## 4. 反例 — 安全边界

### 4.1 Replay 同一签名（USDC 拒绝）

把 Step 1 的同一组签名重新 POST 给 `/v3/relay`：

```bash
curl -X POST https://mycelium-relayer.jhfnetboy.workers.dev/v3/relay \
  -H 'Content-Type: application/json' \
  -d @<saved-from-step-1.json>
```

预期：tx 提交后**链上**revert（USDC 的 `_authorizationStates` 标记这个 nonce 已用）。relayer 会返回 `SUBMIT_FAILED` 或类似。

### 4.2 篡改收件人（BuyIntent 签名保护）

用 curl 手工构造一个请求，把 `intent.recipient` 改成攻击者地址，但 `buyIntentSig` 还用 Step 1 的（签的是你的地址）：

预期：HTTP 400 + `code: SIGNATURE_INVALID`，`reason` 包含 `signer ≠ buyer`。

### 4.3 非白名单 token

构造 `intent.targetToken = 0xDEAD...DEAD`：

预期：HTTP 403 + `code: NOT_WHITELISTED`。

### 4.4 超过单笔 $864 上限

构造 `intent.paymentAmount = '1000000000'`（$1000）：

预期：HTTP 403 + `code: NOT_WHITELISTED`，`reason` 含 `exceeds per-tx cap`。

---

## 5. 完整验收清单

- [ ] Step 1: 流程 A — gasless 买 GToken，收件 = 自己
- [ ] Step 2: 流程 B — gasless 买 aPNTs
- [ ] Step 3: 流程 C — 代购，A 付 / B 收
- [ ] Step 4.1: replay 被链上拒绝
- [ ] Step 4.2: 篡改 recipient 被 relayer 拒绝（SIGNATURE_INVALID）
- [ ] Step 4.3: 非白名单 token 被拒（NOT_WHITELISTED）
- [ ] Step 4.4: 超额支付被拒（NOT_WHITELISTED + cap）

完成全部 ✅ = 可以路演。
