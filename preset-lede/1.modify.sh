#!/usr/bin/env bash

sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

sed -i "s/hostname='LEDE'/hostname='R4A-G'/" package/base-files/files/bin/config_generate

BUILD_DATE="$(TZ=UTC-8 date +%Y.%m.%d)"
sed -i "s|DISTRIB_DESCRIPTION='LEDE '|DISTRIB_DESCRIPTION='${BUILD_DATE} @ LH❥Ting '|" package/lean/default-settings/files/zzz-default-settings

sed -i 's/|| ssid="LEDE"/|| ssid="Xiaomi_E2B0"/' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/|| encryption="none"/|| encryption="psk2"/' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's|key="$default_key"|key="password"|' package/kernel/mac80211/files/lib/wifi/mac80211.sh

mkdir -p files/etc/uci-defaults
cp $(dirname $0)/uci-scripts/* files/etc/uci-defaults/

# switch ramips kernel to 5.10
sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.10' target/linux/ramips/Makefile

# switch ramips kernel to 5.15
#sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.15' target/linux/ramips/Makefile

# copy kernel 5.10 version CPU overclocking patch
#cp $(dirname $0)/../extra-files/322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/
