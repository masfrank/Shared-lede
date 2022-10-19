#!/bin/sh
# 下载源码
git clone https://github.com/coolsnowwolf/lede.git
mv ./lede/* ./

# 下载自定义插件
# 删除原默认主题
rm -rf package/lean/luci-theme-bootstrap
rm -rf package/lean/luci-theme-material
rm -rf package/lean/luci-theme-netgear
rm -rf package/lean/luci-theme-ifit
rm -rf package/lean/luci-theme-argon
mkdir -p package/myapps
cd package/myapps
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone https://github.com/jerrykuku/luci-app-argon-config.git
git clone https://github.com/kenzok8/openwrt-packages.git
git clone https://github.com/Ausaci/luci-app-nat6-helper.git
git clone -b packages --single-branch https://github.com/xiaorouji/openwrt-passwall.git
