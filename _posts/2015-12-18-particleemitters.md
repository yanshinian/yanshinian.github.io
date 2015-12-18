---
layout: post
title: "iOS_Animations_by_Tutorials 第十七章 粒子发射器[简译]"
date: 2015-12-18 
category: iOS动画
---

> 这本书有两个版本1.2跟2.0，本文根据1.2翻译。2.0还没看呢！翻译能力欠佳！请谅解！

在屏幕上模拟让我们惊讶的爆炸的火焰，暴雨以及烟雾效果。这章你将学习使用粒子发射器制作自己的特效。

瀑布，火，烟雾和雨水的效果涉及大量的视觉元素——粒子，这是它们的共性，但是它们分别有自己的大小，方向，旋转还有轨迹。

粒子有随机性，不可预见性创造这种现实效果很好。例如：雷雨中每一个雨滴可能有一个独特的尺寸，形状和速度。

你可以使用粒子发射器实现这些效果：

![](/images/particleEmitters/particle01.png)

你重新回顾下之前的`第四章`的项目——巴哈马航班信息的雪花效果。本章你通过不同的实践学习粒子系统的工作原理并观察它们的动画效果。粒子发射器的雪花效果如下：

![](/images/particleEmitters/particle02.png)

### 创建发射层

用`CAEmitterLayer`类创建粒子效果。

> 注：有一些第三方类可以创建粒子效果，但它们通常是针对游戏框架的。我们的程序用`CAEmitterLayer`就可以了，因为简单易用。

运行你的项目我们从这个界面开始：

![](/images/particleEmitters/particle03.png)

伦敦到巴黎的航班天气阴沉。在这个版本的屏幕上飞行信息没有改动，你可以专注的做你的雪花效果了。



创建一个新的`CAEmitterLayer`，设置该layer的frame充满屏幕并且在顶层。打开`ViewController.swift`，把下面的代码添加到`viewDidLoad()`中（这章所有的代码都是在`viewDidLoad()`中，所以，下面我就不翻译了）：

```
let rect = CGRect(x: 0.0, y: 100.0, width: view.bounds.width, height: 50.0)let emitter = CAEmitterLayer() emitter.frame = rect view.layer.addSublayer(emitter)
``` 
设置粒子效果的发射类型

```
emitter.emitterShape = kCAEmitterLayerRectangle
```
您的发射器的形状通常会影响其中正在创建新粒子的面积，但它也可以影响其中要创建三维样粒子的系统的情况下它们的z位置。

下面有三个最简单的发射器的外观:

点状（Point Shape）

kCAEmitterLayerPoint：所有的粒子在同一点创建：发射的位置。做烟花或者火花这是很好的选择。

![](/images/particleEmitters/particle04.png)


例如：你可以通过在同一点上创建所有粒子来创建火花效果，让让它们在不同方向飞，然后消失。

线形（Line Shape）

kcaemitterlayerline：在一个frame中创建发射粒子。

![](/images/particleEmitters/particle05.png)

这种发射形状可以做瀑布；水粒子从上到下阶段性的下落。

矩形（Rectangle shape）

kCAEmitterLayerRectangle：在一个矩形框里面随机创建。

![](/images/particleEmitters/particle06.png)

这种发射器形状可以创建很多不错的效果，像什么碳酸饮料里面的气泡和爆米花。

雪花效果。是从天空中随机出现，所以矩形是一个很好的选择。

> 注： 还有些粒子形状例如：长方体，圆，球体。详细了解苹果文档`CAEmitterLayer`类。

####添加一个发射器的frmame

```
emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)emitter.emitterSize = rect.size
```

结合形状位置尺寸属性，定义发射器的frame。设置发射器的位置，设置发射器大小与layer的大小相等。

发射器的范围占据了整个layer：

![](/images/particleEmitters/particle07.png)


####创建一个发射器Cell（emitter cell）

发射器cell是用来表示粒子源的数据模型。它是一个跟CAEmitterLayer分开的类，因为emitter layer可以包含一个cell或者多个cell。

例如：爆米花的动画里不同的cell呈现出不同的爆米花芯的样子——完全爆开，爆开一半或者没有爆开。

![](/images/particleEmitters/particle08.png)

在本章你会使用一个`emitter cell`，你将有机会实现在挑战部分使用多个`cell`工作。


添加如下代码到`viewDidLoad()`底部：

```
let emitterCell = CAEmitterCell()emitterCell.contents = UIImage(named: "flake.png")!.CGImage
```
在上面代码中，创建了一个cell设置一张图片——flake.png。内容属性包含了新粒子被创建的模板。

下面是发大后的在深色背景下的flake.png截图：

![](/images/particleEmitters/particle09.png)

你的发射器将创建很多不同的仿真的雪花副本。

```
emitterCell.birthRate = 20 
emitterCell.lifetime = 3.5
emitter.emitterCells = [emitterCell]
```

上面的代码表示你的cell每秒钟创建20个雪花并在屏幕上保持3.5秒。意思是在给定的时间会有70个雪花，除了前几秒中比较早的粒子开始消失的。

最后，你设置emitterCells的属性值为emitterCell的数组。记住，你可以有多个emitter celll，但是你开始有一个这样的数组作为单一的值。一旦你设置emmitter cell的列表，发射器将开始创建粒子

构建并运行你的app。查看你的山寨雪花特效：

![](/images/particleEmitters/particle10.png)

3.5秒后消失多个flake.png 副本。然而，雪是奇怪的静态的没有飘落到任何地方。 你可以把这个这个画面变成一个真真切切的雪景么？

接下来，我们花时间研究下`CAEmitterCell`的一些属性：

####控制粒子

在这一章，雪粒子出现，在太空中漂浮几秒钟，然后消失。一个粒子寿命为3.5秒让人感觉无聊。你的下个任务是给这些漫无目的的粒子在它们生命周期内指明方向。

#####改变粒子的方向

在Y方向添加一个速度让粒子像雪一样漂移坠落。

```
emitterCell.yAcceleration = 70.0
```

运行看下效果：

![](/images/particleEmitters/particle11.png)

虽然看起来有点像雪，但是雪很少掉下来。要解决此问题，请添加横向加速：

```
emitterCell.xAcceleration = 10.0
```

运行之后，发现雪花朝着对角的方向运动：

![](/images/particleEmitters/particle12.png)

创建一个柔缓的下降效果，让粒子直线上升，设置yAcceleration让它们下来。

```
emitterCell.velocity = 20.0 
emitterCell.emissionLongitude = CGFloat(-M_PI_2)
```
发射的初始角度跟粒子的初始速度像下面这样：

![](/images/particleEmitters/particle13.png)

运行看结果：

![](/images/particleEmitters/particle14.png)


每次变化你的动画看起来好了很多。但是，这些粒子看起来像雪花大小般僵硬的机器。因为每个雪花它们的初始角度相同，速度以及加速度也相同。你需要给粒子增加一些随机效果。

##### 给粒子添加随意性

```
emitterCell.velocityRange = 200.0
```

上面的代码告诉我们发射器的值应该是随机范围的。由于粒子动画的随机范围经常使用，这点值得花时间解释它们如何工作的。

所有的粒子都具有相同的初速度为20；添加一个速度的范围为下面每个粒子分配一个随机的速度：

![](/images/particleEmitters/particle15.png)

每个粒子的速度的值所在的随机区间是（20-200）= -180 ~（20 + 200）= 220。初始速度为负值的粒子不会飞，一旦出现在屏幕上，它们就会开始浮动。正速度的粒子先飞起来然后飘落。

运行你的项目，看看变化：

![](/images/particleEmitters/particle16.png)

好吧，随机的效果：一些雪花跳到了屏幕顶了而其他的粒子出现，悬挂了一会儿并掉落。


下一步设置方向随机。

```
emitterCell.emissionRange = CGFloat(M_PI_2)
```

原来，你配置的所有粒子直线上升出现（在一个-π/2角度 ）。上面的代码指明了发射器在(-π/2 - π/2) = 180度跟  (-π/2 + π/2) = 0 度之间，为每个粒子随机选择了一个角度。

![](/images/particleEmitters/particle17.png)

粒子最终会从不同的X轴方向而不是直线上升。

再次运行，看看动画的改变：

![](/images/particleEmitters/particle18.png)

现在，的确是随机的了，虚拟的暴风雪来了。


####改变粒子颜色

CAEmitterLayer 一个方便的特点之一就是设置粒子的颜色的能力。例如：你可以给雪花调成蓝色来替代白色，因为蓝色让人经常联想到雨，水，雪或者冰。

添加下面的代码：

```
emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
```
运行你的项目看你的粒子效果：

![](/images/particleEmitters/particle19.png)

这个变化看起来很有去，但是所有的雪花的雪花都是蓝色。如果你能改变每个雪花的颜色岂不更好？

你可以定义你的粒子颜色是三个不同的范围：红色，绿色还有蓝色。

```
emitterCell.redRange = 0.3 
emitterCell.greenRange = 0.3 
emitterCell.blueRange = 0.3
```

上面代码定义了每个颜色的范围，如下图：

![](/images/particleEmitters/particle20.png)

绿色跟蓝色的组成值随机在0.7到1.3之间。然而，值的上限不能超过1.0，所以有效范围为0.7至1。红色值在1和0.6之间，因为它的“正常”的值是0.9。这些都是狭窄的范围，因此产生的随机颜色是相当的浅。

看看你设置雪花颜色后的结果：

![](/images/particleEmitters/particle21.png)

额，好吧。像是随机的糖果雨。

如果你喜欢，你可以尝试每个颜色的不同范围的

```
emitterCell.redRange = 0.1 
emitterCell.greenRange = 0.1 
emitterCell.blueRange = 0.1
```

运行之后，看到一个更细微的颜色变化：

![](/images/particleEmitters/particle22.png)

随机粒子的外观

即使你自定义过后，雪花看起来是均匀的。那么，我想要每个粒子都有美丽而独特的雪花，就要给每个雪花赋一个随机的大小值。


```
emitterCell.scale = 0.8 
emitterCell.scaleRange = 0.8
```

这里，你将粒子的基础尺寸设置为原始的80%的大小，然后随机分配了一个宽度范围：

![](/images/particleEmitters/particle23.png)


这会产生是原来1.6倍大的轻柔的雪花，直到降落成0尺寸消失。


运行你的项目，看看运动中的雪花尺寸：

![](/images/particleEmitters/particle24.png)

你不仅可以设置你的雪花的初始大小，你也可以修改降落时雪花的大小。就好象是融化在接近地面的温暖的空气中。

```
emitterCell.scaleSpeed = -0.15
```

上面设置了scaleSpeed的值，表示粒子以每秒是原来15%大小的变化而下降。

从视觉上来看，大粒在整个过程会大幅度萎缩，而小粒在生命结束前就完全消失了。不要感觉不好，这是雪花生命轮回！


运行看看它们是如何下落的：

![](/images/particleEmitters/particle25.png)

当它们接近屏幕一半底部的时候，雪花会变小。这是一个整洁的效果，但现在屏幕下半部分比较空荡。我想需要更多的雪花。

找到你设置 emitterCell.birthRate 的地方，替换掉原来的值为150：

```
emitterCell.birthRate = 150
```

运行看看你暴雪壮观：

![](/images/particleEmitters/particle26.png)

每次迭代你的动画变得越来越好，不过它仍然有些单调。你可以通过设置每片雪花的Alpha值为场景添加大量深度。

```
emitterCell.alphaRange = 0.75 
emitterCell.alphaSpeed = -0.15
```


你设置了一个alpha的宽度范围，0.25~1.0的上限值。alphaSpeed工作就是让alpha随着时间变化而变化。

运行你的项目，看看一个简单的alpha动画给你带来的雪花降落的深度效果：

![](/images/particleEmitters/particle27.png)

你已经设置了大部分CAEmitterCell提供的属性了。接下来是关于添加磨光的动画。

#####添加一些抛光的效果

找到之前设置的emissionLongitude，重新设置：

```
emitterCell.emissionLongitude = CGFloat(-M_PI)
```

记住，发射粒子的精度是粒子的起始角度。这种改变会让雪花有种被风吹动的感觉。

下一步修改`rect`的值：

```
let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width, height: 50.0)
```

发射器不再视线中所以用户看不到粒子来自于何处。

最后，我们对雪花的生命周期也进行随机。

```
emitterCell.lifetimeRange = 1.0
```

这将每片雪花的声明周期设置成了2.5~4.5的随机值。构建然后运行看到最后的抛光效果

虽然这章在雪花效果的非常重要的一章，每个概念是完全适用于其他的粒子系统。迄今为止，我们所看到的每一个粒子的实现都以类似的方式工作。你总是有一套功能配置每个粒子，并且发射器的随机系统创造了大量的原始粒子的副本。

如果你通过本章练习，这对于你探索任何粒子都是好的开端。无论是Sprite Kit，Unity或者其他的自定义的粒子发射类。

一旦你了解了粒子系统工作原理，设计和实现粒子效果是莫大的乐趣。为此目的，通过下面的挑战，你可以自定义你的降雪效果。


####挑战1：向发射层添加更多的Cell

这个挑战更自由；你的任务是开发一个添加一个多个cell的发射器。

启动项目中有一些雪花可供选择：flake1.png, flake2.png, flake3.png and flake4.png.

在你发射更多的cell之前，要考虑屏幕上的拥挤效应。发射器每秒产生150朵雪花，会导致一个密集的降雪。你可能想在你的系统中减少发射到每秒50个粒子来保持均匀密度的雪花。

玩转Cell的每个属性：制造一些雪花在盘旋而另一些则快速降落。`flake2.png`的图像是非对称的，通过设置`Cell`的`spin`跟`spinRange`属性（跟旋转有关的属性）制造出粒子被风吹动盘旋的效果。

对于这个挑战没有对与错的解决方案，你可以玩到你满意为止。在本章，我已经涵盖了我喜欢的解决方案，你可以看看你改变的粒子系统：

![](/images/particleEmitters/particle28.png)


扩展阅读：

* CAEmitterLayer（粒子系统）学习笔记（含Demo） 》<http://blog.csdn.net/yongyinmg/article/details/38946311>

* 《CAEmitterLayer和CAEmitterCell 》<http://blog.csdn.net/u012890196/article/details/21246751?utm_source=tuicool&utm_medium=referral>

* 《Swift 2.1: Experimenting with CAEmitterLayer》<http://www.sthoughts.com/2015/11/02/swift-2-1-experimenting-with-caemitterlayer/>

* 《UIKit上でパーティクルエフェクトを表示する》<http://d.hatena.ne.jp/shu223/20130315/1363298992>