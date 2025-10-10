#!/bin/bash
#
# 修复elfutils编译问题的脚本
# 用于解决package/libs/elfutils编译失败的问题
#

echo "开始修复elfutils编译问题..."

# 禁用有问题的elfutils相关包
echo "CONFIG_PACKAGE_libelfutils=n" >> .config
echo "CONFIG_PACKAGE_elfutils=n" >> .config
echo "CONFIG_PACKAGE_libelfutils-dev=n" >> .config

# 禁用可能依赖elfutils的其他包
echo "CONFIG_PACKAGE_libdw=n" >> .config
echo "CONFIG_PACKAGE_libelf=n" >> .config

# 确保gettext-full使用简化版本
echo "CONFIG_PACKAGE_gettext-full=y" >> .config
echo "CONFIG_PACKAGE_gettext-tools=n" >> .config

echo "elfutils修复配置已添加"
echo "修复完成！"
