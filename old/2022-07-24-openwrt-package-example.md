---
layout: post
title: "OpenWrt打包示例"
author: Lu Hui
categories: linux
---

最近要把程序打包到Openwrt。


1. 在 openwrt/package 下面新建包名的文件夹

```
cd openwrt/package
mkdir helloipk
cd hellipk
touch Makefile
mkdir files
mkdir src
cp /path/to/project/* src/ # 复制项目源码
```

2. 创建 Makefile

```
include $(TOPDIR)/rules.mk

PKG_NAME:=helloipk # 包名
PKG_VERSION:=0.1  # 版本
PKG_RELEASE:=$(AUTORELEASE)

# 由于源码在本地src，无需指定URL和HASH
 
include $(INCLUDE_DIR)/package.mk

define Package/helloipk # 在menuconfig里面的显示
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Hello Packger
  DEPENDS:=+libncurses # 依赖的库
endef

define Package/helloipk/description
  Hello World # 详细的介绍
endef

# 把源码复制到 PKG_BUILD_DIR
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

# Openwrt的框架会自己调用make来compile
# 也可以自己指定

# 安装
define Package/helloipk/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hello $(1)/usr/bin/ # 把编译出的hello安装

	$(CP) ./files/* $(1)/ # 把files下的配置文件安装
endef

$(eval $(call BuildPackage,helloipk))

```

3. 测试

```
make menuconfig # 进入Utils选中helloipk
make download world
```

4. 单个包测试

```
make package/helloipk/compile
```



# 参考

https://openwrt.org/docs/guide-developer/toolchain/single.package

https://openwrt.org/docs/guide-developer/packages
