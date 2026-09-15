#!/usr/bin/env bash
#
# sale-toggle.sh — 手动开/关 GToken 销售 (SaleContractV2 Pausable)
#
# 用销售合约的 Pausable 控制开放/关闭,限制扩散速度(anti-sybil):
# 建群通知 → open → 大家抢 → 售罄或 close。详见 docs/SALE-OPEN-CLOSE.md。
#
# 用法:
#   scripts/sale-toggle.sh status        # 查状态(开/关?库存?价格?) — 只读,免私钥
#   scripts/sale-toggle.sh open          # 开放销售(unpause)  — onlyOwner
#   scripts/sale-toggle.sh close         # 关闭销售(pause)    — onlyOwner
#   scripts/sale-toggle.sh status --sale 0x..   # 指定别的 sale
#
# 需 .env.sepolia: SEPOLIA_RPC_URL(+ open/close 还需 PRIVATE_KEY_SUPPLIER = sale owner)。
# 注:仅 GToken sale (SaleContractV2) 有 Pausable;APNTsSaleContract 当前无 pause。

set -euo pipefail

ACTION="${1:-}"
# 当前 canonical SaleContractV2 (重部署后更新此默认值,或用 --sale 覆盖)
SALE="0xA563fA13E2353aE7D65FCE37F4801288CD11FC3e"
shift || true
while [ $# -gt 0 ]; do
  case "$1" in
    --sale) SALE="$2"; shift 2 ;;
    *) echo "未知参数: $1" >&2; exit 1 ;;
  esac
done

ENV_FILE="$(cd "$(dirname "$0")/.." && pwd)/.env.sepolia"
[ -f "$ENV_FILE" ] && { set -a; . "$ENV_FILE"; set +a; }
RPC="${SEPOLIA_RPC_URL:-${SEPOLIA_RPC_URL2:-}}"
[ -n "$RPC" ] || { echo "缺 SEPOLIA_RPC_URL" >&2; exit 1; }

human() { python3 -c "print(f'{${1:-0}/10**${2}:.${3}f}')" 2>/dev/null || echo "${1}"; }

show_status() {
  local paused inv price
  paused=$(cast call "$SALE" "paused()(bool)" --rpc-url "$RPC" 2>/dev/null | awk '{print $1}')
  inv=$(cast call "$SALE" "availableInventory()(uint256)" --rpc-url "$RPC" 2>/dev/null | awk '{print $1}')
  price=$(cast call "$SALE" "getCurrentPriceUSD()(uint256)" --rpc-url "$RPC" 2>/dev/null | awk '{print $1}')
  echo "Sale:    $SALE"
  echo "状态:    $([ "$paused" = "true" ] && echo '🔴 CLOSED (paused)' || echo '🟢 OPEN')"
  echo "库存:    $(human "$inv" 18 2) GToken"
  echo "当前价:  \$$(human "$price" 6 4) / GToken"
}

case "$ACTION" in
  status)
    show_status ;;
  open|close)
    [ -n "${PRIVATE_KEY_SUPPLIER:-}" ] || { echo "缺 PRIVATE_KEY_SUPPLIER (sale owner)" >&2; exit 1; }
    fn=$([ "$ACTION" = "open" ] && echo "unpause()" || echo "pause()")
    echo "→ ${ACTION} sale  ($fn)  on $SALE ..."
    cast send "$SALE" "$fn" --private-key "$PRIVATE_KEY_SUPPLIER" --rpc-url "$RPC" 2>&1 \
      | grep -iE "^status|^transactionHash" | head -2
    echo ""
    show_status ;;
  *)
    echo "用法: sale-toggle.sh {status|open|close} [--sale 0x..]"
    echo "  status  查开/关 + 库存 + 价格 (只读)"
    echo "  open    开放销售 (unpause, onlyOwner)"
    echo "  close   关闭销售 (pause,   onlyOwner)"
    exit 1 ;;
esac
