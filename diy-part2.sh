#!/bin/bash
# 主机名=OpenWrt
sed -i "s/hostname='ImmortalWrt'/hostname='OpenWrt'/g" ./package/base-files/files/bin/config_generate
# 登录IP=192.168.1.1
sed -i 's/192.168.6.1/192.168.1.1/g' ./package/base-files/files/bin/config_generate
# 修改password
sed -i 's/root::0/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856/g' ./package/base-files/files/etc/shadow
# 固件版本名称自定义
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION=' $(date +"%Y%m%d") '/g" ./package/base-files/files/etc/openwrt_release
# 修正CPU频率
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="2.0GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo
# wifi设置
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i '/encryption=none/a					set wireless.default_${dev}.key='@15859585276'' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i "s/encryption=none/encryption='sae-mixed'/g" ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
# 设置dns缓存为0  option cachesize 0
sed -i 's/8000/0/g' ./package/network/services/dnsmasq/files/dhcp.conf
# 删除ddns示例
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
# 删除bootstrap 替换默认主题为argon 并更换主题背景
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
wget -O feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://raw.githubusercontent.com/VianAnworld/Actions-OpenWrt/main/1.jpg


# 更新 golang
#rm -rf feeds/packages/lang/golang
#git clone --depth=1 -b 21.x  https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# 更新openclash
 mkdir package/luci-app-openclash
 cd package/luci-app-openclash
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

# 添加 OpenClash Meta 内核
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz -o /tmp/clash-meta.tar.gz
tar zxvf /tmp/clash-meta.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/luci-app-openclash/root/etc/openclash/core/clash_meta >/dev/null 2>&1
rm -rf /tmp/clash-meta.tar.gz >/dev/null 2>&1
