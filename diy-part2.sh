#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
##-----------------修改主机名------------------
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate
##-----------------修改 Lan IP ------------------
sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate
##-----------------自定义插件------------------
git clone -b master https://github.com/vernesong/OpenClash.git package/feeds/luci-app-openclash
##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/dev/clash-linux-arm64.tar.gz -o /tmp/clash-linux-arm64.tar.gz
tar zxvf /tmp/clash-linux-arm64.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash-linux-arm64.tar.gz >/dev/null 2>&1
