#!/usr/bin/env bash

# 修改openwrt登陆地址,把下面的192.168.31.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='R4A-G'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt / $(TZ=UTC-8 date "+%Y.%m.%d") @ LH❥Ting /g' package/lean/default-settings/files/zzz-default-settings

# copy smartdns configuration
sed -i 's#$(PKG_BUILD_DIR)/package/openwrt/address.conf#$(CURDIR)/files/address.conf#g' feeds/packages/net/smartdns/Makefile
sed -i 's#$(PKG_BUILD_DIR)/package/openwrt/files/etc/config/smartdns#$(CURDIR)/files/smartdns#g' feeds/packages/net/smartdns/Makefile
cp -r $(dirname $0)/../extra-files/smartdns/files feeds/packages/net/smartdns/

# copy uci-defaults script(s)
mkdir -p files/etc/uci-defaults
cp $(dirname $0)/uci-scripts/* files/etc/uci-defaults/

# switch ramips kernel to 5.10
sed -i "s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g" target/linux/ramips/Makefile
#删除原默认主题
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-theme-bootstrap
#rm -rf package/lean/luci-theme-material
rm -rf package/lean/luci-theme-netgear
rm -rf package/lean/luci-theme-ifit

# 状态系统增加个性信息
sed -i "s/exit 0//" package/lean/default-settings/files/zzz-default-settings

echo "" >> package/lean/default-settings/files/zzz-default-settings
echo "" >> package/lean/default-settings/files/zzz-default-settings
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings

# switch ramips kernel to 5.15
#sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.15' target/linux/ramips/Makefile

# copy kernel 5.10 version CPU overclocking patch
#cp $(dirname $0)/../extra-files/322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/

# set up WiFi
#sed -i 's/OpenWrt/coolxiaomi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i 's/wireless.default_radio${devidx}.encryption=none/wireless.default_radio${devidx}.encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=coolxiaomi' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/encryption/a\set wireless.default_radio${devidx}.key=coolphicomm' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# modify login password to coolxiaomi
#sed -i '/root/croot:$1$CBd7u73H$LvSDVXLBrzpk4JfuuN.Lv1:18676:0:99999:7:::' package/base-files/files/etc/shadow

#取消原主题luci-theme-bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' feeds/luci/collections/luci/Makefile

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 修改默认wifi名称ssid为Xiaomi_E2B0
sed -i 's/ssid=OpenWrt/ssid=Xiaomi_E2B0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改默认wifi密码key为password
sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

sed -i '/set wireless.default_radio${devidx}.encryption=psk2/a\set wireless.default_radio${devidx}.key=password' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# replace geodata source
. $(dirname $0)/../extra-files/update-geodata.sh
