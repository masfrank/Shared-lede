#!/bin/sh

# 下载源码
git clone --depth 1 https://github.com/coolsnowwolf/lede.git && mv ./lede/* ./

# 下载插件
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/lean/luci-app-argon-config
mkdir -p package/supply-packages && cd package/supply-packages
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon-18.06
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
git clone --depth 1 https://github.com/kenzok8/openwrt-packages.git
git clone --depth 1 https://github.com/Ausaci/luci-app-nat6-helper.git
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall.git pw-dependencies




