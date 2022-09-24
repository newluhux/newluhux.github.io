---
layout: post
title: "为何调试器中[vvar]区域无法被读"
author: Lu Hui
categories: linux
---

最近写了一个进程内存dump程序

使用ptrace实现，但是发现

```
7ffee3f6c000-7ffee3f70000 r--p 0 0:0                          [vvar]
```

无法被dump出来

# 外部资料

以下是一些解释:

https://lists.archive.carbon60.com/linux/kernel/2127010

https://lwn.net/Articles/615809/

https://stackoverflow.com/questions/42730260/unable-to-access-contents-of-a-vvar-memory-region-in-gdb
