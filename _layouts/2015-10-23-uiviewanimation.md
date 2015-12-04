---
layout: post
title: "View Animations（UIView 动画）"
category: iOS
date: 2015-10-23 12:15
---

```
class func animateWithDuration(duration: NSTimeInterval, animations: () -> Void) 
```
这个方法是立刻执行

```
class func animateKeyframesWithDuration(duration: NSTimeInterval, delay: NSTimeInterval, options: UIViewKeyframeAnimationOptions, animations: () -> Void, completion: ((Bool) -> Void)?)
```

动画的参数是

* duration：动画持续时长
* delay：等待执行时长
* options：执行动画选项掩码
* animations：动画执行闭包
* completion：动画完成后执行的闭包

###动画属性

####Position和Size

* bounds
* frame
* center

####外貌

* backgroundColor
* alpha

####形变

* transform


###动画选项

`UIViewAnimationOptions`枚举选项你可以用不同的方式组合在你的动画中

#### Repeating
* .Repeat：无限循环执行
* .Autoreverse：倒着执行（正着执行后，反着执行）通常配合.Repeat使用

####Animation easing

在现实生活中的事情不只是突然开始或停止移动。汽车或火车的物理对象，直到他们达到目标的速度，慢慢加速，除非他们打一个砖墙，他们慢慢地放慢，直到他们来到一个完整的站在他们的最后目的地。

* .Linear：线性，此选项适用于动画没有加速或减速。也就是匀速呗
* .CurveEaseIn: 动画开始加速
* .CurveEaseOut: 动画结束时减速
* .CurveEaseInOut: 动画开始加速，动画结束时减速

 
为了更好地理解这些选项如何为您的动画添加视觉冲击，您将在项目中尝试一些选项。

参考资料：

《iOS_Animations_by_Tutorials》



