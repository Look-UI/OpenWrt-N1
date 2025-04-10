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

# 添加feed源（使用echo追加）
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git fichenx https://github.com/fichenx/openwrt-package' >> feeds.conf.default
echo 'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default

#删除冲突插件
./scripts/feeds update -a && rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/lang/golang/golang
svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang/golang feeds/packages/lang/golang/golang
./scripts/feeds install -a 
make menuconfig

#删除冲突插件
rm -rf feeds/packages/net/luci-app-fchomo
make defconfig


# 解除系统限制
for limit in u n d m s t v; do
  case $limit in
    u) ulimit -u 10000 ;;
    n) ulimit -n 4096 ;;
    *) ulimit -${limit} unlimited ;;
  esac
done

