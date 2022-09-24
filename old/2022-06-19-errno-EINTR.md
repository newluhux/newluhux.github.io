---
layout: post
title: "errno的EINTR建议的处理方法"
author: Lu Hui
categories: linux
---

在 Unix 中系统调用被打断的处理方法

检测到系统调用被打断后重新执行操作

```

read:
	if (read(fd,buf,bufsize) < 0) {
	   if (errno == EINTR) {
	      goto read;
	   }
	}

```
