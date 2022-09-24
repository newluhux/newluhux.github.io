---
layout: post
title: "使用CGI下载文件"
author: Lu Hui
categories: c
---

最近工作需要拿C写CGI做API

需要写一个 "http://xxx/download/xxx" 的接口来下载需要的文件

示例代码:

```
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

#define FILENAME "/bin/sh"

int main(void) {
        FILE *fp = NULL;
        fp = fopen(FILENAME,"r");

        struct stat sb;
        stat(FILENAME,&sb);

        printf("Content-Type: application/octet-stream\r\n");
        printf("Content-Length: %ld\r\n",sb.st_size);
        printf("\r\n");

        unsigned char *buf = (unsigned char *)malloc(sb.st_size);

        fread(buf,sb.st_size,1,fp);
        fwrite(buf,sb.st_size,1,stdout);

        exit(EXIT_SUCCESS);
}
```


## 参考文献

https://www.oreilly.com/openbook/cgi/ch03_04.html

https://www.iana.org/assignments/media-types/application/octet-stream


