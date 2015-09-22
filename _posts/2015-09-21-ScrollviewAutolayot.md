---
layout: post
title:  "Scrollview的Autolayout"
category: Autolayout
date:   2015-09-21
---

关于自动布局，如果你有什么牛逼的奇技淫巧可以告诉我，我们互相学习吧！

<!--###简单的scrollview布局--注册页面 -->




### Scrollview的IB分页，

为了录制的gif不太占用空间，我提前加了控件

1.添加一个ScrollView控件，并且设置上下左右都为 0。

2.IB操作面板，设置分页。

3.拖两个tableview放到这个scrollview上面，作为两个子控件。然后一个灰色背景，一个蓝色背景。

4.开始录制gif。布局两个 tableview。看下图：

![](/images/ScrollviewAutolayout/scrollviewautolayout.gif)

参考链接：

* AutoLayout深入浅出三[相遇Scrollview] <https://grayluo.github.io/WeiFocusIo/autolayout/2015/01/27/autolayout3/>（这个哥们讲了一些scrollview以及其子view的关系，我其实没有这么透彻，所以，大家看他的，其实我也不知道对不对，我还没有认真看）
* UIScrollView+AutoLayout分页滚动无需代码的DEMO <http://weijun.me/post/develop/2015-07-18> (这篇文章，用了一个view作为contentview，我觉得浪费了)
* UIScrollView and Autolayout - Xcode 6<https://www.youtube.com/watch?v=UnQsFlMGDsI>


 















