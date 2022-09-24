---
layout: post
title: "GPHOTO2 工具中的一些坑"
author: Lu Hui
categories: misc
---

最近需要用PTP协议(Picture Transfer Protocol)来控制相机，发现gphoto2这个工具的一些坑:


## 程序出错不会返回错误的返回值

gphoto2的一些操作出错后并不会设置错误的返回值。

保险做法是给输出过滤检测一下

```
#define MAXLINE 4096
static int cmdout_detect_str(char *cmd,char *pattern) {
	FILE *proc = popen(shcmd,"r");
	if (proc == NULL)
		return -1;
	char line[MAXLINE];

	int count = 0;
	while (fgets(line,MAXLINE,proc) != NULL) {
		if (strstr(line,pattern) != 0) {
			count++;
		}
	}
	pclose(proc);
	return count;
}

#define CMD "gphoto2 --capture-image |& tee" // stdout 和 stderr 都得检测
int main(void) {
	int ret_val = shcmd_detect_str(CMD,"Err");
	if (ret_val == -1 || ret_val > )
		fprintf(stderr,"failed!\n");
	return 0;
}
```

## 拍照之后的返回文件名并不是正确的

使用 

```
gphoto2 --capture-image
```

拍照的话会输出返回一个错误的文件名，这个通常是错误的，访问相机里面的这个文件的话会不存在

已知 佳能相机 有这个问题

## 列出相机存储内的文件列表不是正确的

```
$ gphto2 --list-files

...
#49    Screenshot_2022-07-08-18-57-41-291_com.tencent.mm.jpgrd   277 KB image/jpeg 1657277861
#50    Screenshot_2022-07-08-19-40-50-768_com.tencent.mm.jpgrd   275 KB image/jpeg 1657280450
#51    Screenshot_2022-07-09-08-37-22-650_com.tencent.mm.jpgrd   274 KB image/jpeg 1657327042
#52    Screenshot_2022-07-09-08-37-56-591_com.tencent.mm.jpgrd   243 KB image/jpeg 1657327076
#53    Screenshot_2022-07-11-19-06-24-555_com.autonavi.minimap.jpgrd   230 KB image/jpeg 1657537584
#54    Screenshot_2022-07-11-19-06-29-351_com.autonavi.minimap.jpgrd   212 KB image/jpeg 1657537589
#55    Screenshot_2022-07-12-07-27-45-396_com.xunmeng.pinduoduo.jpgrd   344 KB image/jpeg 1657582065
...

```


已知 佳能相机 安卓手机 有这个问题

肉眼存在的问题
1. 文件名和 rd （不知道这个是个啥） 连在一起了
2. 有的文件名显示不全

输出这么一坨，你觉得它是正确的吗?


## 拍照后下载的文件大小为 zero

```
$ gphoto2 --capture-image-and-download
$ ls -l capt0000.jpg
-rw-r--r-- 1 luhux users 0 Jul 12 20:39 capt0000.jpg
```


已知 佳能相机 有这个问题


## 希望对你避坑有用
