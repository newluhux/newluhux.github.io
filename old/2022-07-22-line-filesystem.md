---
layout: post
title: "造了个玩具文件系统 linefs"
author: Lu Hui
categories: linux
---

喜欢Plan9的file system server概念，所以最近在学FUSE

造了个玩具文件系统:

目的是把文本文件的每一行抽象成一个文件

https://github.com/newluhux/linefs

## 参考

https://github.com/libfuse/libfuse/blob/master/example/hello.c