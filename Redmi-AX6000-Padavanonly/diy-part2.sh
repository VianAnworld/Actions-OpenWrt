#!/bin/bash

# 删除全局网络选项; 修改Lan ip; DHCP模式下不生成wan6接口; PPPOE模式下不生成wan6接口
sed -i '48,54d; s/192.168.6.1/192.168.8.1/g; 184,191d; 200,208d' package/base-files/files/bin/config_generate
# 修改登录密码
sed -i 's/root::/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856/g' package/base-files/files/etc/shadow
# 修改固件版本名称
sed -i "s/OPENWRT_RELEASE=.*/OPENWRT_RELEASE=\"$(date +%Y%m%d)\"/g" package/base-files/files/usr/lib/os-release
# 设置eqos,下行400; 上行50
sed -i 's/100/400/g; s/20/50/g' package/mtk/applications/luci-app-eqos-mtk/root/etc/config/eqos
# 修改wifi密码、wifi名; 加密方式
sed -i '/encryption=none/a					set wireless.default_${dev}.key='@15859585276'' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i "s/ImmortalWrt-2.4G/SmartHome/g; s/ImmortalWrt-5G/online/g; s/encryption=.*/encryption='psk2'/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
# 禁止解析ipv6 DNS；查询缓存设为0: 关闭DNS重定向
sed -i '/filter_aaaa/s/0/1/g; /cachesize/s/8000/0/g; /dns_redirect/s/1/0/g' package/network/services/dnsmasq/files/dhcp.conf
# 禁用lan口ipv6的RA服务; 禁用SLAAC
sed -i 's/lan.ra=.*/lan.ra=disabled/g; s/ra_slaac=.*/ra_slaac=0/g' package/network/services/odhcpd/files/odhcpd.defaults
# 关闭LED
sed -i 's/netdev "wan" "wan" "rgb:network" "wan" "link"/default "wan" "wan" "rgb:status" "0"/g' target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
# 替换默认主题为argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
# 更换argon主题背景
wget -O feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://w.wallhaven.cc/full/ly/wallhaven-lyqxqq.png

# 替换nikki配置文件
wget -O package/luci-app-nikki/nikki/files/nikki.conf https://raw.githubusercontent.com/VianAnworld/Conf/main/nikki
