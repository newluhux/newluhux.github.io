---
layout: post
title: "用于开发的容器"
author: Lu Hui
categories: linux
---

我在使用一个名为GNU Guix System的Linux发行，好处是可方便重现的环境，

缺点是对强依赖FHS应用的支持不太好，所以琢磨了一下开发用的容器

# 容器

## docker

优点是资源丰富，在Guix System中也是开包即用的

缺点是需要手动处理容器的权限问题和Host的资源共享

## singularity

优点是自动处理容器的权限问题和Host的资源共享

缺点是构建镜像在Guix System中是Borken的

## docker + singularity

所以需要:

```
docker 构建开发环境镜像
         |
         v
docker 导出开发环境到tar
         |
         v
使用 sqfstar 来转换 tar 为 squashfs 镜像
         |
         v
在 singularity shell 中运行 squashfs 镜像
```

# 添加容器服务

需要添加这些服务到系统配置文件的services字段中

```
(service docker-service-type)
(service singularity-service-type)
```

# 一个示例

下面使用一个简单的例子来演示流程

## 创建 Dockerfile

```
FROM alpine:latest

RUN apk update && apk add build-base
```


## 生成镜像

```
docker build -t devimage .
```

## 生成容器

```
docker run -it --name devcontainer devimage /bin/sh
exit
```

## 导出容器为 tar

```
docker export devcontainer -o dev.tar
```

## 转换 tar 为 squashfs

```
sqfstar dev.squashfs < dev.tar
```



## 删除 docker 中的容器和镜像 (可选)

如果磁盘不足则可以删除这些

## 删除导出的 tar 文件 (可选)

实际以后用到的只有 squashfs 镜像，tar是不被需要的

如果磁盘不足则可以删除

## 开始使用容器

```
singularity shell -e dev.squashfs
```


