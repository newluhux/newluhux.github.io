---
layout: post
title: "Windows和Cygwin"
author: Lu Hui
categories: windows
---

最近操作系统切换到了Windows，为了补全工作流，研究了一下cygwin

没有使用WSL的原因是机器配置太低了

## Emacs 编辑器

GNU Emacs 官网提供的Windows版本很拉，

所以使用cygwin中的windows来替代，

优点是更接近类Unix的体验。

安装 emacs-w32 和 emacs-common 然后使用 cygwin 的终端敲 emacs-w32 就可以启动了。

Windows的输入法在emacs-w32中没有太大问题。

有一点性能问题，是IO方面的，这是cygwin存在的问题，好在不影响使用。

字体是使用外部Windows字体列表的，所以我给Windows安装了一个Unifont字体。

## C/C++ 开发环境

安装 mingw32/64 的包和make、cmake就可以了。

## IRC

Emacs 里面有实现。

## 远程终端

Telnet/SSH在cygwin中很容易安装

## 串口

这个无能为力，只好下载putty

2022 05 06
