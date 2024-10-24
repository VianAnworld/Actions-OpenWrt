#!/bin/bash
# 修改默认ip；主机名; 删除 ipv6 ula
sed -i "s/192.168.6.1/192.168.1.1/g; s/hostname='ImmortalWrt'/hostname='OpenWrt'/g; 48,54d" package/base-files/files/bin/config_generate
# 修改password
sed -i 's/root::/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856/g' package/base-files/files/etc/shadow
# 修改固件版本名称
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION=' $(date +"%Y%m%d") '/g" package/base-files/files/etc/openwrt_release
# 修改wifi
sed -i 's/ImmortalWrt-2.4G/SmartHome/g; s/ImmortalWrt-5G/online/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i '/encryption=none/a					set wireless.default_${dev}.key='@15859585276'' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i "s/encryption=none/encryption='psk-mixed'/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
# 禁止解析ipv6 DNS查询缓存设为0
sed -i '/filter_aaaa/s/0/1/g; /cachesize/s/8000/0/g' package/network/services/dnsmasq/files/dhcp.conf
# 设置eqos 下行1000; 上行50
sed -i 's/100/1000/g; s/20/50/g' package/mtk/applications/luci-app-eqos-mtk/root/etc/config/eqos
# 启用 net1
# sed -i '/turboacc.config.fullcone/s/0/2/g' package/mtk/applications/luci-app-turboacc-mtk/root/etc/uci-defaults/turboacc
# 删除bootstrap 替换默认主题为argon 并更换主题背景
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
# wget -O feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://w.wallhaven.cc/full/6d/wallhaven-6dzkwx.jpg
# 删除DDNS示例
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
