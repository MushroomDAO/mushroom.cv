# RUNBOOK — Gasless EOA-Enhance

> 上线后的 oncall 手册 + 故障排查。

## 1. 关键地址（Sepolia）

| 合约 | 地址 | 验证 |
|---|---|---|
| AirAccountDelegate | `0x0BC1A36d932e2E9efA33b98043a73b8Be1a6E9Fc` | ✅ Etherscan |
| SaleContractV2 (gToken-bound) | `0x3e4e0A663682a2d58d626D0057142328Ef0b626a` | ✅ |
| APNTsSaleContract | `0xf1a5FE670dbf6c5219000B30500a98F772EF1F14` | ✅ |
| gToken (verified) | `0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67` | ✅ |
| aPNTs | `0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772` | ✅ |
| USDC (Circle Sepolia) | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` | — |
| Treasury Safe (sep:0x51eDf...) | `0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114` | Safe Wallet |

## 2. 服务

| 服务 | URL / 位置 | Owner |
|---|---|---|
| Frontend | https://launch.mushroom.cv/join-gasless.html | Cloudflare Pages |
| Relayer | https://mycelium-relayer.workers.dev/v2/* | Cloudflare Workers |
| RPC (Sepolia) | Alchemy x3 keys (see `.env.sepolia`) | — |

## 3. 健康检查

```bash
# 1. Relayer health
curl https://mycelium-relayer.workers.dev/health
# Expected: {"status":"ok","chain":"11155111"}

# 2. AirAccountDelegate alive
cast call 0x0BC1A36d932e2E9efA33b98043a73b8Be1a6E9Fc 'NAME()(string)' \
  --rpc-url $SEPOLIA_RPC_URL2
# Expected: "AirAccountDelegate"

# 3. SaleV2 + APNTsSale state
cast call 0x3e4e0A663682a2d58d626D0057142328Ef0b626a 'availableInventory()(uint256)' \
  --rpc-url $SEPOLIA_RPC_URL2
cast call 0xf1a5FE670dbf6c5219000B30500a98F772EF1F14 'availableInventory()(uint256)' \
  --rpc-url $SEPOLIA_RPC_URL2
# Expected: > 0 (库存)
```

## 4. 库存运维

### 4.1 检查库存

```bash
cast call $GTOKEN 'balanceOf(address)(uint256)' $SALE_V2 --rpc-url $RPC
cast call $APNTS  'balanceOf(address)(uint256)' $APNTS_SALE --rpc-url $RPC
```

### 4.2 补充库存

**完整步骤（含路径 A / B 对比 + Safe Transaction Builder 操作）** 见
[`ACCEPTANCE.md §5.5 — 运维补充：如何增加库存`](./ACCEPTANCE.md#55-运维补充如何增加库存)。

简要回顾：
- **路径 A**（当前用，测试网）：deployer 单签 cast send
- **路径 B**（推荐，主网必须）：Treasury Safe 多签 Transaction Builder
- **Bootstrap**（路径 A → B 的迁移）：deployer 一次性把所有库存转到 Safe，之后只走 Safe

```bash
# 路径 A 速查：deployer 直接转 X 个 token 给 sale
cast send $TOKEN 'transfer(address,uint256)' $SALE $AMOUNT_18DEC \
  --private-key $DEPLOYER_PK --rpc-url $RPC
```

## 5. 关掉销售（紧急）

```bash
# 暂停 SaleV2
cast send $SALE_V2 'pause()' --private-key $PRIVATE_KEY_ANNI --rpc-url $RPC

# APNTsSale 没有 pause — 可用 setPaymentToken(USDC, false) 间接暂停
cast send $APNTS_SALE 'setPaymentToken(address,bool)' $USDC false \
  --private-key $PRIVATE_KEY_ANNI --rpc-url $RPC
```

## 6. 撤销 Relayer Operator（最坏情况：私钥泄露）

```bash
# 1. 立刻在 Cloudflare wrangler 把 OPERATOR_PK secret 换新
wrangler secret put OPERATOR_PK --name mycelium-relayer

# 2. 旧 EOA 的剩余 ETH 提走
cast send <new-safe> --value <balance> --private-key $OLD_OPERATOR_PK --rpc-url $RPC

# 3. Relayer 自动重启使用新 PK（Cloudflare Workers 是 stateless）
```

## 7. 故障排查

### 7.1 用户报告 "Relayer 拒绝: NOT_WHITELISTED"

可能原因：
- 用户改了 sale target / 用了 non-USDC payment token / 调了非 buy 的 selector
- 白名单规则被禁用

排查：
```bash
# 看 Cloudflare Workers logs
wrangler tail mycelium-relayer
# 找到 reason 字段
```

修复：要么用户改输入，要么需要新加规则（→ 新 PR → review → 部署）。

### 7.2 用户报告 "SIGNATURE_INVALID"

最常见原因：
- 用户切链了（domain.chainId 不对）
- nonce 与链上不一致（用户连续两次签但只交了一次）
- MetaMask 签名实现 bug（罕见）

修复：让用户**断开 + 重连钱包 + 重新签**。

### 7.3 用户报告 "Type-4 tx 失败"

链上 revert，看 Etherscan tx 的 Errored 信息：
- `ExpiredDeadline` → 用户签后等太久（>30min），重签
- `InvalidSigner` → domain 不对，可能用户切了网络
- 内部 call 失败（如 USDC 不够、Sale 暂停、库存不够）→ 看 logs 第几个 call 失败

### 7.4 Relayer hot wallet 没 ETH 了

```bash
# 检查
cast balance <relayer-operator-addr> --rpc-url $RPC

# 从 Treasury Safe 转 1 ETH 给 operator
# Safe UI: https://app.safe.global/home?safe=sep:0x51eDf...
```

## 8. 监控指标

建议（未实现）：
- relayer `/v2/relay` qps + p99 latency
- 拒绝率（按 code 分组）
- 当日已赞助 gas 总量（ETH）
- per-user 余额（防滥用）

短期用 `wrangler tail` 人工看。

## 9. 升级流程

1. 新功能/修复 → PR → 至少 1 个非作者 approve
2. Merge 进 main → Cloudflare 自动重部署 site + relayer
3. 合约升级（如新规则）需要：
   - whitelist.ts 改动 → relayer PR → merge → relayer 自动重部
   - SaleV2 / APNTsSale 是 immutable，要扩展功能需要 V3 部署 + 站点切换

## 10. 联系人

- Lead: Jason Jiao (`firsttorch66@gmail.com`)
- Reviewer: David Xu (`fanhousanbu@gmail.com`)
- Slack: `#mycelium-launch`（待建）
