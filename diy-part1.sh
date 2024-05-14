#!/bin/bash
#取消掉feeds.conf.default文件里面的luci的#注释
sed -i 's/^#\(.*luci\)/\1/' feeds.conf.default
src-git -b openwrt-23.05 luci https://github.com/immortalwrt/luci.git feeds.conf.default
