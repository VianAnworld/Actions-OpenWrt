#!/bin/bash
# 修改主机名
sed -i "s/hostname='ImmortalWrt'/hostname='OpenWrt'/g" package/base-files/files/bin/config_generate
# 修正CPU频率
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="2.0GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo
# 固件版本名称自定义
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='$(date +"%Y%m%d")'/g" package/base-files/files/etc/openwrt_release
# 修改登录IP
sed -i 's/192.168.6.1/192.168.1.1/g' ./package/base-files/files/bin/config_generate
# 修改password
sed -i 's/root::0:0:99999:7:::/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856:0:99999:7:::/g' ./package/base-files/files/etc/shadow
# 修改SSID 
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
# 替换默认主题为argon 并删除bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# 更换主题背景
wget -O feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://raw.githubusercontent.com/VianAnworld/Actions-OpenWrt/main/1.jpg

# 更新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone -b master --depth=1 --filter=blob:none --sparse https://github.com/vernesong/OpenClash.git feeds/luci/applications/luci-app-openclash
git -C feeds/luci/applications/luci-app-openclash sparse-checkout set luci-app-openclash
# 添加 OpenClash dev 内核
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>
