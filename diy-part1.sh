#!/bin/bash
#取消掉feeds.conf.default文件里面的helloworld的#注释
sed -i 's/^#\(.*luci\)/\1/' feeds.conf.default
