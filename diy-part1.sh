#!/bin/bash

# openclash
find ./ | grep Makefile | xargs rm -f
git clone https://github.com/vernesong/OpenClash.git -b master package/luci-app-openclash
#echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default
# passwall
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
