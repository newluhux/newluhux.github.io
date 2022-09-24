---
layout: post
title: "stardict 字典文件格式解析"
author: Lu Hui
categories: c
---

# 简单的Stardict格式解析

实现一个Stardict格式兼容的字典并不难，理解Stardict的格式即可。

## 格式介绍

### idx 文件:

词典的目录文件

```
结构:
+--------------------------------+
|word|offset|size|word|offset....|
+--------------------------------+

word 是一个字符串，以 '\0' 结尾，最大256字节
offset 标识word的数据在.dict文件中的位置
size   word的数据在.dict文件中的大小
```

示例代码:

```
FILE *idx;
char *word = NULL;
int wordlen = 0;
uint32_t temp;
off_t offset = 0;
off_t size = 0;

idx = fopen("filename.idx","r");
getdelim(&word,&wordlen,'\0',idx); //
fread(&temp,1,32/8,idx);
offset += ntohl(temp);
fread(&temp,1,32/8,idx);
size += ntohl(temp);
```


size和offset 都是32位的无符号整型数字(uint32_t)，在文件中使用网络字节序存储，使用时需要用ntohl()函数转换本地字节序。

### dict 文件:

词典的数据文件

```
+--------------------------------+
|data|data|data|data|data|data...|
+--------------------------------+
```

数据文件需要配合 .idx 文件中的字段读取:

例如:

idx文件中一个单词记录为:

```
int dict; // file descripter
char *word = "apple";
off_t offset = 40;
off_t size = 50;
```

在dict文件中就需要:

```
dict=open("filename.dict",O_RDONLY);
void *buf = malloc(size);
seek(dict,offset,SEEK_SET);
read(dict,buf,size);
```

buf中就是这个单词对应的数据。


参考:

https://github.com/huzheng001/stardict-3/blob/master/dict/doc/StarDictFileFormat

