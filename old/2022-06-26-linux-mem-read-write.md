---
layout: post
title: "Linux下读写进程内存的几种方式"
author: Lu Hui
categories: linux
---

最近在写读写进程内存相关的代码

收集了一些代码和资料




# 内存读写接口



虚拟内存地址转换为物理地址:

从 /proc/pid/maps 获取虚拟内存地址然后读取 /proc/pid/pagemap 进行解析

参考:

https://www.kernel.org/doc/html/latest/admin-guide/mm/pagemap.html

https://github.com/dwks/pagemap







读写虚拟内存地址:

调用 process_vm_read/write 方式

参考:

https://man7.org/linux/man-pages/man2/process_vm_readv.2.html


参考:

读写 /proc/pid/mem 方式

https://github.com/Gelberdaniel19/memory-tools/blob/master/ptrace.c









读写物理内存地址:

读写 /dev/mem 方式

参考:

https://git.busybox.net/busybox/tree/miscutils/devmem.c

http://sources.buildroot.net/devmem2.c?spm=a2c6h.12873639.article-detail.4.7db953136kaQcT&file=devmem2.c












# 需要注意

### 读写最小操作单位

由于系统API限制是 1 个 byte 即 8 个 bit

### 读取/写入缓存区大小

可以每次读写一个页，页大小使用:

```
sysconf(_SC_PAGE_SIZE);
```

来获取

