---
layout: post
title: "使用OpenWRT提供的交叉编译工具链"
author: Lu Hui
categories: linux
---

根据自己需要来替换字符串

需要在环境变量中设置两个环境变量

```
STAGING_DIR=/path/to/openwrt/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/
PATH=$STAGING_DIR/bin:$PATH
export STAGING_DIR PATH
```


然后Makefile:


```
CC = mipsel-openwrt-linux-gcc                                                              
CFLAGS += -I$(STAGING_DIR)/../target-mipsel_24kc_musl/usr/include                          
CFLAGS += --sysroot=$(STAGING_DIR)/../target-mipsel_24kc_musl/
CFLAGS += -L$(STAGING_DIR)/../target-mipsel_24kc_musl/usr/lib
LIBS += -levent -lncurses

hello:
	$(CC) $(CFLAGS) $(LIBS) hello.c -o hello
```


## 参考

https://openwrt.org/docs/guide-developer/toolchain/crosscompile
