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
#添加主题
git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd
#更换默认主题为opentopd，并删除bootstrap主题
sed -i 's#luci-theme-bootstrap#luci-theme-opentopd#g' feeds/luci/collections/luci/Makefile
sed -i 's/bootstrap/opentopd/g' feeds/luci/modules/luci-base/root/etc/config/luci
