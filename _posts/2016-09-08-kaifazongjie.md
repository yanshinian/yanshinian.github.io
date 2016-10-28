---
layout: post
title: "近日做项目的一些性能优化点"
category: 开发总结
date: 2016-10-28 00:45
---


##优化点

###iframe 延迟加载

###使用腾讯轻量级框架artTemplate渲染页面

###雅虎压缩工具 yuicompressor 压缩 css，js。并合并

###css中的图片进行base64处理

###七牛cdn添加压缩参数

http://tool.css-js.com/base64.html

###服务器 配置静态资源缓存

###开启GZIP（原线上开启的压缩对js无效，针对js配置的 gzip_types不对）




##目的

服务器方面：减少网卡流量。增加页面的吞吐量。把数据渲染放在前端去做。

前端方面：提高加载速度。


ps.小伙伴做的，我只是总结下。
