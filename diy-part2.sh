#!/bin/bash
# Modify hostname
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate
# Modify default IP
sed -i 's/192.168.6.1/192.168.1.1/g' ./package/base-files/files/bin/config_generate
# Modify default ssid
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
# Modify root
sed -i 's/root::0:0:99999:7:::/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856:0:99999:7:::/g' ./package/base-files/files/etc/shadow
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/v2ray-geodata
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
