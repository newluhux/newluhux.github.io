---
layout: post
title: "替换云服务器的操作系统"
author: Lu Hui
categories: linux
---

# 带有VNC的云服务器

## 准备alpine-virt的镜像

```
wget https://mirrors.bfsu.edu.cn/alpine/3.16/releases/x86/alpine-virt-3.16.0-x86.iso
```

## 写入镜像到磁盘

```
sync # 保证数据写入磁盘
dd if=alpine-virt-3.16.0-x86.iso conv=sync of=/dev/vda
reboot -f # 强制重启
```

## 登录VNC控制台

进入服务器的Web面板登录VNC控制台

## 登录进alpine-virt的shell

会提示类似:

```
login:
```

的提示符

输入root然后回车登录进去

## 卸载磁盘挂载

```
sync
umount /dev/loop0
umount /dev/vda1
sync
```

## 准备其他操作系统的镜像

这里需要注意一点，请选择可以完全加载到内存里面的安装镜像，比如:

slackware的usb安装器:

```
http://mirrors.163.com/slackware/slackware64-15.0/usb-and-pxe-installers/usbboot.img
```

nixos的minial也有copy-to-ram的选项

## 把镜像写入磁盘

```
dd if=xxx.iso of=/dev/vda
sync
reboot
```

## 完成

没有错误的话就会显示安装镜像的界面了

# 不带有VNC的云服务器

TODO
