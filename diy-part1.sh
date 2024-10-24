#!/bin/bash

# 更新软件包
# openclash
# rm -rf feeds/luci/applications/luci-app-openclash
# git clone -b master --depth=1 --filter=blob:none --sparse https://github.com/vernesong/OpenClash.git package/luci-app-openclash && git -C package/luci-app-openclash sparse-checkout set luci-app-openclash

# mihomoTproxy
echo "src-git mihomo https://github.com/morytyann/OpenWrt-mihomo.git;main" >> "feeds.conf.default"
