---
layout: post
title: "iOS_Animations_by_Tutorials2.0 第23章 交互的自定义导航过渡[简译]"
category: iOS
date: 2015-12-22 12:15
---

你不仅可以为你的过渡创建自定义动画，也可以使它相应用户的交互。通常，这个交互通过手势平移。这是你要在本章中用的方法。

### 创建一个交互的过渡

当你的导航控制器访问动画控制器代理的时候，两件事情可能发生。你可能返回nil，在这种情况下，导航控制器返回标准的过渡动画。你已经知道很多了。

无论如何，如果返回了一个动画控制器然后导航控制器访问它的代理——交互控制器就像下图：

![](/images/transitionInteractive/transitionInteractive01.png)

交互控制器基于用户行为的移动过渡，而不是简单的从开始到结束的动画改变。交互控制器不一定从动画控制器分离的类；事实上，两个控制器是一个类的时候执行一些任务容易一点。你只需要保证这个类遵循`UIViewControllerAnimatedTransitioning`跟`UIViewControllerInteractiveTransitioning`。`UIViewControllerInteractiveTransitioning`只有一个必须实现的方法——`startInteractiveTransition(_:) `——拿到过渡的上下文做它的参数。交互控制器然后有规律的调用updateInteractiveTransition(_:) 移动过渡。首先，你需要改变如何处理用户的输入。


### 处理平移手势

首先，在MasterViewController里的点击手势不能删掉它。一个点击瞬间发生然后它就消失。你不能跟踪它的进展，并用它驱动一个过渡。另一方面，一个平移手势在开始，进行还有结束的阶段都有明确的状态。

打开`Main.storyboard`；找到`master view controller`，在其界面的下方添加一个文本标签，内容为“lide to start”：

![](/images/transitionInteractive/transitionInteractive02.png)

提示用户如何操作。


接下来，打开`MasterViewController.swift`删除图中的点击手势的代码（下面代码中有提示——把下面的代码删除掉）：

```
override func viewDidAppear(animated: Bool) { 
	super.viewDidAppear(animated)
	// 把下面的代码删除掉	// add the tap gesture recognizer	let tap = UITapGestureRecognizer(target: self, action: Selector("didTap"))	view.addGestureRecognizer(tap)
```

删掉之后，换成下面的代码：

```
let pan = UIPanGestureRecognizer(target: self, action: Selector("didPan:"))view.addGestureRecognizer(pan)
```

当用户滑动屏幕，识别器在`MasterViewController`类中调用didPan()。

你需要修改你的`RevealAnimator`类处理一些新的交互过渡。

### 使用交互动画类

管理你的过渡，使用苹果内建的animator类——UIPercentDrivenInteractiveTransition。这个类遵循UIViewControllerInteractiveTransitioning协议使你获取和设置过渡的progress作为完成的百分比。

这将让你轻松些，你使用这个类相应的调整percentComplete属性并调用updateInteractiveTransition()设置当前过渡可见的progress。这将跳过过渡动画到计算过渡progress相一致的那个点。

通过本章你会学到如何使用` UIPercentDrivenInteractiveTransition`工作。

打开`RevealAnimator.swift`更新类定义：

```
class RevealAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
```

现在RevealAnimator的超类就是`UIPercentDrivenInteractiveTransition`。

下一步，添加下面属性，告诉animator是否开启过渡交互方式：

```
var interactive = false
```

添加下面的方法到`RevealAnimator`：

```
func handlePan(recognizer: UIPanGestureRecognizer) { 
}
```

当用户滑动屏幕，你在RevealAnimator中通过识别handlePan()更新过渡的当前progress。

你会填充`handlePan()`一点，但首先你要设置手势操作。

打开`MasterViewController.swift`添加下面的代理方法提供一个交互控制器给MasterViewController扩展：

```
func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {	if !transition.interactive { 
		return nil	}	return transition 
}                  
```

你想要过渡的到交互的时候，你仅仅返回了一个交互控制器。例如：在你的Logo Reveal项目中reveal过渡是交互的，但自定义的pop过渡保持原先不变。

现在你需要在将你的手势识别器跟你的交互控制器关联起来。添加下面方法到`MasterViewController`：

```
func didPan(recognizer: UIPanGestureRecognizer) { 
	switch recognizer.state {	case .Began:		transition.interactive = true		performSegueWithIdentifier("details", sender: nil) 
	default:		transition.handlePan(recognizer)
	}}
```

手势开始之前，你先确保你的交互设置为true，然后开始Segue到下个控制器。执行这个Segue开始前一章详细说明的过渡；代理方法添加的返回过渡给你动画控制器跟交互控制器。

所有的情况下，如果这个手势开始，你简单的把事情交给交互控制器，入下图所示：

![](/images/transitionInteractive/transitionInteractive03.png)

###计算你的动画进度

更重要的一点，你的手势处理程序是找出过渡了多远。

打开`RevealAnimator.swift`添加下面代码到handlePan()中：

```
let translation = recognizer.translationInView( recognizer.view!.superview!)var progress: CGFloat = abs(translation.x / 200.0) 
progress = min(max(progress, 0.01), 0.99)
```

首先，你得从手势识别器获得translation；translation让你知道无论在x轴还是y轴移动了多少个点。 

计算当前进度，吧x轴的translation处以200点。例如，用户的手指是移动了100个点，这个过渡完成了50%。200个点是任意数量的点，但是它是作为整段距离需要用手势完成过渡的一个很好的起点。


你不应该关心用户是想做还是向右滑动——那你为什么使用abs()得到滑动距离的绝对值。

最后，你在0.01到0.99进度直接；我的测试表明如果你单独的通过手势不让用户完成或恢复过渡，交互控制器表现很好。

现在，你知道过渡动画的均读，你可以更新过渡动画。

添加下面代码到`handlePan()`：

```
switch recognizer.state {
	case .Changed:		updateInteractiveTransition(progress) 
	default:		break}
```

继承UIPercentDrivenInteractiveTransition方法updateInteractiveTransition()并设置过渡动画的当前进度。

当用用户滑动屏幕，手势识别器在MasterViewController重复调用didPan()，在RevealAnimator中handlePan()的手势。

构建运行你的项目你的过渡看起来像下图:

![](/images/transitionInteractive/transitionInteractive04.png)

由于你的过渡没有完成，你以举起手指整个导航就中断了。然活儿，你看到reveal动画是随着你的手势的，你接近完成你的交互过渡。

updateIteractiveTransition() 顺滑的处理你的过渡进度并且显示过渡动画正确的frame；你的代码不需要提起手指。 :]

剩下的就是处理交互过渡完成后的状态了。

### 处理提前终止

这里你面对一个全新的问题：用户在x轴移动200点之前抬起了手指。让过渡处于未完成的状态了。

幸运的是，UIPercentDrivenInteractiveTransition给你提供了一组方法，让你自由的使用`revert`或`complete`过渡，这取决于用户的行为。

添加下面的两个case到switch语句中default的前面：

```
case .Cancelled, .Ended:	let transitionLayer = storedContext!.containerView()!.layer transitionLayer.beginTime = CACurrentMediaTime()	if progress < 0.5 { 		completionSpeed = -1.0 
		cancelInteractiveTransition()	} else {		completionSpeed = 1.0 
		finishInteractiveTransition()	}
```
 .Cancelled 跟.Ended对你的项目来说是同一件事情。在做其他事情之前，你拿到过渡的containerView的layer并设置其开始时间为当前的核心动画时间（ CACurrentMediaTime()）。
 
 如果用户滑动足够远才释放，你呈现出一个完全的控制器；如果不是，你只需回滚动画进度。在这两种情况下，你设置完成速度使动画运行在正确的方向。

>注意：设置时间跟速度看起来是UIKit错误解决办法；如果你不在过渡中使用layer动画，你不需要设置layer的开始时间和完成速度（completionSpeed）。

如果用户移动的距离小于所需的50%。调用cancelInteractiveTransition()——一个继承方法——动画过渡到初始状态。如果超过了50%，调用finishInteractiveTransition()，完成剩余动画。

![](/images/transitionInteractive/transitionInteractive05.png)

构建运行app，试着移动部分和大部分距离看看差异。

你有没有注意到当你滑动通过reveal动画，你不能回到列表了？这是因为你在handlePan()设置的interactive为true并且没有设置为false！因此，当你弹出视图控制器，从代理方法中返回从未更新的一个交互控制器并且你的pop过渡进度卡在了0%.

为了修复这点，在手势结束之后重新设置interactive属性。

将下面代码添加给case .Ended：

```
interactive = false
```

这样就能让你回到初始的屏幕了。

再一次构建运行，你能滑动返回跟前进了。

![](/images/transitionInteractive/transitionInteractive06.png)


### 挑战

####挑战一：创建pop过渡交互

在这个挑战中，你的任务是创建pop过渡交互。在你的项目当中你需要修改一些地方代码，听起来不太容易 。

你需要在编码之气计划好你的方法，下面是大致的框架：

首先，在DetailViewController；创建一个弱引用属性引用来自MasterViewController的animator对象。你可以通过导航栈访问MasterViewController。

一旦你这么做，添加一个手势操作给DetailViewController。你的处理方法跟MasterViewController中的几乎相同但有点差异：它应该pop当前的视图而不是调用一个segue。

在这一点，自定义pop过渡是功能性的。你给pop过渡使用view动画，但是view动画不需要调整beginTime和completionSpeed。当你的操作是`.Pop`时，不修改这些属性。

你会结束一个很酷的pop过渡，而且别忘了，点击导航栏的返回按钮依然可以工作！







































