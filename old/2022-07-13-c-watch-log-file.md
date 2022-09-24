---
layout: post
title: "使用 C watch 不断输出的Log文件"
author: Lu Hui
categories: linux
---

我需要把日志里面新追加行的东西拿C解析，写了这么一段代码:


```
#include <stdio.h>
#include <stdlib.h>

#define CMD "tail -n 0 -f /tmp/event.log"
#define MAXLINE 512

int main(int argc, char *argv[]) {
	FILE *cmd_out = popen(CMD,"r");
	if (cmd_out == NULL)
		return -1;

	char *linebuf = (char *)malloc(MAXLINE);
	if (linebuf == NULL)
		return -1;

	while(fgets(linebuf,MAXLINE,cmd_out) != NULL) {
		fputs(linebuf,stdout);
// 这里写解析行的代码就行
	}

	free(linebuf);

	pclose(cmd_out);
	return 1;
}
```
