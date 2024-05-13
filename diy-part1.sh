#!/bin/bash


#删除bootstrap主题
rm -rf luci/themes/luci-theme-bootstrap-mod
rm -rf luci/themes/luci-theme-bootstrap
# 删除重复包
#rm -rf feeds/luci/applications/luci-app-openclash
rm -rf luci/applications/luci-app-openclash
# Add a feed source
echo 'src-git OpenClash https://github.com/vernesong/OpenClash' >>feeds.conf.default
