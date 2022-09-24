---
layout: post
title: "使用mmap重新实现的stardict命令行工具"
author: Lu Hui
categories: linux
---

最近学到了 mmap 代替 read/write ，感觉这种IO方式才是人类应该使用的.

所以我拿 mmap 重写了一个简单的stardict终端词典工具:

https://github.com/newluhux/stardict-mini

视频演示:

<iframe src="//player.bilibili.com/player.html?aid=600380204&bvid=BV1fB4y1p7Zi&cid=760752277&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

https://www.bilibili.com/video/BV1fB4y1p7Zi?share_source=copy_web
