#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.18.1/g' package/base-files/files/bin/config_generate

# 修改连接数
# sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=165535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
# 修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# themes
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
cd package/luci-app-argon-config
git checkout 73dfdfda61c86b26b72acd17c8b03b0dd0107919
cd ../..

# 添加额外非必须软件包
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# git clone https://github.com/zzsj0928/luci-app-pushbot.git package/luci-app-pushbot
# git clone https://github.com/riverscn/openwrt-iptvhelper.git package/openwrt-iptvhelper

# ipt2socks 上游仓库 hash 更新
sed -i 's|73a2498dc95934c225d358707e7f7d060b5ce81aa45260ada09cbd15207d27d1|5279eb1cb7555cf9292423cc9f672dc43e6e214b3411a6df26a6a1cfa59d88b7|' feeds/packages/net/ipt2socks/Makefile

# qca 包上游仓库地址更新
find \
  package/lean/shortcut-fe/simulated-driver/ \
  package/qca/nss/qca-nss-cfi/ \
  package/qca/nss/qca-nss-clients/ \
  package/qca/nss/qca-nss-crypto/ \
  package/qca/nss/qca-nss-drv-64/ \
  package/qca/nss/qca-nss-drv/ \
  package/qca/nss/qca-nss-ecm/ \
  package/qca/nss/qca-nss-gmac/ \
  package/qca/nss/qca-nss-rfs/ \
  package/qca/nss/qca-ssdk-shell/ \
  package/qca/nss/qca-ssdk/ \
  -type f -name 'Makefile' \
  -exec sed -i 's|source.codeaurora.org/quic|git.codelinaro.org/clo|' {} \;

find \
  package/qca/nss/qca-nss-clients-64/ \
  package/qca/nss/qca-nss-dp/ \
  package/qca/nss/qca-nss-ecm-64/ \
  -type f -name 'Makefile' \
  -exec sed -i 's|source.codeaurora.org/quic/cc-qrdk|git.codelinaro.org/clo/qsdk|' {} \;
