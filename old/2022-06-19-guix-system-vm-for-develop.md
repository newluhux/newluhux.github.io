---
layout: post
title: "使用guix system vm作为测试环境"
author: Lu Hui
categories: guix
---

最近在写内存相关的代码危险太大，自己安装系统又手懒

所以用guix system vm做了一个测试环境用于测试程序

```
testvm.scm // 系统配置文件
testvm.sh  // 虚拟机构建和启动文件
```

testvm.scm 内容:

```
;; 用于实验危险的程序
(use-modules (gnu))
(use-service-modules base)

(operating-system
 (host-name "tester")
 (timezone "UTC")
 (locale "en_US.utf8")

 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (targets '("/dev/vda"))))
 (file-systems (cons (file-system
                      (device (file-system-label "tester"))
                      (mount-point "/")
                      (type "ext4"))
                     %base-file-systems))

 (users (cons (user-account
               (name "test")
               (comment "Tester")
               (group "users"))
              %base-user-accounts))

 (packages
  (append
   (map
    specification->package
    (list
     "gdb" "strace" "gcc-toolchain")) ; 这里写虚拟机需要的包
   %base-packages))

 (services %base-services))
```

testvm.sh 内容

```
#!/bin/sh

POS=$(dirname $(realpath $0))

guix system vm $POS/testvm.scm --no-graphic --expose=$POS/=/src > $POS/vmstart.sh

sh $POS/vmstart.sh
```

# 使用

在testvm.scm中写好环境后执行:

```
sh testvm.sh
```

来启动一个虚拟机环境

只读共享脚本所在目录到虚拟机的 /src 目录

虚拟机root账户默认无密码，可以直接空密码登录进去操作

这样就省得在真机试验把系统搞炸了
