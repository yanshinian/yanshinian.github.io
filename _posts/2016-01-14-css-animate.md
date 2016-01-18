---
layout: post
title: "CSS3动画效果[整理自网络]"
category: Web前端
date: 2016-01-07 12:15
---
一.动画简介
CSS3 提供了类似 Flash 关键帧控制的动画效果,通过 animation 属性实现。那么之前的 transition 属性只能通过指定属性的初始状态和结束状态来实现动画效果,有一定的 局限性。
animation 实现动画效果主要由两个部分组成: 
1.通过类似 Flash 动画中的关键帧声明一个动画; 
2.在 animation 属性中调用关键帧声明的动画。

CSS3 提供的 animation 是一个复合属性,它包含了很多子属性。如下表所示:

属性值 | 说明
--|--
animation-name|animation-name用来指定一个关键帧动画的名称,这个动画 名必须对应一个@keyframes 规则。CSS 加 载时会应用 animation-name 指定的动画, 从而执行动画。animation-duration|用来设置动画播放所需的时间
animation-timing-function|用来设置动画的播放方式
animation-delay|用来指定动画的延迟时间
animation-iteration-count|用来指定动画播放的循环次数
animation-direction|用来指定动画的播放方向
animation-play-state|用来控制动画的播放状态
animation-fill-mode|用来设置动画的时间外属性
animation|以上的简写形式

除了这 9 个属性之外,动画效果还有一个重要的属性,就是关键帧属性:@keyframes。 它的作用是声明一个动画,然后在 animation 调用关键帧声明的动画。

//基本格式,“name”可自定义

```
 @keyframes name {/*...*/ 
}```
二.属性详解
在讲解动画属性之前,先创建一个基本的样式。//一个 div 元素
```<div>我是 HTML5</div>
```
//设置 CSS 

```div {       width: 200px;       height: 200px;       background-color: white;       border: 1px solid green;}```1.@keyframes
//创建动画的第一步,先声明一个动画关键帧。```
@keyframes myani {       	0% {           background-color: white;           margin-left:0px;		}		50% {           background-color: black;           margin-left:100px;       	}       	100% {           background-color: white;           margin-left:0px;		} }```//或者重复的,可以并列写在一起
```
@keyframes myani {       0%, 100% {           background-color: white;           margin-left:0px;		}		50% {           background-color: black;           margin-left:100px;
		} 
}```2.animation-name
//调用@keyframes 动画
animation-name: myani;属性值 | 说明
--|--none|默认值,没有指定任何动画INDEX|是由@keyframes 指定创建的动画名称3.animation-duration//设置动画播放的时间 
animation-duration: 1s;当然,以上通过关键帧的方式,这里插入了三个关键帧。0%设置了白色和左偏移为 0, 和初始状态一致,表明从这个地方开始动画。50%设置了黑色,左偏移 100px。而 100%则 是最后一个设置,又回到了白色和左偏移为 0。整个动画就一目了然了。
而对于关键帧的用法,大部分用百分比比较容易控制,当然,还有其他一些控制方法。

//从什么状态过渡到什么状态 

```
@keyframes myani {       from {           background-color: white;           margin-left:0px;		}		to {           background-color: black;           margin-left:100px;       }}```
4.animation-timing-function//设置缓动 

```animation-timing-function: ease-in;```属性值 | 说明
--|--ease|默认值,元素样式从初始状态过渡到终止状态时速度由 快到慢,逐渐变慢。等同于贝塞尔曲线(0.25, 0.1, 0.25, 1.0)
linear|元素样式从初始状态过渡到终止状态速度是恒速。等同 于贝塞尔曲线(0.0, 0.0, 1.0, 1.0)
ease-in|元素样式从初始状态过渡到终止状态时,速度越来越 快,呈一种加速状态。等同于贝塞尔曲线(0.42, 0, 1.0, 1.0)
ease-out|元素样式从初始状态过渡到终止状态时,速度越来越 慢,呈一种减速状态。等同于贝塞尔曲线(0, 0, 0.58, 1.0)
ease-in-out|元素样式从初始状态过渡到终止状态时,先加速,再减 速。等同于贝塞尔曲线(0.42, 0, 0.58, 1.0)
cubic-bezier|自定义三次贝塞尔曲线

5.animation-delay
//设置延迟时间 

```animation-delay: 1s;
```

6.animation-iteration-count
//设置循环次数 

```animation-iteration-count: infinite;
```

属性值 | 说明
--|--
次数|默认值为 1
infinite|表示无限次循环

7.animation-direction
//设置缓动方向交替 

```animation-direction: alternate;
```

属性值 | 说明
--|--
normal|默认值,每次播放向前
alternate|一次向前,一次向后,一次向前,一次向后这样交替

8.animation-play-state
//设置停止播放动画 

```animation-play-state: paused;
```

9.animation-fill-mode
//设置结束后不在返回 

```animation-fill-mode: forwards;
```

属性值 | 说明
--|--none|默认值,表示按预期进行和结束
forwards|动画结束后继续应用最后关键帧位置,即不返回
backforwards|动画结束后迅速应用起始关键帧位置,即返回
both|根据情况产生 forwards 或 backforwards 的效果

//both 需要结合,次数和播放方向 

```
animation-iteration-count: 4; 
animation-direction: alternate;
```

六.简写和版本
//简写形式完整版

```animation: myani 1s ease 2 alternate 0s both;
```
为了兼容旧版本,需要加上相应的浏览器前缀,版本信息如下表:

&nbsp;|Opera|Firefox|Chrome|Safari|IE--|-- 支持需带前缀|15 ~ 29|5 ~ 15|4 ~ 42|4~8|无支持不带前缀|无|16+|43+|无|10.0+

//兼容完整版,Opera 在这个属性上加入 webkit,所以没有-o-

```
-webkit-animation: myani 1s ease 2 alternate 0s both; 
-moz-animation: myani 1s ease 2 alternate 0s both; 
-ms-animation: myani 1s ease 2 alternate 0s both; 
transition: all 1s ease 0s;
```

//@keyframes 也需要加上前缀 

```
@-webkit-keyframes myani {...} 

@-moz-keyframes myani {...} 

@-o-keyframes myani {...} 

@-ms-keyframes myani {...} 

keyframes myani {...}
```

参考链接：

* 《李炎恢老师HTML5第一季视频教程》<http://edu.51cto.com/course/course_id-3148.html>







