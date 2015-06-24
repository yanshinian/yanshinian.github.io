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

####实际案例： 京东首页（国美首页的cell也有）

![image](/images/autolayoutpractice/jd.png)

####练习案例

![image](/images/autolayoutpractice/jd.gif)

###练习 3

* 四个view均分一个父view，

####两种做法

* 第一种，跟上两个练习一样的做法，放好参照位置，然后，四个view上下左右都是 0，记得最后更新约束哦，然后选中四个view，都等宽等高
* 第二种，就是我要演示的，先布好一个view，这个view呢，上左都是0，然后垂直水平各居中，然后更改垂直跟水平居中的约束关系，实现 1/4view，然后接下来的三个你看看就知道了

####实际案例： 大众点评首页

![image](/images/autolayoutpractice/dzdp.png)

#### 练习案例

![image](/images/autolayoutpractice/dzdp.gif)


### xcode6.1 跟 xcode 6.3 一个小差别

* 其实呀！我不知道 6.2 是不是已经跟 6.1有区别了，我只是安装了这两个 6.0以上的

* 区别看图，6.1是4个钮，6.3变成3个钮，那6.1那第四个钮是干啥的呢？看下一个gif

![image](/images/autolayoutpractice/xcode61.png)

![image](/images/autolayoutpractice/xcode63.png)


想必大家固定一个view已经会了，我就直接固定一个view，免得多录制几秒浪费大家时间

##### descendants

* 勾选，父控件变，子控件的与父控件底部的间距约束不变
* 
* 不勾选，大家看到了，拖动一个角子控件不动一下。

![image](/images/autolayoutpractice/xcode.gif)

##### siblings and ancestors

* 勾选，左边按钮移动宽，右边按钮保持跟左边按钮的间距不变
* 
* 不勾选，拖动左边按钮就直接穿插过去了

![image](/images/autolayoutpractice/xcode6.gif)

