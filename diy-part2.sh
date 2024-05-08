# 修改主机名
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate

# 修改 Lan IP
sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 修改wifi名
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

# openclash #Core
cd openwrt/package
git clone https://github.com/vernesong/OpenClash
mv OpenClash/luci-app-openclash/ .
rm -rf OpenClash/
cd base-files/files
mkdir -p etc/openclash/core && cd etc/openclash/core
curl -L https://github.com/vernesong/OpenClash/blob/core/master/meta/clash-linux-arm64.tar.gz | tar zxf -
chmod +x clash
