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

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify some code adaptation
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' feeds/luci/applications/luci-app-cpufreq/Makefile

# Add autocore support for armvirt
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# 修复日期替换（方案2：动态日期 + 安全分隔符）
sed -i "s|OpenWrt |LEDE Build $(TZ=UTC-8 date '+%Y.%m.%d') @ OpenWrt |g" package/lean/default-settings/files/zzz-default-settings

# 修复软件源URL替换
sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn/openwrt#g' package/lean/default-settings/files/zzz-default-settings

# 拉取 argon 源码
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/small-package/luci-app-argon*
rm -rf package/small-package/luci-theme-argon*
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config   
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.10/g' package/base-files/files/bin/config_generate

# Modify system hostname（FROM OpenWrt CHANGE TO OpenWrt-N1）
sed -i 's/LEDE/OpenWrt-N1/g' package/base-files/files/bin/config_generate

# Replace the default software source
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

# 修复部分插件自启动脚本丢失可执行权限问题
sed -i '/exit 0/i\chmod +x /etc/init.d/*' package/lean/default-settings/files/zzz-default-settings

# 修改概览里时间显示为中文数字(F大打包工具会替换)
sed -i 's/os.date()/os.date("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/arm/index.htm

# 修改主题多余版本信息
sed -i 's/<a class="luci-link" href="https://github.com/openwrt/luci"/<a/g' feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i 's/<a href="https://github.com/jerrykuku/luci-theme-argon" target="_blank">/<a>/g' feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i 's/<a href=\"https:\/\/github.com\/coolsnowwolf\/luci\">/<a>/g' feeds/luci/themes/luci-theme-bootstrap/luasrc/view/themes/bootstrap/footer.htm

# coremark跑分定时清除
sed -i '/\* \* \* \/etc\/coremark.sh/d' feeds/packages/utils/coremark/*

# 在线用户
git clone --depth=1 https://github.com/danchexiaoyang/luci-app-onliner.git package/luci-app-onliner

## DDNSGO
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

# 通知插件
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan

# Add luci-app-amlogic 晶晨宝盒
rm -rf package/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
sed -i 's#ARMv8#openwrt_armvirt_v8#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i 's#opt/kernel#kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic

# Add luci-app-adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# 添加 smartdns
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

####     调整     ####
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/small/luci-app-passwall/luasrc`
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/small/luci-app-ssr-plus/luasrc`


# 调整部分插件到nas菜单
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aria2/root/usr/share/luci/menu.d/luci-app-aria2.json

#luci-app-nps（修改nps服务器允许域名）
sed -i 's/^server.datatype = "ipaddr"/--server.datatype = "ipaddr"/g' feeds/luci/applications/luci-app-nps/luasrc/model/cbi/nps.lua
sed -i 's/Must an IPv4 address/IPv4 address or domain name/g' feeds/luci/applications/luci-app-nps/luasrc/model/cbi/nps.lua
sed -i 's/Must an IPv4 address/IPv4 address or domain name/g' feeds/luci/applications/luci-app-nps/po/zh-cn/nps.po
sed -i 's/必须是 IPv4 地址/IPv4 地址或域名/g' feeds/luci/applications/luci-app-nps/po/zh-cn/nps.po

#luci-app-frpc
sed -i 's/"services"/"vpn"/g'  feeds/luci/applications/luci-app-frpc/luasrc/controller/frp.lua
sed -i 's/"services"/"vpn"/g'  feeds/luci/applications/luci-app-frpc/luasrc/model/cbi/frp/basic.lua
sed -i 's/"services"/"vpn"/g'  feeds/luci/applications/luci-app-frpc/luasrc/model/cbi/frp/config.lua
sed -i 's/\[services\]/\[vpn\]/g'  feeds/luci/applications/luci-app-frpc/luasrc/view/frp/frp_status.htm

# Alist
git clone https://github.com/sbwml/luci-app-alist package/alist



# 修改插件名字
sed -i 's/"管理权"/"管理"/g' `grep "管理权" -rl ./`
sed -i 's/"软件包"/"软件"/g' `grep "软件包" -rl ./`
sed -i 's/"Argon 主题设置"/"主题设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"AdGuard Home"/"AdGuard"/g' `grep "AdGuard Home" -rl ./`
sed -i 's/"网络"/"网络配置"/g' `grep "网络" -rl ./`
sed -i 's/"重启"/"重启设备"/g' `grep "重启" -rl ./`
sed -i 's/"Aria2 配置"/"Aria2"/g' `grep "Aria2 配置" -rl ./`
sed -i 's/"实时流量监测"/"流量"/g' `grep "实时流量监测" -rl ./`
sed -i 's/"Alist 文件列表"/"Alist"/g' `grep "Alist 文件列表" -rl ./`
sed -i 's/"挂载点"/"磁盘挂载"/g' `grep "挂载点" -rl ./`
sed -i 's/"Npc"/"Nps内网穿透"/g' `grep "Npc" -rl ./`
sed -i 's/"Frp 内网穿透"/"Frp内网穿透"/g' `grep "Frp 内网穿透" -rl ./`
sed -i 's/"FTP 服务器"/"FTP服务器"/g' `grep "FTP 服务器" -rl ./`
sed -i 's/"TTYD 终端"/"终端"/g' `grep "TTYD 终端" -rl ./`
sed -i 's/"NPS 内网穿透客户端"/"NPS内网穿透"/g' `grep "NPS 内网穿透客户端" -rl ./`
sed -i 's/"ShadowSocksR Plus+"/"SSR Plus+"/g' `grep "ShadowSocksR Plus+" -rl ./`

