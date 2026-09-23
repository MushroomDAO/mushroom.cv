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
# 2026-09-23 起主域名不再挂 AdSense（广告只保留在 blog.mushroom.cv 自己的仓库里，
# 两站是各自独立的 Cloudflare Pages 项目）。这里反过来校验：没有任何页面带广告代码，
# 防止以后哪次编辑又手滑把 adsbygoogle 带回来。
for f in site/*.html; do
  if grep -Fq 'adsbygoogle' "$f"; then echo "$f 不应带 AdSense 代码（主域名已不投放广告）"; exit 1; fi
done
echo "site/ 校验通过（$(find site -type f | wc -l) 个文件）"
