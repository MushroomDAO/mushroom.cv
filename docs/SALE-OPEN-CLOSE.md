# 销售开放 / 关闭（Sale Open/Close）

GToken 销售合约（`SaleContractV2`）继承了 OpenZeppelin `Pausable`，owner 可以随时**手动开放或关闭**销售。这是一个**控制扩散速度**的手段——不是为了完全阻止 sybil（一人多钱包链上链下都防不住），而是限制传播节奏：

> 给特定人群建一个微信/Telegram 群 → `open` → 群里的人来抢 → 售罄或你手动 `close`。
> 消息还没扩散出去，额度已经被目标人群买走。短时间内一个人来不及注册很多账号，最多几个，可接受。

这与链下 relayer 的 per-buyer 限额（每笔 $864 + 每个真实 buyer 每小时 5 次）+ 链上 `perPersonCapUSD`（按钱包）配合，构成一套“聊胜于无但够用”的分发控制。

## 脚本

`scripts/sale-toggle.sh` —— 一条命令开/关/查。

```bash
# 查当前状态（只读，免私钥）：开/关? 库存? 价格?
scripts/sale-toggle.sh status

# 开放销售（unpause）— 需要 owner 私钥
scripts/sale-toggle.sh open

# 关闭销售（pause）— 需要 owner 私钥
scripts/sale-toggle.sh close

# 指定别的 sale 合约
scripts/sale-toggle.sh status --sale 0xYourSale
```

**前置**：`.env.sepolia` 里要有
- `SEPOLIA_RPC_URL`（`status` 只读就够这个）
- `PRIVATE_KEY_SUPPLIER`（= sale owner `0xb5600060…`，`open`/`close` 需要）

## 范例：一次定向开放

```
$ scripts/sale-toggle.sh status
Sale:    0xA563fA13E2353aE7D65FCE37F4801288CD11FC3e
状态:    🔴 CLOSED (paused)
库存:    500.00 GToken
当前价:  $0.1500 / GToken

# —— 在群里发"现在开放,先到先得" ——
$ scripts/sale-toggle.sh open
→ open sale  (unpause())  on 0xA563fA13…
status               1 (success)
transactionHash      0x…
状态:    🟢 OPEN
库存:    500.00 GToken
当前价:  $0.1500 / GToken

# —— 群里的人在 launch.mushroom.cv/join.html 购买 ——
# —— 售罄,或你想停 ——
$ scripts/sale-toggle.sh close
→ close sale  (pause())  on 0xA563fA13…
状态:    🔴 CLOSED (paused)
```

关闭后，任何 `buyTokens` / `buyTokensFor`（self-pay 和 gasless 都经它）都会 revert（`whenNotPaused`），购买入口实际停摆。

## 注意

- **只有 GToken sale（`SaleContractV2`）有 `Pausable`**；`APNTsSaleContract`（aPNTs）当前**没有** pause。要给 aPNTs 也加开关，需要在合约上引入 `Pausable` 并重部署（走发布门）。
- 默认 `--sale` 是当前 canonical 地址；**每次重部署后更新脚本里的默认值**（或始终用 `--sale` 显式指定）。最新地址见 [`contracts/DEPLOYED.md`](../contracts/DEPLOYED.md)。
- owner 操作也可在 Etherscan 的 Write Contract（连 owner 钱包点 `pause`/`unpause`），脚本只是更方便。
- 想要“到点自动开/关”而非手动，需要在合约加 `saleStart/saleEnd` 时间窗口（当前没有，按需再做）。
