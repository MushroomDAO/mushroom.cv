#!/usr/bin/env bash
# 部署前校验 site/ 构建产物。CI（.github/workflows/deploy-pages.yml）和本地 preflight 跑的是同一份。
# 在仓库根目录执行。
set -euo pipefail
test -f site/index.html
test -f site/public-goods.html
test -f site/assets/goods-data.js
# 首页必须真的是花园页，别把空壳推上线
grep -q 'garden-stage' site/index.html
grep -q 'MYCELIUM_GOODS' site/assets/goods-data.js
# 除钱包/购买页外，每个页面的 <head> 都要带 AdSense，ads.txt 也得在根目录。
# join / join-gasless 有 MetaMask 签名和购买流程，刻意不放广告（防诈骗广告贴着购买按钮），
# 这里反过来也要校验它们确实没有。
# 逐个文件判断：grep -c 读不了文件会返回 2，在 $() 里配合 set -e 直接让 job 失败，
# 不会被当成「没匹配」放过去。
ADS_SRC='adsbygoogle.js?client=ca-pub-3323568150935057'
NO_ADS=(site/join.html site/join-gasless.html)
for f in "${NO_ADS[@]}"; do
  test -f "$f"
  if grep -Fq 'adsbygoogle' "$f"; then echo "$f 是钱包/购买页，不应带广告"; exit 1; fi
done
for f in site/*.html; do
  case " ${NO_ADS[*]} " in *" $f "*) continue ;; esac
  n=$(grep -Fc "$ADS_SRC" "$f" || [ $? -eq 1 ])
  if [ "$n" != 1 ]; then echo "$f 应恰好带 1 处 AdSense 代码，实际 ${n:-0} 处"; exit 1; fi
done
grep -Fxq 'google.com, pub-3323568150935057, DIRECT, f08c47fec0942fa0' site/ads.txt
echo "site/ 校验通过（$(find site -type f | wc -l) 个文件）"
