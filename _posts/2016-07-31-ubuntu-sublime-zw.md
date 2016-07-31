---
layout: post
title: "ubuntu16.04LTS下sublime解决不能输入中文问题"
category: ubuntu
date: 2016-07-31 00:45
---

>环境ubuntu16.04LTS ，Sublime Text 3

##百度经验，靠谱

根据《Ubuntu下Sublime Text 3解决无法输入中文的方法》安装。然而遇到了下面的这个问题。

##解决libgtk2.0-dev的安装

当我用apt-get安装的时候，出现如下错误

```
没有可用的软件包 libgtk2.0-dev,但是它被其它的软件包引用了。 这可能意味着这个
```
更换源

更换成aliyun的源了。

##继续按照百度经验

一步一步，然后就ok了（配置文件修改完记得重启sublime）!

参考资料：

* 《Ubuntu上安装gtk2.0不能安装的问题，“下列的软件包有不能满足的依赖关系”》<http://www.cnblogs.com/zeze/p/linux1.html>
* 《Ubuntu 16.04 LTS国内快速更新源》<http://www.linuxidc.com/Linux/2016-06/132518.htm>
* 《Ubuntu下Sublime Text 3解决无法输入中文的方法》<http://jingyan.baidu.com/article/f3ad7d0ff8731609c3345b3b.html>
