---
layout: post
title: "ffmpeg一些用法"
author: Lu Hui
categories: video
---

最近项目要在mt7628上搞视频

记录一下ffmpeg的用法

# 直接把视频流推流到rtsp服务器

```
ffmpeg -f v4l2 -i /dev/video0 -input_format h264 -c:v copy -f rtsp rtsp://xxx:xxx/hello
```

加上-c:v copy 是因为板子性能没办法支撑软解码，所以直接转发视频流

# 录制分段

```
ffmpeg -f v4l2 -i /dev/video0 -input_format h264 -c:v copy -f segment -segment_time 900 -reset_timestamps 1 -strftime 1 ./%Y-%m-%d_%H-%M-%S.mp4
```   

按照900秒一个文件把文件自动分割

文件名为日期加时间.mp4

# 一个输入流多个输出流

```
ffmpeg -f v4l2 -i /dev/video0 -input_format h264 -c:v copy -f segment -segment_time 900 -reset_timestamps 1 -strftime 1 ./%Y-%m-%d_%H-%M-%S.mp4 -f rtsp rtsp://xxxx:xxx/hello
```

同时输出到文件和推送到rtsp

# 参考

https://ffmpeg.org/ffmpeg-all.html#Stream-copy
