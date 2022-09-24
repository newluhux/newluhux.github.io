---
layout: post
title: "优化Go编译出的二进制文件大小"
author: Lu Hui
categories: go
---

最近需要在小存储空间的设备上运行go写的程序

使用 gccgo 编译的binary 加上 strip 和 upx 可以有效减少存储空间占用:

```
$ guix shell gccgo gcc-toolchain upx # 进入安装有gccgo gcc-toolchain upx的环境
env $ go version # 确保使用gccgo
go version go1.16.5 gccgo (GCC) 11.3.0 linux/amd64
env $ go build hello.go # 编译hello.go
env $ ls -lh hello
-rwxr-xr-x 1 luhux users 78K Jul 11 12:22 hello
env $ strip hello # 移除无用符号
env $ ls -lh hello
-rwxr-xr-x 1 luhux users 65K Jul 11 12:22 hello
env $ upx -9 hello # 压缩加壳
                       Ultimate Packer for eXecutables
                          Copyright (C) 1996 - 2020
UPX 3.96        Markus Oberhumer, Laszlo Molnar & John Reiser   Jan 23rd 2020

        File size         Ratio      Format      Name
   --------------------   ------   -----------   -----------
     66072 ->     14152   21.42%   linux/amd64   hello                         

Packed 1 file.
env $ ls -lh hello
-rwxr-xr-x 1 luhux users 14K Jul 11 12:22 hello
env $ ./hello # 执行
HelloWorld
```
