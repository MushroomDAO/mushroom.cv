# 主网上线手册 — Mycelium Protocol Launch

> **状态**：待执行（当前仍在 Sepolia 测试网）
>
> **目标**：将所有合约部署到 Ethereum 主网，切换 Cloudflare Worker 到主网 Relayer，更新前端 CONFIG，完成端到端验收。
>
> **前提**：Sepolia 验收测试（ACCEPTANCE-v3.md）全部通过 ✅。

---

## 0. 准备清单（上线前确认）

| 项目 | 说明 | 负责人 |
|------|------|--------|
| Treasury Safe 主网地址 | app.safe.global 上已建立主网 Safe | Jason |
| 主网 RPC | Alchemy / Infura 主网 API key 已申请 | Jason |
| Operator EOA | 新建专用 EOA，与开发钱包隔离，持有 ≥ 0.5 ETH（用于 relay gas）| Jason |
| GToken 主网合约 | 已部署并验证 | ANNI |
| aPNTs 主网合约 | 已部署并验证 | ANNI |
| 主网 USDC | Circle 官方：`0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48`（无需部署）| — |
| 主网 USDT | Tether 官方：`0xdAC17F958D2ee523a2206206994597C13D831ec7`（无需部署）| — |
| 审计 / 安全检查 | BuyHelper + SaleContractV2 已完成内部审计 | Jason + Codex |

---

## 1. 主网合约地址（部署后填写）

| 合约 | Sepolia（参考）| 主网（待填）|
|------|---------------|------------|
| GToken | `0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67` | `0x__待填__` |
| aPNTs | `0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772` | `0x__待填__` |
| SaleContractV2 (GToken) | `0x3e4e0A663682a2d58d626D0057142328Ef0b626a` | `0x__待填__` |
| APNTsSaleContract | `0xf1a5FE670dbf6c5219000B30500a98F772EF1F14` | `0x__待填__` |
| BuyHelper | `0x578D6f74d8bDA18Cc3b834C1bd74674c529250e7` | `0x__待填__` |
| Treasury Safe | `0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114`（sep）| `0x__待填__` |
| USDC | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238`（sep）| `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48` |
| USDT | `0xaA8E23Fb1079EA71994CB4e1Db6e2c539AB8D0…`（sep Aave）| `0xdAC17F958D2ee523a2206206994597C13D831ec7` |

---

## 2. 合约部署步骤

### 2.1 部署 SaleContractV2（GToken 销售）

```bash
cd contracts
export RPC_URL=https://eth-mainnet.g.alchemy.com/v2/<YOUR_KEY>
export DEPLOYER_PK=<deployer_private_key>
export GTOKEN_MAINNET=0x__待填__
export TREASURY_MAINNET=0x__待填__

forge script script/DeploySaleContractV2.s.sol \
  --rpc-url $RPC_URL \
  --private-key $DEPLOYER_PK \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

部署后记录地址，填入上方表格。

### 2.2 部署 APNTsSaleContract

```bash
export APNTS_MAINNET=0x__待填__

forge script script/DeployAPNTsSaleContract.s.sol \
  --rpc-url $RPC_URL \
  --private-key $DEPLOYER_PK \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

### 2.3 部署 BuyHelper

BuyHelper 需要传入上面所有已部署的主网地址：

```bash
# 编辑 script/DeployBuyHelper.s.sol，将地址全部替换为主网地址
# USDC   = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
# GTOKEN = <主网 GToken>
# APNTS  = <主网 aPNTs>
# SALE_GT= <主网 SaleContractV2>
# SALE_AP= <主网 APNTsSaleContract>

forge script script/DeployBuyHelper.s.sol \
  --rpc-url $RPC_URL \
  --private-key $DEPLOYER_PK \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

### 2.4 上架 USDC / USDT 支付方式

```bash
SALE_GT_MAINNET=0x__待填__
SALE_AP_MAINNET=0x__待填__
USDC_MAINNET=0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
USDT_MAINNET=0xdAC17F958D2ee523a2206206994597C13D831ec7

# SaleContractV2
cast send $SALE_GT_MAINNET 'setPaymentToken(address,bool)' $USDC_MAINNET true \
  --private-key $DEPLOYER_PK --rpc-url $RPC_URL
cast send $SALE_GT_MAINNET 'setPaymentToken(address,bool)' $USDT_MAINNET true \
  --private-key $DEPLOYER_PK --rpc-url $RPC_URL

# APNTsSaleContract
cast send $SALE_AP_MAINNET 'setPaymentToken(address,bool)' $USDC_MAINNET true \
  --private-key $DEPLOYER_PK --rpc-url $RPC_URL
cast send $SALE_AP_MAINNET 'setPaymentToken(address,bool)' $USDT_MAINNET true \
  --private-key $DEPLOYER_PK --rpc-url $RPC_URL
```

### 2.5 注入初始库存

**主网必须走 Treasury Safe 多签**（不要用 deployer 直接转）：

1. 打开 https://app.safe.global → 选主网 Safe
2. Transaction Builder → 输入 GToken 地址
3. ABI 选 `transfer(address,uint256)`
   - to: `<主网 SaleContractV2>`
   - amount: 按路演规划（如 10,000 GT = `10000000000000000000000`）
4. 同理给 APNTsSaleContract 注入 aPNTs 库存
5. 收集多签确认 → Execute

---

## 3. Cloudflare Worker 双环境配置

### 3.1 wrangler.toml 添加主网环境

编辑 `services/relayer/wrangler.toml`：

```toml
name = "mycelium-relayer"

# ── 默认（Sepolia 测试网）─────────────────────
[vars]
CHAIN_ID = "11155111"
BUY_HELPER = "0x578D6f74d8bDA18Cc3b834C1bd74674c529250e7"
# OPERATOR_PK + RPC_URL 通过 wrangler secret put 管理（不写在此文件）

# ── 主网（production）────────────────────────
[env.mainnet]
name = "mycelium-relayer-mainnet"

[env.mainnet.vars]
CHAIN_ID = "1"
BUY_HELPER = "0x__待填主网BuyHelper地址__"
# OPERATOR_PK + RPC_URL 用单独 secret，见 3.2
```

### 3.2 设置主网 Secrets

**仅执行一次**，用于向 Cloudflare 注入主网私钥和 RPC（不会出现在代码里）：

```bash
cd services/relayer

# 主网 Operator 私钥（建议生成专用 EOA，不要复用 deployer）
wrangler secret put OPERATOR_PK --env mainnet
# 提示输入，粘贴主网 operator private key，回车

# 主网 RPC URL（Alchemy / Infura）
wrangler secret put RPC_URL --env mainnet
# 提示输入，粘贴 https://eth-mainnet.g.alchemy.com/v2/<KEY>
```

Cloudflare Dashboard → Workers → `mycelium-relayer-mainnet` → Settings → Variables 可验证已注入。

### 3.3 部署主网 Worker

```bash
cd services/relayer

# 仅部署主网环境，不影响测试网 Worker
wrangler deploy --env mainnet
```

部署成功后 Worker URL 格式为：
`https://mycelium-relayer-mainnet.<your-subdomain>.workers.dev`

可在 Cloudflare Dashboard 给它绑定自定义域名，如 `relayer.mushroom.cv`。

---

## 4. 前端 join.html 切换到主网

编辑 `site/join.html` 顶部 `CONFIG` 块，替换所有地址和 CHAIN_ID：

```js
const CONFIG = {
  CHAIN_ID: 1,                          // 主网

  // 稳定币（Circle / Tether 官方，无需部署）
  USDC: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
  USDT: '0xdAC17F958D2ee523a2206206994597C13D831ec7',

  // 主网 Token 合约
  GTOKEN: '0x__待填__',
  APNTS:  '0x__待填__',

  // 主网 Sale 合约
  SALE_GT: '0x__待填__',
  SALE_AP: '0x__待填__',

  // 主网 BuyHelper
  BUY_HELPER: '0x__待填__',

  // 主网 Relayer
  RELAYER: 'https://mycelium-relayer-mainnet.<subdomain>.workers.dev/v3/relay',
  // 或绑定了自定义域名后：
  // RELAYER: 'https://relayer.mushroom.cv/v3/relay',
}
```

改完后：
```bash
git add site/join.html
git commit -m "feat(join): switch CONFIG to mainnet addresses"
git push
# Cloudflare Pages 自动发布
```

---

## 5. Operator 账户要求

| 项目 | 说明 |
|------|------|
| 账户类型 | 专用 EOA，不要用 deployer / 个人主钱包 |
| 初始 ETH 余额 | ≥ 0.5 ETH（按 ~50,000 gas/tx @ 30 gwei，可 relay ~300 笔）|
| 补充方式 | 从 Treasury Safe 定期划拨，建议 ≤ 1 ETH 常驻（降低泄露风险）|
| 监控 | 定期检查余额；< 0.1 ETH 时补充 |
| 泄露应急 | 见第 6 节 |

---

## 6. 操作顺序（执行序列）

```
Step 1  部署 GToken + aPNTs（若已有主网合约则跳过）
Step 2  部署 SaleContractV2（传入主网 GToken + Treasury Safe）
Step 3  部署 APNTsSaleContract（传入主网 aPNTs + Treasury Safe）
Step 4  部署 BuyHelper（传入主网 USDC/GToken/aPNTs/Sale×2）
Step 5  setPaymentToken(USDC, true) × 2  +  setPaymentToken(USDT, true) × 2
Step 6  Treasury Safe 注入初始库存
Step 7  wrangler.toml 添加 [env.mainnet]
Step 8  wrangler secret put OPERATOR_PK / RPC_URL --env mainnet
Step 9  wrangler deploy --env mainnet
Step 10 验收：curl 主网 relayer /health → CHAIN_ID=1
Step 11 更新 site/join.html CONFIG → 主网地址 + 主网 relayer URL
Step 12 git push → Cloudflare Pages 自动发布
Step 13 端到端主网验收（见第 7 节）
```

---

## 7. 主网验收

### 7.1 Relayer 健康检查

```bash
curl https://mycelium-relayer-mainnet.<subdomain>.workers.dev/health
# 预期: {"status":"ok","chain":"1"}
```

### 7.2 合约状态

```bash
export RPC=https://eth-mainnet.g.alchemy.com/v2/<KEY>
export SALE_GT=<主网 SaleContractV2>
export SALE_AP=<主网 APNTsSaleContract>
export GTOKEN=<主网 GToken>
export APNTS=<主网 aPNTs>
export BUY_HELPER=<主网 BuyHelper>

# 库存检查
cast call $GTOKEN 'balanceOf(address)(uint256)' $SALE_GT --rpc-url $RPC
cast call $APNTS  'balanceOf(address)(uint256)' $SALE_AP --rpc-url $RPC

# USDC 已被接受
cast call $SALE_GT 'acceptedPaymentTokens(address)(bool)' \
  0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48 --rpc-url $RPC
# 预期: true
```

### 7.3 小额端到端购买（主网验收）

> ⚠️ 主网用真实 USDC。建议只用 **1 USDC** 做最小验收，不要用 15 USDC。

流程同 ACCEPTANCE-v3.md §1，但：
- 网络切换为 **Ethereum Mainnet**（chainId 1）
- 从 Circle 主网领 / 转入真实 USDC（无 faucet，需自备）
- 验证 tx.from = Operator EOA（不是你的钱包），你的 ETH 余额不变

### 7.4 验收通过标准

- [ ] Relayer `/health` 返回 `"chain":"1"`
- [ ] 小额购买 GToken 成功，on-chain tx.from = Operator
- [ ] 小额购买 aPNTs 成功
- [ ] 代购流程（A 付 / B 收）成功
- [ ] Operator ETH 余额在预期范围内
- [ ] 前端 join.html 在主网 MetaMask 下正确显示余额 + 价格

---

## 8. 测试网与主网并行运行（双轨期）

上线主网后，建议保留 Sepolia 测试网一段时间：

| 环境 | Worker | 前端 URL | 用途 |
|------|--------|----------|------|
| Sepolia 测试网 | `mycelium-relayer`（默认）| `launch.mushroom.cv/join.html` + `?net=test`（待实现）| 新功能测试 |
| Ethereum 主网 | `mycelium-relayer-mainnet` | `launch.mushroom.cv/join.html`（默认）| 路演 / 正式用户 |

双轨期结束后，可删除 `wrangler.toml` 的测试网默认配置，或保留仅供开发。

---

## 9. 应急操作

### 9.1 紧急暂停销售

```bash
# 暂停 SaleContractV2（owner 操作）
cast send $SALE_GT 'pause()' --private-key $OWNER_PK --rpc-url $RPC

# APNTsSaleContract 无 pause() → 用 setPaymentToken 间接暂停
cast send $SALE_AP 'setPaymentToken(address,bool)' \
  0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48 false \
  --private-key $OWNER_PK --rpc-url $RPC
```

### 9.2 Operator 私钥泄露

```bash
# 1. 立刻换 Cloudflare 主网 Operator PK
wrangler secret put OPERATOR_PK --env mainnet
# 粘贴新 private key

# 2. 旧 Operator 地址的 ETH 全部转走
cast send <treasury-safe> --value $(cast balance <old-op> --rpc-url $RPC) \
  --private-key $OLD_OPERATOR_PK --rpc-url $RPC

# 3. Worker 自动重启使用新 PK（无需手动）
# 4. 验证：curl /health 仍返回 ok
```

### 9.3 Relayer Worker 回滚

```bash
# 查看历史版本
wrangler deployments list --env mainnet

# 回滚到上一个版本
wrangler rollback --env mainnet
```

---

## 10. 联系人

- Lead: Jason Jiao (`firsttorch66@gmail.com`)
- Contract Owner: ANNI
- Slack: `#mycelium-launch`（待建）
- Treasury Safe: 见第 1 节地址表
