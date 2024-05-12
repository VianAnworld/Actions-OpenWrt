#!/bin/bash

# OpenClash
#git clone -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash
sed -i '$a src-git OpenClash https://github.com/vernesong/OpenClash' feeds.conf.default
git clone https://github.com/vernesong/OpenClash package/mtk/applications/luci-app-openclash
