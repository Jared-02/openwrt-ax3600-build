#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# echo 'src-git routing https://github.com/coolsnowwolf/routing' >>feeds.conf.default
# echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default

# AX3600 compatibility issues
sed -i 's|coolsnowwolf/packages|coolsnowwolf/packages.git^11cf4447ce4f1e4f655747aadbc505bde03f19e6|' feeds.conf.default
sed -i 's|coolsnowwolf/luci|coolsnowwolf/luci.git^380e994419aae665733796bb1ae14659936ea101|' feeds.conf.default
sed -i 's|feed/routing.git|feed/routing.git^2134c56d12ced1c5b191b35e18f8330384860f15|' feeds.conf.default
sed -i 's|feed/telephony.git|feed/telephony.git^8cf20bc21ceac07c4c3e56e23a3dd1596a0bf92d|' feeds.conf.default
