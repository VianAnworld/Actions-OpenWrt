#!/bin/bash

sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate
sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

# openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/luci-app-openclash
