# 下游依赖清单（Downstream Dependencies）

> 单一事实源：launch 的合约/relay 变更会影响哪些下游、各依赖什么、release 后必须周知谁。
> 配套脚本：`scripts/release-notify.sh`（重部署后生成/发送标准周知）。

launch 是被依赖方（上游只有固定的权威 GToken/aPNTs）。每次 sale 栈 / BuyHelper 重部署或签名格式变更，必须周知下面的下游。

## 下游清单

| 下游 | 仓库 | 依赖 launch 的什么 | 协调 issue |
|---|---|---|---|
| **SDK** | `AAStarCommunity/aastar-sdk` | sale 地址(`LAUNCH_SALE_ADDRESSES`)+ BuyHelper 地址 + ABI + **EIP-3009 签名构造**(前端/SDK 生成用户签名) | #161 / #145 |
| **DVT relay** | `AAStarCommunity/dvt` | BuyHelper 地址(`RELAY_BUY_HELPER`，executeBuy 提交目标)。**只透传 v/r/s，不构造/验签 typehash** | #5 |

## 变更类型 → 各下游 action 矩阵

| 变更类型 | SDK 要做 | DVT relay 要做 |
|---|---|---|
| **addr**（合约地址变：sale / BuyHelper 重部署） | 更新 `LAUNCH_SALE_ADDRESSES` + BuyHelper(BuyIntent domain `verifyingContract`) | 更新 `RELAY_BUY_HELPER`（env + 重启，零代码） |
| **sig**（EIP-3009/签名格式变，如 transferWithAuth→receiveWithAuth） | 🔴 **改签名构造代码**（primaryType / typehash），否则 gasless 验签全挂 | 一般无需改（只透传 v/r/s）——但需**确认**没硬编码 typehash |
| **abi**（合约 ABI 变：新增/改函数签名） | 刷新 ABI + 适配新方法 | 若 executeBuy ABI 变则更新（本仓库 v3 handler 也要同步） |

## 迁移时序（避免失败窗口）

BuyHelper 重部署时，SDK 的 BuyIntent `verifyingContract` 与 relay 的提交目标必须**同指新 BuyHelper**，两系统无法原子切换 → 有一个短暂窗口 relay 返回 400 `SIGNATURE_INVALID`。零停机做法：relay 迁移期同时接受新旧两个 BuyHelper domain（见 dvt#5）。

## Release 后周知（强制）

每次重部署后跑：

```bash
scripts/release-notify.sh --network sepolia \
  --sale-v2 0x.. --apnts-sale 0x.. --buyhelper 0x.. \
  --changes addr,sig,abi \
  --sdk-issue 161 --dvt-issue 5 --post
```

不发 `--post` 时只打印通知 markdown 供人审。
