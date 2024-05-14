# Modify
sed -i "s/ImmortalWrt/OpenWrt/g" ./package/base-files/files/bin/config_generate
sed -i 's/192.168.6.1/192.168.1.1/g' ./package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt-2.4G/SmartHome/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ImmortalWrt-5G/online/g' ./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/root::0:0:99999:7:::/root:$1$mCAXgXUF$6bgDhPFZRbF.2w0zCTQw00:19856:0:99999:7:::/g' ./package/base-files/files/etc/shadow

# OpenClash dev core
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

#更新软件包
UPDATE_PACKAGE() {
	local PKG_NAME=$1
	local PKG_REPO=$2
	local PKG_BRANCH=$3
	local PKG_SPECIAL=$4
	local REPO_NAME=$(echo $PKG_REPO | cut -d '/' -f 2)

	rm -rf $(find ../feeds/luci/ -type d -iname "*$PKG_NAME*" -prune)

	git clone --depth=1 --single-branch --branch $PKG_BRANCH "https://github.com/$PKG_REPO.git"

	if [[ $PKG_SPECIAL == "pkg" ]]; then
		cp -rf $(find ./$REPO_NAME/ -type d -iname "*$PKG_NAME*" -prune) ./
		rm -rf ./$REPO_NAME
	elif [[ $PKG_SPECIAL == "name" ]]; then
		mv -f $REPO_NAME $PKG_NAME
	fi
}

UPDATE_PACKAGE "design" "gngpp/luci-theme-design" "js"
UPDATE_PACKAGE "design-config" "gngpp/luci-app-design-config" "master"
UPDATE_PACKAGE "argon" "jerrykuku/luci-theme-argon" "master"
UPDATE_PACKAGE "argon-config" "jerrykuku/luci-app-argon-config" "master"

UPDATE_PACKAGE "helloworld" "fw876/helloworld" "master"
UPDATE_PACKAGE "openclash" "vernesong/OpenClash" "dev"

#更新软件包版本
UPDATE_VERSION() {
	local PKG_NAME=$1
	local PKG_REPO=$2
	local PKG_FILE=$(find ../feeds/packages/*/$PKG_NAME/ -type f -name "Makefile" 2>/dev/null)

	if [ -f "$PKG_FILE" ]; then
		local OLD_VER=$(grep -Po "PKG_VERSION:=\K.*" $PKG_FILE)
		local NEW_VER=$(git ls-remote --tags --sort="version:refname" "https://github.com/$PKG_REPO.git" | tail -n 1 | sed "s/.*\/v//")
		local NEW_HASH=$(curl -sfL "https://codeload.github.com/$PKG_REPO/tar.gz/v$NEW_VER" | sha256sum | cut -b -64)

		if dpkg --compare-versions "$OLD_VER" lt "$NEW_VER"; then
			sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$NEW_VER/g" $PKG_FILE
			sed -i "s/PKG_HASH:=.*/PKG_HASH:=$NEW_HASH/g" $PKG_FILE
			echo "$PKG_NAME ver has been updated!"
		else
			echo "$PKG_NAME ver is already the latest!"
		fi
	else
		echo "$PKG_NAME is not found!"
	fi
}

UPDATE_VERSION "sing-box" "SagerNet/sing-box"

#!/bin/bash

#预置HomeProxy数据
if [ -d *"homeproxy"* ]; then
	HP_PATCH="homeproxy/root/etc/homeproxy/resources"
	rm -rf ./$HP_PATCH/*

	UPDATE_RESOURCES() {
		local RES_TYPE=$1
		local RES_FILE=$2
		local RES_EXT=${2##*.}
		local RES_REPO=$3
		local RES_BRANCH=$4
		local RES_DEPTH=${5:-1}

		git clone -q --depth=$RES_DEPTH --single-branch --branch $RES_BRANCH "https://github.com/$RES_REPO.git" ./$RES_TYPE/

		cd ./$RES_TYPE/

		echo $(git log -1 --pretty=format:'%s' -- $RES_FILE | grep -o "[0-9]*") > "$RES_TYPE.ver"
		[ "$RES_EXT" != "db" ] && mv -f "$RES_FILE" "$RES_TYPE.$RES_EXT"
		cp -f $RES_TYPE.{$RES_EXT,ver} ../$HP_PATCH/ && chmod +x ../$HP_PATCH/*

		cd .. && rm -rf ./$RES_TYPE/

		echo "$RES_TYPE done!"
	}

	UPDATE_RESOURCES "china_ip4" "ipv4.txt" "1715173329/IPCIDR-CHINA" "master" "5"
	UPDATE_RESOURCES "china_ip6" "ipv6.txt" "1715173329/IPCIDR-CHINA" "master" "5"
	UPDATE_RESOURCES "gfw_list" "gfw.txt" "Loyalsoldier/v2ray-rules-dat" "release"
	UPDATE_RESOURCES "china_list" "direct-list.txt" "Loyalsoldier/v2ray-rules-dat" "release"
	#UPDATE_RESOURCES "geoip" "geoip.db" "1715173329/sing-geoip" "release"
	#UPDATE_RESOURCES "geosite" "geosite.db" "1715173329/sing-geosite" "release"

	sed -i -e "s/full://g" -e "/:/d" ./$HP_PATCH/china_list.txt

	echo "homeproxy date has been updated!"
fi

#预置OpenClash内核和数据
if [ -d *"OpenClash"* ]; then
	CORE_VER="https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version"
	CORE_TYPE=$(echo $WRT_TARGET | egrep -iq "64|86" && echo "amd64" || echo "arm64")
	CORE_TUN_VER=$(curl -sfL $CORE_VER | sed -n "2{s/\r$//;p;q}")

	CORE_DEV="https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux-$CORE_TYPE.tar.gz"
	CORE_MATE="https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux-$CORE_TYPE.tar.gz"
	CORE_TUN="https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux-$CORE_TYPE-$CORE_TUN_VER.gz"

	GEO_MMDB="https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb"
	GEO_SITE="https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat"
	GEO_IP="https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat"

	cd ./OpenClash/luci-app-openclash/root/etc/openclash/

	curl -sfL -o Country.mmdb $GEO_MMDB && echo "Country.mmdb done!"
	curl -sfL -o GeoSite.dat $GEO_SITE && echo "GeoSite.dat done!"
	curl -sfL -o GeoIP.dat $GEO_IP && echo "GeoIP.dat done!"

	mkdir ./core/ && cd ./core/

	curl -sfL -o meta.tar.gz $CORE_MATE && tar -zxf meta.tar.gz && mv -f clash clash_meta && echo "meta done!"
	curl -sfL -o tun.gz $CORE_TUN && gzip -d tun.gz && mv -f tun clash_tun && echo "tun done!"
	curl -sfL -o dev.tar.gz $CORE_DEV && tar -zxf dev.tar.gz && echo "dev done!"

	chmod +x ./clash* && rm -rf ./*.gz

	echo "openclash date has been updated!"
fi
