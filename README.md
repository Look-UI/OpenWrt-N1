# OpenWrt-N1

利用GitHub Actions云编译，整合了Amlogic平台的盒子OpenWrt固件编译与内核打包方法，一键生成可直接使用的固件。
所有盒子固件均采用同一底包，默认为打包N1盒子的固件，如需打包其他型号盒子参照flippy的打包脚本说明修改.yml流程文件即可。

## 特性

- 🚀 **一键编译**: 使用GitHub Actions自动编译OpenWrt固件
- 📦 **多版本支持**: 支持LEDE、immortalwrt、iStore等多个版本
- 🔧 **内核打包**: 集成flippy内核打包脚本，生成完整固件
- 📱 **N1优化**: 专门针对N1盒子进行优化配置
- 🔄 **自动发布**: 编译完成后自动发布到Releases

## 使用方法

1. Fork本仓库
2. 根据需要修改配置文件
3. 启用GitHub Actions
4. 等待编译完成，下载固件

## 感谢

### 原作者
- [@quanjindeng](https://github.com/quanjindeng) - 本仓库复刻自该作者的Actions_OpenWrt-Amlogic项目

### 开源项目
- [Lean's OpenWrt 源码仓库](https://github.com/coolsnowwolf/lede)
- [immortalwrt's OpenWrt 源码仓库](https://github.com/immortalwrt/immortalwrt)
- [flippy 内核与打包脚本](https://github.com/unifreq/openwrt_packit)
- [ophub 内核打包参数说明](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/README.cn.md#%E4%BD%BF%E7%94%A8-github-actions-%E8%BF%9B%E8%A1%8C%E7%BC%96%E8%AF%91)
- [kenzok8 软件包收集仓库](https://github.com/kenzok8/small-package)
- [p3terx 云编译教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)
- 所有OpenWrt源码贡献者、插件开发者

## License

[MIT](https://github.com/P3TERX/Actions-OpenWrt/blob/main/LICENSE) © [**P3TERX**](https://p3terx.com)
