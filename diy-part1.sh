#!/bin/bash
#rm -rf ./feeds.conf.default
sed -i '$a src-git kenzok8 https://github.com/kenzok8/small-package' feeds.conf.default
