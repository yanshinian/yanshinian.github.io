---
layout: post
title: "CSS3过渡效果[整理自网络]"
category: Web前端
date: 2016-01-07 12:15
---

一.过渡简介
过渡效果一般是通过一些简单的 CSS 动作触发平滑过渡功能,比如::hover、:focus、:active、:checked 等。CSS3 提供了 transition 属性来实现这个过渡功能,主要属性如 下表:
 
属性 | 说明
--|--
transition-property|指定过渡或动态模拟的 CSS 属性 transition-duration|指定完成过渡所需的时间
transition-timing-function|指定过渡的函数
transition-delay|指定过渡开始出现的延迟时间
transition|简写形式,按照上门四个属性值连写

我们先创建一个没有过渡效果的元素,然后通过:hover 来触发它。在没有任何过渡效 果的触发,会立即生硬的执行触发。

//设置元素样式 

```
div {       width: 200px;       height: 200px;       background-color: white;       border:1px solid green;}
```

//鼠标悬停后背景变黑,文字变白 

```
div:hover {       background-color: black;       color: white;       margin-left: 50px;}
```

二.transition-property

首先,设置过渡的第一个属性就是指定过渡的属性。同样,你需要指定你要过渡某个元素的两套样式用于用户和页面的交互。那么就使用 transition-property 属性,详细属性 值如下表:

属性值 | 说明
--|--
none|没有指定任何样式
all|默认值,指定元素所支持 transition-property 属性 的样式
指定样式|指定支持 transition-property 的样式

从上门的列表中来看,一般来说,none 用于本身有过渡样式从而取消。而 all,则是 支持所有 transition-property 样式,还有一种是指定 transition-property 中的某些 样式。那么 transition-proerty 支持的样式有哪些?如下表所示:

样式名称|样式类型
--|--
background-color |color(颜色)
background-image|only gradients(渐变)
background-position|percentage, length(百分比,长度值)
border-bottom-color|color
border-bottom-width|length
border-color|color
border-left-color|color
border-left-width|length
border-right-color|color
border-right-width|length
border-spacing|length
border-top-color|color
border-top-width|length
border-width|length
bottom|length, percentage
color|colorcrop|rectanglefont-size|length, percentagefont-weight|numbergrid-*|variousheight|length, percentageleft|length, percentageletter-spacing|lengthline-height|number, length, percentagemargin-bottom|lengthmargin-left|lengthmargin-right|lengthmargin-top|length
max-height|length, percentagemax-width|length, percentagemin-height|length, percentagemin-width|length, percentage
opacity|number
outline-color|color
outline-offset|integer
outline-width|length
padding-bottom|length
padding-left|length
padding-right|length
padding-top|length
right|length, percentage
text-indent|length, percentage
text-shadow|shadow
top|length, percentage
vertical-align|keywords, length, percentage
visibility|visibility
width|length, percentage
word-spacing|length, percentage
z-index|integer
zoom|number

//设置背景和文字颜色采用过渡效果		
```		transition-property: background-color, color, margin-left;
```

三.transition-duration 

如果单纯设置过渡的样式,还不能够立刻实现效果。必须加上过渡所需的时间,因为默认情况下过渡时间为 0。
//设置过渡时间为 1 秒钟,如果是半秒钟可以设置为.5s 

```transition-duration: 1s;
```
四.transition-timing-function 

当过渡效果运行时,比如产生缓动效果。默认情况下的缓动是:元素样式从初始状态过渡到终止状态时速度由快到慢,逐渐变慢,即 ease。也是默认值,其他几种缓动方式如下 表所示:
属性值 | 说明
--|--ease|默认值,元素样式从初始状态过渡到终止状态时速度由 快到慢,逐渐变慢。等同于贝塞尔曲线(0.25, 0.1, 0.25, 1.0)
linear|元素样式从初始状态过渡到终止状态速度是恒速。等同 于贝塞尔曲线(0.0, 0.0, 1.0, 1.0)ease-in|元素样式从初始状态过渡到终止状态时,速度越来越 快,呈一种加速状态。等同于贝塞尔曲线(0.42, 0, 1.0, 1.0)ease-out|元素样式从初始状态过渡到终止状态时,速度越来越 慢,呈一种减速状态。等同于贝塞尔曲线(0, 0, 0.58, 1.0)
ease-in-out|元素样式从初始状态过渡到终止状态时,先加速,再减 速。等同于贝塞尔曲线(0.42, 0, 0.58, 1.0)//恒定速度 

```transition-timing-function: linear;```以上五种都是设定好的属性值,我们也可以自定义这个缓动。使用 cubic-bezier() 属性值,里面传递四个参数 p0,p1,p2,p3,值在 0~1 之间。
//自定义缓动

```transition-timing-function: cubic-bezier(0.25, 0.67, 0.11, 0.55);
```
至于具体这些数值干什么的,怎么才可以精确得到相关的信息,这个要了解计算机图形 学中的三次贝塞尔曲线的相关知识,类似与 photoshop 中的曲线调色。这里我们忽略。
还有一种不是平滑过渡,是跳跃式过渡,属性值为:steps(n,type)。第一个值是一 个数值,表示跳跃几次。第二个值是 start 或者 end,可选值。表示开始时跳跃,还是结 束时跳跃。

//跳跃 10 次至结束 

```
transition-timing-function: steps(10,end);
```

五.transition-delay 

这个属性可以设置一个过渡延迟效果,就是效果在设置的延迟时间后再执行。使用transition-delay 属性值。如果有多个样式效果,可以设置多个延迟时间,以空格隔开。 
//设置延迟效果

```transition-delay: 0s, 1s, 0s;
```

六.简写和版本
我可以直接使用 transition 来简写,有两种形式的简写。第一种是,每个样式单独声 明;第二种是不去考虑样式,即使用 all 全部声明。

//单独声明

```transition: background-color 1s ease 0s, color 1s ease 0s, margin-left 1s ease 0s;
```
//如果每个样式都是统一的,直接使用 all

```
transition: all 1s ease 0s;
```
为了兼容旧版本,需要加上相应的浏览器前缀,版本信息如下表:

&nbsp;|Opera|Firefox|Chrome|Safari|IE--|-- 支持需带前缀|15 ~ 22|5 ~ 15|4 ~ 25|3.1 ~ 6|无支持不带前缀|23+|16+|26+|6.1+|10.0+

//兼容完整版

```-webkit-transition: all 1s ease 0s; 
-moz-transition: all 1s ease 0s; 
-o-transition: all 1s ease 0s; 
-ms-transition: all 1s ease 0s; 
transition: all 1s ease 0s;
```

参考链接：

* 《Css3制作变形与动画效果》<http://www.jb51.net/article/69974.htm>
* 《李炎恢老师HTML5第一季视频教程》<http://edu.51cto.com/course/course_id-3148.html>


 