#!/usr/bin/env bash
#
# release-notify.sh — launch 重部署后周知上下游的标准流程
#
# 依赖清单（单一事实源）: docs/DOWNSTREAM-DEPS.md
# 下游: SDK (AAStarCommunity/aastar-sdk) · DVT relay (AAStarCommunity/dvt)
#
# 用法:
#   scripts/release-notify.sh \
#     --network sepolia \
#     --sale-v2 0x.. --apnts-sale 0x.. --buyhelper 0x.. \
#     --changes addr,sig,abi \
#     [--sdk-issue 161] [--dvt-issue 5] \
#     [--note "一句话变更摘要"] \
#     [--post]
#
# --changes (逗号分隔) 决定各下游的 action:
#   addr = 合约地址变  → SDK 换 sale/BuyHelper 地址; DVT 换 RELAY_BUY_HELPER
#   sig  = 签名格式变  → SDK 改 EIP-3009 typehash(必改代码); DVT 透传不变(需确认)
#   abi  = ABI 变      → SDK 刷新 ABI + 适配
#
# 不带 --post 只打印通知 markdown（人审）; 带 --post 用 gh 发到协调 issue。

set -euo pipefail

NETWORK="sepolia"
SALE_V2="" ; APNTS_SALE="" ; BUYHELPER=""
CHANGES="" ; NOTE=""
SDK_REPO="AAStarCommunity/aastar-sdk"
DVT_REPO="AAStarCommunity/dvt"
SDK_ISSUE="" ; DVT_ISSUE=""
POST=0

while [ $# -gt 0 ]; do
  case "$1" in
    --network)     NETWORK="$2"; shift 2 ;;
    --sale-v2)     SALE_V2="$2"; shift 2 ;;
    --apnts-sale)  APNTS_SALE="$2"; shift 2 ;;
    --buyhelper)   BUYHELPER="$2"; shift 2 ;;
    --changes)     CHANGES="$2"; shift 2 ;;
    --note)        NOTE="$2"; shift 2 ;;
    --sdk-issue)   SDK_ISSUE="$2"; shift 2 ;;
    --dvt-issue)   DVT_ISSUE="$2"; shift 2 ;;
    --post)        POST=1; shift ;;
    *) echo "未知参数: $1" >&2; exit 1 ;;
  esac
done

[ -n "$BUYHELPER" ] || { echo "缺 --buyhelper" >&2; exit 1; }
[ -n "$CHANGES" ]   || { echo "缺 --changes (addr/sig/abi)" >&2; exit 1; }

has_change() { echo ",$CHANGES," | grep -q ",$1,"; }

# ── 各下游 action（按 changes 拼装）─────────────────────────────────
sdk_actions() {
  has_change addr && echo "- [ ] 更新 \`LAUNCH_SALE_ADDRESSES\`($NETWORK):SaleV2 \`$SALE_V2\` · APNTsSale \`$APNTS_SALE\`"
  has_change addr && echo "- [ ] 更新 BuyHelper(BuyIntent EIP-712 domain \`verifyingContract\`)→ \`$BUYHELPER\`"
  has_change sig  && echo "- [ ] 🔴 **改 EIP-3009 签名构造**:\`primaryType\` \`TransferWithAuthorization\` → \`ReceiveWithAuthorization\`(类型字段不变,只换 typehash);否则 gasless 验签全挂"
  has_change abi  && echo "- [ ] 刷新合约 ABI + 适配新/改方法(\`forge build\` 后取 \`contracts/out/…\`)"
  echo "- [ ] 跑连通性自测 + 回贴确认"
}
dvt_actions() {
  has_change addr && echo "- [ ] 更新 \`RELAY_BUY_HELPER\` → \`$BUYHELPER\`(env + 重启,零代码)"
  has_change sig  && echo "- [ ] 确认 relay 未硬编码 EIP-3009 typehash(应只透传 v/r/s;若有验签逻辑需同步)"
  has_change abi  && echo "- [ ] 若 \`executeBuy\` ABI 变,同步 relay 调用编码"
  echo "- [ ] 迁移期可选:同时接受新旧 BuyHelper domain 以零停机(见本 issue 历史)"
  echo "- [ ] 回贴确认已切到新 BuyHelper"
}

ADDR_TABLE=$(cat <<EOF
| 合约 | 地址 |
|---|---|
| SaleContractV2 | \`$SALE_V2\` |
| APNTsSaleContract | \`$APNTS_SALE\` |
| BuyHelper | \`$BUYHELPER\` |
EOF
)

build_msg() {  # $1 = 下游名, $2 = actions
  cat <<EOF
## 🚢 launch release 周知（${NETWORK}）— ${1} 请同步

${NOTE:+> $NOTE

}变更类型: **$CHANGES**

$ADDR_TABLE

### 你方 action
$2

### 双向依赖
- launch → 你: 上面的新地址 / 变更
- 你 → launch: 完成后回贴本 issue 确认（用于闭环）

> 完整依赖矩阵 + 迁移时序见 launch \`docs/DOWNSTREAM-DEPS.md\`。
EOF
}

SDK_MSG=$(build_msg "SDK" "$(sdk_actions)")
DVT_MSG=$(build_msg "DVT relay" "$(dvt_actions)")

echo "================ SDK ($SDK_REPO${SDK_ISSUE:+ #$SDK_ISSUE}) ================"
echo "$SDK_MSG"
echo ""
echo "================ DVT ($DVT_REPO${DVT_ISSUE:+ #$DVT_ISSUE}) ================"
echo "$DVT_MSG"

if [ "$POST" = "1" ]; then
  echo ""
  echo "── 发布中 ──"
  if [ -n "$SDK_ISSUE" ]; then
    gh issue comment "$SDK_ISSUE" --repo "$SDK_REPO" --body "$SDK_MSG" && echo "✅ SDK #$SDK_ISSUE"
  else echo "⚠️ 未给 --sdk-issue,跳过 SDK 发布"; fi
  if [ -n "$DVT_ISSUE" ]; then
    gh issue comment "$DVT_ISSUE" --repo "$DVT_REPO" --body "$DVT_MSG" && echo "✅ DVT #$DVT_ISSUE"
  else echo "⚠️ 未给 --dvt-issue,跳过 DVT 发布"; fi
else
  echo ""
  echo "(预览模式;加 --post 发布到协调 issue)"
fi
