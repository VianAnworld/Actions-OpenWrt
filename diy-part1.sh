#!/bin/bash
# 替换源
sed -i 's/src-git-full luci https://github.com/immortalwrt/luci.git;openwrt-21.02/src-git-full luci https://github.com/immortalwrt/luci.git;openwrt-23.05/g' ./feeds.conf.default
