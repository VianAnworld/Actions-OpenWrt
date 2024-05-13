# Modify
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate
sed -i 's/192.168.6.1/192.168.1.1/g' ./package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/root::0:0:99999:7:::/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856:0:99999:7:::/g' ./package/base-files/files/etc/shadow

# 删除重复包
rm -rf feeds/luci/applications/luci-app-openclash
#rm -rf luci/applications/luci-app-openclash
git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
# OpenClash dev core
#curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
#tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
#chmod +x /tmp/clash >/dev/null 2>&1
#mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
#mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
#rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
