---
layout: post
title: "为何/proc/pid/mem不支持mmap"
author: Lu Hui
categories: linux
---

今天突发奇想，想了一下我的内存修改器是不是可以拿 mmap 来替代 pwrite/pread 读写 /proc/pid/mem ，这样的话可以少拷贝一次内存。

所以上网查了一下资料，发现是不能的:

在 Linux 内核源码中 fs/proc/base.c 定义了这么一段指示 /proc/pid/mem 能执行的操作:

```
static const struct file_operations proc_mem_operations = {
	.llseek		= mem_lseek,
	.read		= mem_read,
	.write		= mem_write,
	.open		= mem_open,
	.release	= mem_release,
};
```


外部资料:

https://stackoverflow.com/questions/5216326/mmap-on-proc-pid-mem
