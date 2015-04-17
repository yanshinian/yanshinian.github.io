---
layout: post
title:  "AutoLayout 练习"
category: AutoLayout
date:   2015-06-17 
---

> 练习环境 xcode 6.1 与 xcode 6.3，为什么用xcode 6.1而不是 直接用 6.3呢，稍后便知晓
> 
> 制作工具，licecap（录制gif），snip（截图），ImageOptim（压缩图片），XnConvert（制作特效，我也就是添加了一个"我是言十年"水印）

###练习1

* 在控制器view上面添加两个tableView，两等分
* 2个tableView的宽是相等的，高呢也自然相等
* 距离父控件跟兄弟控件距离都是 0

####实际案例： 58同城选择搬家师傅的模块

![image](/images/autolayoutpractice/58.png)

####练习案例：

![image](/images/autolayoutpractice/tabledengfen.gif)


###练习 2

* 跟上面原理类似，不过是一个view中方三个控件左边是1/2父控件，右边两个是1/4父控件，左边子控件跟右边两个子控件面积一样
* 距离父控件，兄弟控件都是 0

####实际案例： 京东首页

![image](/images/autolayoutpractice/jd.png)

####练习案例

![image](/images/autolayoutpractice/jd.gif)