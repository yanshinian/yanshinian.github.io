iOS 动画

UIView的animation

e.g

```
let rotation = CGAffineTransformMakeRotation(CGFloat(M_PI))
UIView.animateWithDuration(1, animations: {
    self.控件.transform = rotation
})
```


###CABasicAnimation

KeyPath 类型

字段名|描述
----|--
rotation.x|x轴旋转
rotaion.y|y轴旋转
rotaion.z|z轴旋转
rotation|x,y,z轴旋转
scale.x|x轴缩放
scale.y|y轴缩放
scale.z|z轴缩放
scale|x,y,z轴缩放
translation.x|x轴平移
translation.y|y轴平移
translation.z|z轴平移
translation|x,y,z平移

e.g

```
let base = CABasicAnimation(keyPath: "transform.scale")
base.fromValue = 1.0
base.toValue = 0.5
base.repeatCount = Float(Int.max)
控件.layer.addAnimation(base, forKey: "唯一的key")
```





参考链接：

《iOS动画——ViewAnimations》<http://www.jianshu.com/p/bd7bf438b288>

《CABasicAnimation》<https://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CABasicAnimation_class/Introduction/Introduction.html>

《CAPropertyAnimation》 <https://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CAPropertyAnimation_class/Introduction/Introduction.html#//apple_ref/occ/cl/CAPropertyAnimation>

《CAAnimation》 <https://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CAAnimation_class/Introduction/Introduction.html#//apple_ref/occ/cl/CAAnimation>

《CABasicAnimation animationWithKeyPath Types》<http://www.adamzucchi.com/blog/?p=24>

《iOS动画编程-View动画[ 3 ]Transitions动画》<https://segmentfault.com/a/1190000003897633>