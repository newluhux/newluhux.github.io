---
layout: post
title: "Linux下备份到DVD光盘"
author: Lu Hui
categories: cdrom

---

我从2021年开始，一直在使用DVD+R光盘作为我的备份介质。

## 如何最大化利用光盘的空间:

1. 使用刻录的多会话特性，可以理解为 多次追加写入 （使用k3b刻录软件可以支持）
2. 使用UDF的VAT（目前没在Linux上找到支持）

## 查看光盘信息:

1. 使用图形刻录工具 K3b 查看
2. 使用 cdrtools 软件包中的

```
cdrecord -minfo dev=/dev/sr0
```

## 多会话特性 建议的刻录工具

1. k3b

## 多会话特性 不建议的刻录工具

由于DVD+R写入后无法更改，所以任何的失误都可能导致一个光盘报废

1. 直接使用 cdrecord 工具是不建议的，在我多次试验中多会话无法工作:

```
# 我的失败刻录
cdrecord -multi -verbose -eject dev=/dev/sr0 xxx.iso
```

