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

# 替换源中openclash
rm -rf luci/applications/luci-app-openclash
# Clone 项目
#mkdir luci/applications/luci-app-openclash
cd luci/applications/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull --depth 1 origin master
git branch --set-upstream-to=origin/master master

# 编译 po2lmo (如果有po2lmo可跳过)
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# OpenClash dev core
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
