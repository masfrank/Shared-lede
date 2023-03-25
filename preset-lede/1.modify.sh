1#!/bin/sh

#修改登录IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='R4A-G'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt / $(TZ=UTC-8 date "+%Y.%m.%d") @ LH❥Ting /g' package/lean/default-settings/files/zzz-default-settings

#更改主机型号，支持中文。 
sed -i "s/Xiaomi Mi Router 4A Gigabit Edition/小米4A千兆版路由/g" target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-gigabit.dts

#复制smartdns配置
rm -rf feeds/packages/net/smartdns
rm -rf package/feeds/packages/net/smartdns
cp -r extra-files/smartdns feeds/packages/net/

#复制uci-defaults脚本
mkdir -p files/etc/uci-defaults
cp $DEPLOYDIR/uci-scripts/* files/etc/uci-defaults/

#切换ramips内核到5.10
sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.10' target/linux/ramips/Makefile

#切换ramips内核到5.15
#sed -i '/KERNEL_PATCHVER/cKERNEL_PATCHVER:=5.15' target/linux/ramips/Makefile

#复制内核5.10版本CPU超频补丁
cp extra-files/322-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.10/

#设置WIFI
sed -i 's/OpenWrt/coolxiaomi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改登录密码为coolxiaomi
sed -i '/root/croot:$1$CBd7u73H$LvSDVXLBrzpk4JfuuN.Lv1:18676:0:99999:7:::' package/base-files/files/etc/shadow

#替换geodata源
. extra-files/update-geodata.sh
