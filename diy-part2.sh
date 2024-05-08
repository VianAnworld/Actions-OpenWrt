# 修改主机名
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate

# 修改 Lan IP
sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 修改wifi名
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

# openclash #Core
git clone https://github.com/vernesong/OpenClash.git package/lean/luci-app-openclash
