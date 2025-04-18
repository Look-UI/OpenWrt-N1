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
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git fichenx https://github.com/fichenx/openwrt-package' >> feeds.conf.default





# 解除系统限制
for limit in u n d m s t v; do
  case $limit in
    u) ulimit -u 10000 ;;
    n) ulimit -n 4096 ;;
    *) ulimit -${limit} unlimited ;;
  esac
done

