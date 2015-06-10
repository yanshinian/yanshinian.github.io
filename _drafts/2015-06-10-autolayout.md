---
layout: post
title: "Auto Layout "
description: 学习iOS的Auto Layout
date: 2015-06-01 09:15:48
category: 效率开发（学习篇）
---
> 题记：本文根据《iOS AutoLayout 开发秘籍》整理，当然也会包括，我看到的其他资料整理。


##一.Auto Layout 介绍


Autolayout（自动布局）可以描述视图与内容相互之间的关系，也可以描述视图及其内容与父视图之间的关系(autoresizing是不能描述兄弟之间的关系)。自定义范围比采用`frame`、`spring`和`strut`所能获得的范围更广。

从处理边界情况（edge case）到创建视图之间的相互关系。Autolayout与苹果公司的许多优秀的应用编程接口（API）兼容，包括动画（Animation）、动画效果（motion effect）和精灵（sprite）。

###1.1 Auto Layout 的由来

2012年在iOS 6中出现。旨在取代原来基于`spring`和`strut`的 Autosizing 系统。

AutoLayout 的前身是`Cassowary`约束解析包。Cassowary围绕一种现象开发：用户界面生来就会出现不等关系和相等关系。

`Cassowary` 提供一种自动解析工具，基于约束系统的布局规则（本质就是`联立线性方程组`）转换成表达那些规则的视图几何特征。它已经一直到了`javaScript`、`.NET/Java`、`Python`、`Smalltalk`、`C++`中，通过`AutoLayout`移至到了`Cocoa`和`Cocoa Touch` 中。

Auto Layout 最终将规则转换成视图框架。

###1.2 Auto Layout 的好处

Auto Layout工作原理：`通过创建屏幕上的对象之间的关系来实现布局`。描述约束指定视图之间的关系；设置一些视图属性描述视图与其内容之间的关系。可以尽享类似如下请求：

* 一个视图的尺寸与另一个视图尺寸匹配，使两个视图始终保持相同的宽度。
* 无论父视图的形状如何改变，都将一个视图(或者一组视图)相对于父视图居中。
* 摆放一行视图时讲几个视图的底部对齐。
* 两个视图偏移一定的距离（例如，在两个视图之间添加标准的`8`点补白空间）。
* 一个视图的底部与另一个视图的顶部绑定，移动一个视图时，两个视图一起移动。
* 防止图像视图在自然大小看不到完整内容时内容时收缩成一点（既不压缩或剪切视图的内容）
* 显示按钮时文本四周不要有太多的补白

####1.21 几何关系







-----


[link](http://)<!---->  



------

###参考资料：











