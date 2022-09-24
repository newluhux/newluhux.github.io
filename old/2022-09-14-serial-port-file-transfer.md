---
layout: post
title: "串口的文件传输"
author: Lu Hui
categories: serial
---

最近使用到了串口的文件传输

这些工具也可以在telnet中或者ssh中或者其他远程终端中使用

# kermit 协议

uboot里面会使用到

在Linux应该使用 gkermit 工具配合终端使用

https://github.com/KermitProject/gkermit

Guix中没有这个工具,所以我打包了一下:

https://github.com/newluhux/guix-config/blob/5c90b4ad4e1237fd254d38f95e5452a2b821021c/package/embedded.scm#L8

有时间提交到上游

# x/y/z modem 协议

在Linux应该使用 lrzsz 工具配合终端使用

https://ohse.de/uwe/software/lrzsz.html

Guix中有这个工具
