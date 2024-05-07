# 修改默认密码
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

# 修改主机名
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate

# 修改 Lan IP
sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 修改wifi名
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

# 添加自定义插件
git clone -b master https://github.com/vernesong/OpenClash.git package/feeds/luci-app-openclash

# openclash /Core /mate
mkdir -p files/etc/openclash/core
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
chmod +x files/etc/openclash/core/clash*
