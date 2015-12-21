---
layout: post
title: "iOS_Animations_by_Tutorials 第21章 自定义模态控制器&设备旋转动画[简译]"
category: iOS
date: 2015-12-20 12:15
---
 
 
你是否将相机视图控制，地址簿或者你自定义的模态屏幕调用它们都是通过`presentViewController(_: animated:completion:)`展示。`放弃`当前的屏幕到另一个视图控制器。将新的视图滑动覆盖到当前的视图。下图展示了一个`新建联系人`在`联系人列表`中的滑动：

![](/images/custompresent/custompresent01.png)

本章，你将创建自定义的展示控制器动画用来替代默认的，让项目更加有活力。


###通过项目启动


打开这个章节的入门项目，名字叫做`BeginnerCook`。选择`Main.storyboard`开启旅途：

![](/images/custompresent/custompresent02.png)

第一个视图控制器（ViewController）包含引用程序的标题和主要描述以及底部显示可用的草本植物名单的滚动视图。

每当用户点击列表中的图像的时候，主控制器presents出了`HerbDetailsViewController`。这个视图控制器动态显示除了背景，标题，描述还有一些图像拥有者的信用按钮。

`ViewController.swift`和`HerbDetailsViewController.swift`中的代码，足够支持这个基本的程序了。构建运行app看看程序的外观和感觉：

![](/images/custompresent/custompresent03.png)

点击一个草本植物图片，画面开始了标准的形变覆盖。对这个普通的app来说很不错，但你的草本植物应该得到更好的。

你的工作就是在应用程序中添加自定的presentain controller来让它开花。点击草本植物后全屏来替换股票动画。像下面这样：

![](/images/custompresent/custompresent04.png)

###自定义过渡（Custom transition）场景的幕后

自定义你的presentation 控制器通过委托模式；你只是简单的让你的视图控制器（或者其他的类达到这个特定的目的）适配`UIViewControllerTransitioningDelegate`。

每次你present新的控制器，UIKit就会询问这个代理是否使用这个自定义的`过渡`（transition）。下面的这个过渡就像是跳舞：

![](/images/custompresent/custompresent05.png)

UIKit 调用animationControllerForPresentedController(:_ presentingController:sourceController:)；如果这个方法返回nill 那么UIKit使用的是默认的过渡。如果UIKit接受到了一个对象，然后UIKit使用这个对象用组过渡的动画控制器。

在UIKit使用自定义的动画控制器之前有几个步骤：

![](/images/custompresent/custompresent06.png)


UIKit首选询问你动画控制器（简称动animator）过渡的时间，然后调用它的animateTransition() 。上面的调用是在你的自定义动画到了中心阶段。

在 animateTransition()，你可以访问当前的控制器在屏幕上以及被presented新的视图控制器。如果你喜欢你可以fade（渐褪），scale（缩放），rotate（旋转）还有操作现有的视图和新的视图。

现在你已经了解了如何自定义演示控制器原理了，你可以创建属于你自己的自定义控制器了。

###实现过渡的代理（transition delegates）

由于委托的任务是管理动画对象和执行实际的动画的。首先，写代理代码之前你需要创建一个动画的类。我们创建一个名字叫做`PopAnimator`的类继承`NSObject`。

打开` PopAnimator.swift`让 PopAnimator遵循`UIViewControllerAnimatedTransitioning`协议：

```
class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

}
```

因为你没有实现必须的代理方法你会看到Xcode的提示。实现下面代码：

```
func transitionDuration(transitionContext: UIViewControllerContextTransitioning)-> NSTimeInterval {	return 0 
}
```

0值是时间的占位值。稍后你会通过你的工作去用真的值取代。

现在为你的类添加下面的方法：

```
func animateTransition(transitionContext: UIViewControllerContextTransitioning) {}
```

添加了上面的两个方法Xcode的报错就应该清除了。

现在你有了一个基本的动画类，你可以转移到视图控制器里面实现代理方法。

打开` ViewController.swift`并添加下面代码：

```
extension ViewController: UIViewControllerTransitioningDelegate{

}
```
这段代码表示视图控制器遵循了`transitioning` 协议。你会在这里添加一些方法。

在类的主体找到`didTapImageView() `。接近底部的方法你将看到presents详情控制器的代码。`herbDetails `是新控制器的实例；你需要将其transitioning 协议给主控制器。

在调用`presentViewController`方法的最后一行之前添加如下代码：

```
herbDetails.transitioningDelegate = self
```

现在，每次UIKit会询问ViewController作为animator的对象present详情控制器到屏幕上。然而，你还是没有实现任何UIViewControllerTransitioningDelegate的方法，所以UIKit仍然使用默认的过渡。

下一步当请求时，创建动画对象返回给UIKit。

添加给ViewController新的属性：

```
let transition = PopAnimator()
```

这是`PopAnimator`的实例驱动你的动画视图控制器的过渡。你只需要一个`PopAnimator`实例，因为你每次present控制器都用同样的对象用于过渡。

现在，添加第一个协议方法扩展ViewController：

```
func animationControllerForPresentedController( presented: UIViewController!,presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {	return transition
}
```

这个方法需要几个参数，让你决定是否想要返回一个自定义动画。本章，因为你只有一个presentation transition 将总是返回单个实例`PopAnimator`。

你已经添加了一个presenting视图控制器的代理方法，但是你将如何dismissing呢？

添加下面的委托方法处理：

```
func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {	return nil }
```
上面的方法跟前一个方法本质上一样：你检查哪个视图控制器被dismiss，如果返回的是nil使用默认动画，如果返回的是自定义的transition就使用自定义的。现在你返回的是nil，你不打算以后实现这个dismissal动画。

你终于有一个自定义动画来照顾你的自定义transition。但它是否工作？

构建运行你的项目并点击一个草本植物的图片：

![](/images/custompresent/custompresent07.png)
 
什么都没有发生。为啥？你有一个自定义的animator去驱动transition，但是你没有为这个animator添加任何代码！:]

###创建你的transition animator

打开`PopAnimator.swift`；添加代码作为两个控制器见的transition。

首选，给这个类添加下列属性：

```
let duration = 1.0var presenting = truevar originFrame = CGRect.zero
```
你会在几个地方使用时间，比如UIKit过渡要多久还有创建构成动画。

你还定义presenting 去通知 animator是否你present或者dismiss视图控制器。你想保持这个轨道，因为通常情况下，你会运行这个动画正向present和反向dismiss。

最后，你将使用`originFrame`存储用户点击的`原始 frame`，你需要动画从原来的frame到全屏图片，反之亦然。当你获取当前选中的图像，通过动画传递它的frame，留意originFrame。
 
 
 现在你可以继续UIViewControllerAnimatedTransitioning方法。替换transitionDuration() 里面的代码：
 
 ```
 return duration
 ```
 
 重用duration属性让你轻松的尝试trasition动画；你可以简单的修改属性值，让transion慢或者快！
 
 
#### 设置你的transition 上下文
 
 是时候给animateTransition添加一些“魔法”。这个方法有一个UIViewControllerContextTransitioning类型的参数，访问这个参数让你获得trasition的视图控制器。
 
 在你开始使用代码之前，要线了解下动画的上下文实际上是啥东东：
 
 两个视图控制器过渡开始时，现有的视图将添加到一个过渡容器视图和新的视图控制器的视图中，创建过程是不可见的。如下图所示。
 
![](/images/custompresent/custompresent08.png)
 
因此，你的任务是把新的view在animateTransition()里添加到过渡容器上。如果需要旧的视图飞出，新的视图飞入。

默认情况下，当transition动画完成时，旧的视图从transition容器中被移除：

![](./images/custompresent/custompresent09.png)

 
在你实现一个更炫酷更复杂的transition之前。你将创建一个简单的过渡动画，看看它是如何工作的
 
 
#### 添加一个fade transition（渐变过渡）
 
 你将通过一个简单的渐变过渡体验自定义transition的感觉。将下面代码添加到animateTransition()：
 
 ```
let containerView = transitionContext.containerView()!let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
 ``` 
 
首先，你得到了容器视图，动画在容器视图中发生，获取新的view并且存储给toView。

transition上下文对象有个飞出方便的方法，让你访问transition的参与者：

* viewForKey(): 通过`UITransitionContextFromViewKey`或`UITransitionContextToViewKey`访问`旧`或者`新`的视图控制器。
* viewForKey(): 通过`UITransitionContextFromViewControllerKey`或`UITransitionContextToViewControllerKey`分别访问`旧`或者`新`的视图控制器。

 在这一点上，你既有容器视图也有视图被present。下一步，你需要添加一个view被present出来作为子view添加到容器视图中并且以某种动画方式present。
 
把下面代码添加到animateTransition()：


```
containerView.addSubview(toView) 
toView.alpha = 0.0UIView.animateWithDuration(duration, animations: {	toView.alpha = 1.0 }, completion: { _ in	transitionContext.completeTransition(true) })
```

注意你在动画完成的block里调用过渡上下文上的`completeTransition()`；这告诉UIKit你过渡动画完成，UIKIt包裹了视图控制器的过渡。

构建和运行你的项目，点击列表中的草本植物，你会看到在草本概述的渐变显示到了主视图上面。
 
![](/images/custompresent/custompresent10.png)
 
 
####添加一个pop transition（弹出过渡）
 
新的过渡代码略微不同。 将下面的代码替换到`animateTransition()`里面
 
 ```
let containerView = transitionContext.containerView()! 
let toView =transitionContext.viewForKey(UITransitionContextToViewKey)!let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
 ```
containerView是动画执行所在，而toView是present出的新View
 
 如果你 presenting，herbView就是toView；否则将从上下文获取。为了presenting和dismissing，herbView 一直作为被动画的view。

当你present详情控制器的时候，它变成了整个屏幕大小，当它dismiss的时候变回了原来的图像的frame。
 
添加下列代码到animateTransition():
 
 ```
let initialFrame = presenting ? originFrame : herbView.frame let finalFrame = presenting ? herbView.frame : originFramelet xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.widthlet yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
 ```
在上面的代码中，检测到初始的frame和最后的frame，然后计算出在每个view直接动画的需要的应用在每个轴上的缩放因素。

现在你需要小心的定位新的View了，这样它准确的显示到被点击图像的上方；这看起来像是图像的扩展到全屏。

添加下列代码到animateTransition()：

```
let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)if presenting {	herbView.transform = scaleTransform herbView.center = CGPoint(x: CGRectGetMidX(initialFrame),y: CGRectGetMidY(initialFrame)) herbView.clipsToBounds = true}
```

当present新view的时候，你设置了它的scale还有position，所以它正确的匹配到初始的大小跟位置。

添加最后一点代码到animateTransition()：

```
containerView.addSubview(toView) 
containerView.bringSubviewToFront(herbView)UIView.animateWithDuration(duration, delay:0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,options: [],animations: {herbView.transform = self.presenting ?CGAffineTransformIdentity : scaleTransform herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))}, completion:{_ in
	transitionContext.completeTransition(true) 
})
```

先添加toView到containerView上面。接着，你需要确保herbView置顶因为它是唯一的动画的view。记住当dismissing时候，toView是原来的view，在第一行，你会添加它到顶部并且你的动画将被隐藏起来，除非把herbView置顶。
 
然后，你可以用一个弹簧动画揭开这个动画的序幕，这会让它有点弹力。

在动画表达式中，你改变了herbView的transtion和position。当presenting的时候，你将从底部的小尺寸变成全屏，所以这个目标transform只是identity transform。当dismissing的时候，动画缩小到了原来的图像大小。

在这一点，你已经设定了这一阶段，定位新的视图控制器在点击的图像上。最后你调用`completeTransition()`返回到UIKit。

构建运行你的项目；点击第一个草本植物的图像看看你的视图控制器的在操作中的过渡：
 

![](/images/custompresent/custompresent11.png)

好吧，这并不是完美的，但是一旦你照顾了一些粗糙的边缘，你的动画是你想要的精准。 

当前你的动画从左上角开始；因为originFrame默认的与阿尼但就是（0，0），你并没有设置过其他的值。

打开 ViewController.swift添加下面的代码放到animationControllerForPresentedController()的顶端：

```
transition.originFrame = selectedImage!.superview!.convertRect(selectedImage!.frame,toView: nil) transition.presenting = true selectedImage!.hidden = true
```
设置selectImage的frame为过渡的originFrame，也就是最后点击的那个imageView。然后设置presenting为true，在动画执行期间隐藏点击过的图像。

构建运行你的项目；点击列表中不同的图片看看你的果如是如何寻找每一个的：

![](/images/custompresent/custompresent12.png)
 
 

#### 添加dismiss transition（消失过渡）
 
剩下所做的是dismiss 详情控制器。时间你已经完成了animator的大部分工作——过渡动画代码做的逻辑判断，设置初始属性值还有最后的frame，所以向前和向后是播放动画的大部分方式。
 

打开ViewController.swift，将下面代码替换到animationControllerForDismissedController()中：

```
transition.presenting = false 
return transition
```

这将告诉animator对象，你dismiss掉一个视图控制器，所以动画代码运行在正确的方向。

构建运行你的项目看看结果。点击一个草本图片，然后再点击任意地方dismiss掉它：

![](/images/custompresent/custompresent13.png)
 
过渡动画看起来很好，但是注意到你所选的草本植物已经从滚动视图中消失了。你需要确保你dismiss掉详情控制器的时候你点击过的图像要重新出现。
 
打开` PopAnimator.swift`添加一个闭包属性：

```var dismissCompletion: (()->())?
```
 
你可以放一些代码，当你dismiss完成之后执行：

下一步，找到` animateTransition() `并在调用`animateWithDuration`的完成后的比高中添加下面代码：
 
```
if !self.presenting { 
	self.dismissCompletion?()}
``` 

当dismiss动画执行完毕后执行`dismissCompletion`--显示原来图像的完美调用位置。
 
打开`ViewController.swift`添加下列代码到`viewDidLoad()`：

```
transition.dismissCompletion = {
	self.selectedImage!.hidden = false}
```
 
上面代码显示了一旦过渡动画调用完毕之后，原来的图像替换了草本的详情控制器。
 
 
###设备方向过渡

> 这个部分是可选的，如果对学习设备方向的变化后该如何处理，你可以跳过这段直接去挑战部分。

你可以认为方向的改变就像一个控制器present了它自己，只是尺寸不同。

viewWillTransitionToSize(_:coordinator:)是iOS8才有的，给你一个简单直接的方式处理设备的方向变化。你不需要单独的创建竖屏或者横屏的布局，你只需要对视图控制器的视图大小作出相应的变化：

打开`ViewController.swift`文件，添加viewWillTransitionToSize(...)：

```
override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {	super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)}
```

第一个参数是告诉你过渡的控制器的尺寸。第二个参数（协调器）是过渡协调器的对象，它可以让你访问过渡的一些属性。

在这个应用程序中，你需要做的是减少app背景图像的透明度，提高设备在横屏模式下的可读性。
 
将下面代码添加到viewWillTransitionToSize：

```
coordinator.animateAlongsideTransition({context in 
	self.bgImage.alpha = (size.width>size.height) ? 0.25 : 0.55}, completion: nil)
```
 
animateAlongsideTransition 指定在屏幕屏幕方向变化后旋转（UIKit默认执行）的同时执行的动画。

你的动画闭包接受一个过渡上下文，就像你使用present的一个视图控制器。在这种情况下，你没有“from”和“to”视图控制器，因为它们是相同的，但你可以获取属性，比如过渡时间。
 
在动画闭包里，检测如果目标尺寸的宽度是否大于高度。如果大于，背景图像的透明度减少到0.25。这使得背景在横屏模式下淡出，竖屏方向下以0.55的值淡入。

构建运行你的app；旋转设备（cmd+方向左右箭头）看看操作中的透明度动画：
 
![](/images/custompresent/custompresent14.png)
 
 
当你旋转成横屏的时候，你可以清除的看到背景昏暗：这使长条文本更容易阅读。

然而，如果你点击一个草本图片，你会发现动画有点混乱。因为现在屏幕是横屏而图片是纵向的尺寸。因此，在原来图像跟填充屏幕的拉伸图像之间的过渡不流畅。

你可以在`viewWillTransitionToSize`里面修复这个问题。

在视图控制器中调用类方法`positionListItems` 改变草本图像的额尺寸跟位置。当你app第一次启动的时候，这个方法在viewDidLoad()中被调用。

添加这个方法的调用到animateAlongsideTransition的block中，防止设置alpha代码之后：

```
self.positionListItems()
```

当设备旋转时，草本图像的大小和位置开始动画。屏幕重定向完毕草本的图像也已经调整好了：

![](/images/custompresent/custompresent15.png)

因此，这些图像现在有了一个横屏布局并且过渡动画工作的刚刚好。
 
![](/images/custompresent/custompresent16.png)
 
 
这就是本章的内容了。看看下面的挑战，你会改善一些过渡动画的中粗糙的地方。

###挑战

在你的演示中有两个缺陷：你可以看到详情视图的文本知道最后一刻消失。此外，初始的草本植物的图像的圆角，最后让动画看起来有些神经质。

####挑战一：平滑过渡

你的第一任务是当过渡的时候草本详情View渐入或渐出要适当。这将修正详情View中的文本通过dismiss消失的时的难看。

看看storyboard文件；你会看到详情控制器所有的文本控件都添加到了主视图连接给了containerView。

你需要做的是当过渡动画产生时，containerView的渐入或渐出。

解决这个挑战分三步：

* 使用viewControllerForKey方法得到HerbDetailsViewController。记住，这个`key`取决于present或者dismiss并且你需要将结果作为HerbViewController。这两个键选自UITransitionContextToViewControllerKey 和UITransitionContextFromViewControllerKey。
* 在你开始之前的动画（一个动画已经在animateTranstion），设置containerView透明度为0。你仅仅需要在present控制器而不是dismiss的时候这么做，因为dismiss的时候是它是可见的。
* 设置containerView的alpha在动闭包中--动画herbiew--present时完全不透明（1.0）和dismiss时候完全透明（0.0）

检测你的变化结果的紧密性，你可以增加过渡时长为10秒来观察动画的细节（或者设置iOS模拟器Debug/Slow Animations）


####挑战2：圆角半径动画

最后，你将详情视图的圆角半径动画，使它与在主视图控制器中的草本图像的圆角匹配。

animateTransition末尾创建并运行动画改变herbView的圆角半径。如果presenting 动画herbView.layer.cornerRadius 从 20.0/xScaleFactor 到 0.0。如果是dismissing，反之。你需要考虑到缩放因素因为你在改变View。

设置动画的持续时间为之前的2分之duration，以便它在spring动画开始之前完成，否则它会看起来很奇怪。

那个包裹了presentaion控制器的动画，接下来，导航控制器动画。你会注意到两者之间有很多相似之处，所以把草本植物放一边潜水。


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 









