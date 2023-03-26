#!/bin/sh

# 下载源码
git clone --depth 1 https://github.com/coolsnowwolf/lede.git && mv ./lede/* ./

# 下载插件
rm -rf package/lean/luci-theme-argon
mkdir -p package/supply-packages && cd package/supply-packages
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon-18.06
git clone --depth 1 https://github.com/kenzok8/openwrt-packages.git
git clone --depth 1 https://github.com/Ausaci/luci-app-nat6-helper.git
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git
git clone https://github.com/openwrt/luci.git -b openwrt-18.06 --depth=1  && mv ./luci/applications/luci-app-wireguard/ ./luci-app-wireguard/&&rm -rf ./luci
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall.git pw-dependencies




