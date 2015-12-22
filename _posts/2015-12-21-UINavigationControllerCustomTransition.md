---
layout: post
title: "iOS_Animations_by_Tutorials 第22章 自定义导航过渡动画[简译]"
category: iOS
date: 2015-12-21 12:15
---
UINavigationController 内置app导航解决方案的少数之一。把一个新的视图控制器压栈或者通过顺滑的动画弹出一个控制器。新的界面从右推开旧的界面伴随着延迟。

![](/images/customnavvctransition/customnavvctransition01.png)

上面的截图显示了iOS是如何把一个新的控制器压到导航栈放到Setting控制器之上的。新的视图从右边滑动过来覆盖了旧的视图同时当旧视图的标题从视图上淡出新的视图标题淡入。

导航器的导航效果出来好些年了。我们可以美化它的过渡方式。你将通过`Logo Reveal`项目工作。本章，你将添加一个自定义的透明视图在其背后隐藏用户看到的内容。

![](/images/customnavvctransition/customnavvctransition02.png)

通过前一章节的学习，你会发现自定义导航控制器过渡跟present控制器的过渡尤其类似。

###介绍 Logo Reveal

启动该项目打开 `Main.storyboard`。你会看到项目是由`Master Detail Application`模板创建的；它的特点是导航器，主控制器，一个datail view controller 像下面这样：

![](/images/customnavvctransition/customnavvctransition03.png)

导航已经连接好了，所以你可以专注定制你的导航控制器。

构建运行那个你的项目；点击屏幕（MasterViewController）上的任何地方展示假期包装清单（DetailViewController）：

![](/images/customnavvctransition/customnavvctransition04.png)

###自定义导航过渡

UIKit允许你通过委托模式在跟present控制器很像的方式下自定义导航过渡。


你会使你的MasterViewController适配UINavigationControllerDelegate协议并且设置你的导航控制器协议。

每一次圧入一个视图控制器到导航栈的时候，导航控制器就会询问这个协议是否用你自定义的transition还是内建的transition，如下所示：

![](/images/customnavvctransition/customnavvctransition05.png)

当你为视图控制器压栈或者弹栈时候，当行控制器访问你的代理为该操作提供一个动画控制器。

如果你在委托方法里面返回nil，导航控制器使用默认的transition。但是如果你返回一个对象，则导航控制器使用这个对象作为自定义的动画控制器。听起来跟前一章很像，不是么？

跟前一章一样动画控制器适配同样的UIViewControllerAnimatedTransitioning协议。一旦你提供了一个动画控制器对象（或animator），导航控制器就会调用下面的方法：

![](/images/customnavvctransition/customnavvctransition06.png)

首先，导航控制器调用` transitionDuration() `获取transition持续时长；然后调用`animateTransition()`，也就是放置transition动画的代码的方法。

###导航控制器代理

在你实现委托方法之前，你需要创建animator类的基本骨架。

创建一个叫`RevealAnimator`的类继承`NSObject`。

让这个类遵循UIViewControllerAnimatedTransitioning协议：

```
class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning { 

}
```

现在你还需要实现两个UIViewControllerAnimatedTransitioning必要的方法。

添加下面的属性到这个类中：

```
let animationDuration = 2.0var operation: UINavigationControllerOperation = .Push
```

你的动画将持续2秒；这对于导航来说有点长，但是它会让你看到动画过程中的细节。操作类型是UINavigationControllerOperation告诉你是否push或者pop控制器。

给这个类添加下面两个UIViewControllerAnimatedTransitioning方法：

```
func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {	return animationDuration }func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
}
```

transitionDuration()只是简单返回动画执行时长，而animateTransition()是自定义动画的方法。你会在`animateTransition() `中完成导航控制器代理的设置。

打开`MasterViewController.swift`。把下面的代码添加到类定义之外，文件的底部：

```
extension MasterViewController: UINavigationControllerDelegate { 
}
```

在一个新的扩展来适配UIViewNavigationControllerDelegate协议；该控制器可以作为导航控制器的代理。

在你调用任何的 segue或push东西到堆栈之上的之前，你需要在视图生命周期的早些阶段设置导航控制器的代理

添加下面代码到`viewDidLoad（）`：

```
navigationController?.delegate = self
```

下一个任务是当询问动画控制器时，创建一个RevealAnimator实例传递给导航控制器。

给`MasterViewController`添加下面属性：

```
let transition = RevealAnimator()
```

这个animator是你push跟pop控制器用的。

现在你有你的animator，将下面的方法添加到类扩展：

```
func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {	transition.operation = operation	return transition 
}
```

这个方法的名字就像个怪胎，不过我们归纳下面的参数：

* navigationController：有助于区分不同的导航控制器之间在事件中你的对象是一个或者多个导航控制器的代理。虽然不太可能，但是仍然要防止这种可能性。
* operation：UINavigationControllerOperation的值 .Push 或者.Pop
* fromVC：当前可见的控制器，通常是导航栈中最后一个控制器。
* toVC：过渡到的控制器

如果你支持不同控制器的不同过渡，你会选择什么的animator对象返回。在你设置animator操作属性表明是push还是pop过渡之后，你总会返回你的RevealAnimator对象。

构建运行你的项目，点击第一个视图控制器，你会看到导航栏动画超过了2秒：

![](/images/customnavvctransition/customnavvctransition07.png)


注意在RevealAnimator中更新导航栏指定的持续时间——然而并没有什么卵用。animator需要过渡控制，但是你没在animateTransition()写任何代码，没有动画的内容发生。

然而，至少表明了导航控制器调用了自定义的transitiong。

###添加自定义的 reveal动画

自定义过渡动画相对简单。你可以在DetailViewController动画一个遮罩层让它看起来像是RW标志的透明部分揭示了底部的视图控制器。

你必须处理一些层跟一些动画任务。

打开`RevealAnimator.swift `添加下面的属性：

```
weak var storedContext: UIViewControllerContextTransitioning?
```

因为你将要为你的过渡创造一些层动画，你需要保存动画的上下文知道动画结束并且代理方法animationDidStop(_:finished:) 执行。在这个点上，你会调用completeTransition()在 animationDidStop() 内部包裹transition。

将下面的代码添加到`animateTransition() `存储上下文以备后用：

```
storedContext = transitionContext
```

> 注意： 在第21章（“Custom Presentation Controller & Device Orientation Animations”.）中，你会发现怎么从上下文和动画的容器视图拿到过渡视图控制器，

现在，添加下面初始的过渡代码到animateTransition():

```
let fromVC = transitionContext.viewControllerForKey( UITransitionContextFromViewControllerKey) as! MasterViewControllerlet toVC = transitionContext.viewControllerForKey( UITransitionContextToViewControllerKey) as! DetailViewControllertransitionContext.containerView()?.addSubview(toVC.view)
```

既然你开始了push过渡的工作，你可以对过渡中的“from”和“to”视图控制器做一些假设。

首先，你获取“from”视图控制器（fromVC）——MasterViewController。你然后在获取toVC——DetailViewController。

最后，你简单的吧toVC.view添加到过渡容器里。这地方度假装箱单在其最终定位在主屏幕上。

现在你将创造出reveal动画。reveal动画是一个对象——在这个案例中RWlogo长到覆盖了屏幕。

这听起来像是大规模的改造工作！添加下面代码到animateTransition():

```
let animation = CABasicAnimation(keyPath: "transform") 
animation.fromValue = NSValue(CATransform3D:CATransform3DIdentity)
animation.toValue = NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0),CATransform3DMakeScale(150.0, 150.0, 1.0) ))
```

这个动画让logo长大了150倍，同时移动了一点。为什么？这个logo是不均匀的形状，你想要的视图控制器在整个RW图像后面。移动一点意味着放大图像的底部将覆盖屏幕快得多。

下面的图片展示了你的缩放动画将如何工作：

![](/images/customnavvctransition/customnavvctransition08.png)


如果你用一个圆形或椭圆形的对称形状，就不会有这个问题，但你的动画也没那么酷炫了。


现在添加下面代码到` animateTransition()`让动画更加细腻；

```
animation.duration = animationDuration 
animation.delegate = selfanimation.fillMode = kCAFillModeForwards 
animation.removedOnCompletion = false 
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
```

首先，设置动画的持续时间以匹配过渡时间。然后设置`animator`作为代理和配置在屏幕上离开动画的动画模型；这避免了故障时的过渡包装由于`RW`logo将被隐藏了。最后，你加上easing，使揭示效果随着时间的推移加速。

你的动画是完整的,但应该应用哪一层?

打开`DetailViewController.swift`看到了`maskLayer`属性；它包含了RWlogo的形状，作为遮罩层使用。

把下面代码添加到viewDidLoad()末尾：
```
maskLayer.position = CGPoint(x: view.layer.bounds.size.width/2, y: view.layer.bounds.size.height/2)view.layer.mask = maskLayer
```

设置maskLayer的位置在视图的层的中心。然后你设置maskLayer作为视图控制器的遮罩层。

因为你需要屏蔽视图控制器的内容，唯一的一次是在push过渡期间，视图控制器过渡完毕后，你可以删除遮罩层

把下面代码添加到viewDidAppear()末尾:

```
view.layer.mask = nil
```

过渡完毕，视图显示出来后移除你的遮罩。

现在你有你的遮罩层设置，再一次打开`RevealAnimator.swift `，把下面的代码追加到`animateTransition()`末尾：

```
toVC.maskLayer.addAnimation(animation, forKey: nil)
```

增加了遮罩层的动画，意味着你可以测试您的当前过渡状态。

构建运行你的项目：

![](/images/customnavvctransition/customnavvctransition09.png)


###照顾粗糙的边缘

你可能注意到，你仍然可以看到被乎放大标志的原始标志。最简单的处理办法是在原始logo上也运行reveal动画；你已经有个动画，所以没必要重用它。这将使原来的logo跟遮罩一起长，跟遮罩的形状匹配一样，


添加代码到animateTransition()：

```
fromVC.logo.addAnimation(animation, forKey: nil)
```

构建运行你的项目，验证原始的logo不是单独的悬挂；

![](/images/customnavvctransition/customnavvctransition10.png)


现在，一个轻微的问题是：第一次push过渡后导航不再工作了么？

你发现动画结束后调用的`completeTransition() `没有代码实现。

RevealAnimator 是reveal动画的代理。因此，你需要重写` animationDidStop(_:finished:) `并在里面完成过渡：

添加下面代码到` RevealAnimator`：

```
override func animationDidStop(anim: CAAnimation, finished flag: Bool) {	if let context = storedContext { 
		context.completeTransition(!context.transitionWasCancelled())		//reset logo	}	storedContext = nil 
}
```

在这里，你检查一下你是否有一个存储转换上下文；如果有，调用completetransition()。这把球回到导航控制器结束在UIKit的一侧的过渡。

在方法的末尾，你只需将过渡上下文引用设置为nil。

由于reveal动画不会在自动完成之后删除，你需要自己做些事情。

用下面的代码代替`//reset`：

```
let fromVC = context.viewControllerForKey( UITransitionContextFromViewControllerKey) as! MasterViewControllerfromVC.logo.removeAllAnimations()
```

应该这样做。构建运行你的项目；将packing list视图控制器push到屏幕上。然后点击`Start`返回到原始视图。下图证明你在调用自定义的过渡有个崩溃：

![](/images/customnavvctransition/customnavvctransition11.png)

你试图拿到“from”视图作为MasterViewController实例——对于push过渡是需要拿到，但对于pop过渡不需要拿到。

打开` RevealAnimator.swift `找到`animateTransition()`。你需要在这里设置一个条件。添加如下代码在该方法第一行（设置storedContext的下面）下面：

```
if operation == .Push {
```

别忘了添加，if结束的那个括号。条件检查是判断是否是Push。这样就照顾到了崩溃的代码。解决了崩溃。

构建运行看看你的push过渡成果，但是你pop过渡还无法工作，因为你没有在animateTransition() 中处理pop的过渡。

你会在挑战部分创建pop过渡的代码。


###挑战：


#### 挑战一：新视图控制器淡入










