#!/bin/bash
#取消掉feeds.conf.default文件里面的luci的#注释
sed -i 's/^#\(.*luci\)/\1/' feeds.conf.default
src-git luci https://github.com/immortalwrt/luci.git;openwrt-23.05 feeds.conf.default
