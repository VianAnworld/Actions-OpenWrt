#!/bin/bash
# 删除重复包
#rm -rf feeds/luci/applications/luci-app-openclash
#rm -rf luci/applications/luci-app-openclash
#git clone -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash
sed -i '$a src-git MrH723 https://github.com/MrH723/openwrt-packages' feeds.conf.default
