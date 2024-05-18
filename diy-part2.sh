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
# 替换源中ssrplus
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/dns2tcp
rm -rf feeds/packages/devel/gn
rm -rf feeds/packages/net/hysteria
rm -rf feeds/packages/net/ipt2socks
rm -rf feeds/packages/net/lua-neturl
rm -rf feeds/packages/net/microsocks
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/naiveproxy
rm -rf feeds/packages/net/redsocks2
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/shadowsocksr-libev
rm -rf feeds/packages/net/simple-obfs
rm -rf feeds/packages/net/tcping
rm -rf feeds/packages/net/trojan
rm -rf feeds/packages/net/tuic-client
rm -rf feeds/packages/net/v2ray-core
rm -rf feeds/packages/net/v2ray-plugin
rm -rf feeds/packages/net/v2raya
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/xray-plugin
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
# 替换源中openclash
#rm -rf feeds/luci/applications/luci-app-openclash
#git clone -b master --filter=blob:none https://github.com/vernesong/OpenClash.git package/luci-app-openclash
# OpenClash dev core
#curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
#tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
#chmod +x /tmp/clash >/dev/null 2>&1
#mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
#mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
#rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
