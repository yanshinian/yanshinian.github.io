---
layout: post
title: "iOS app 打包测试流程"
description: iOS app 打包测试
date: 2015-05-28 17:15:48
category: 开发规范
---

##生成所需证书

![](/images/packagetest/dbzs01.png)

------

![](/images/packagetest/dbzs02.png)

-----

![](/images/packagetest/dbzs03.png)

-----

![](/images/packagetest/dbzs04.png)

-----

##生成所需描述文件

![](/images/packagetest/adhocmswj00.png)

----

![](/images/packagetest/adhocmswj01.png)

----

![](/images/packagetest/adhocmswj02.png)

----

![](/images/packagetest/adhocmswj03.png)

-----

![](/images/packagetest/adhocmswj04.png)

----

![](/images/packagetest/adhocmswj05.png)

----

##安装证书，描述文件


![](/images/packagetest/azzs01.png)

----

![](/images/packagetest/azzs02.png)

----

###双击就可以了Xode帮你运行了

![](/images/packagetest/azzs03.png)

----

##Archive打包

![](/images/packagetest/archive00.png)

----

![](/images/packagetest/archive01.png)

----

![](/images/packagetest/archive02.png)

----

![](/images/packagetest/archive03.png)

----

![](/images/packagetest/archive04.png)

----

![](/images/packagetest/archive05.png)

----
![](/images/packagetest/archive06.png)

----

##安装打包好的.ipa文件

###iTools安装

* 链接设备
* 打开iTools
* 点选“应用”
* 点选“安装”
* 选择目标安装文件（.ipa文件），等待安装进度

![](/images/packagetest/azipa01.png)

----

###蒲公英（小`推荐`下）

移动应用内测平台，如何使用看![官网](http://www.pgyer.com/)

快速测试应用程序, 极大简化了应用内测过程。通过遍布全国超过500家的CDN加速节点，提供飞一般的上传下载速度！


参考资料：

* xcode APP 打包以及提交apple审核详细流程(新版本更新提交审核) [http://blog.csdn.net/mad1989/article/details/8167529](http://blog.csdn.net/mad1989/article/details/8167529)

* ipa怎么安装到iPad ipa文件怎么打开
[http://jingyan.baidu.com/album/14bd256e320a00bb6d261235.html?picindex=1](http://jingyan.baidu.com/album/14bd256e320a00bb6d261235.html?picindex=1)

*使用蒲公英来做iOS测试应用的分发[http://www.devtang.com/blog/2015/01/22/pgy-usage-guide/](http://www.devtang.com/blog/2015/01/22/pgy-usage-guide/)


