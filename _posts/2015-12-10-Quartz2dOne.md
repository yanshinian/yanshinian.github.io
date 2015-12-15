---
layout: post
title:  "Quartz 2d繪圖的基本使用「One」"
category: Swift
date:   2015-12-10 12:15 
---

最簡單的繪圖步驟

1. 獲取上下文

2. 創建路徑(這裡需要設置一些你喜歡的參數)

3. 添加路徑到上下文

4. 繪製路徑

5. 釋放路徑(swfit不需要了)


畫一條垂直的線。


```
override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, 200, 100)
    CGPathAddLineToPoint(path, nil, 200, 200)
    CGContextAddPath(context, path)
    CGContextSetRGBStrokeColor(context, 0.4,0.1, 0.68, 1)
    CGContextDrawPath(context, CGPathDrawingMode.Stroke)
}
```

畫一個綠色的直角三角

```
let context = UIGraphicsGetCurrentContext()
let path = CGPathCreateMutable()
CGPathMoveToPoint(path, nil, 200, 100)
CGPathAddLineToPoint(path, nil, 200, 200)
CGPathAddLineToPoint(path, nil, 300, 200)
CGContextAddPath(context, path)
CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
CGContextDrawPath(context, CGPathDrawingMode.Fill)
```

畫一個青色的圓（如果是橢圓，改rect的寬高值不等）

```
let context = UIGraphicsGetCurrentContext()
let rect = CGRectMake(100, 200, 200, 200)
CGContextAddEllipseInRect(context, rect)
CGContextSetFillColorWithColor(context, UIColor.cyanColor().CGColor)
CGContextDrawPath(context, CGPathDrawingMode.Fill)
```

畫一個淡藍色弧線

```
let context = UIGraphicsGetCurrentContext()
CGContextAddArc(context, 100.0, 100.0, 100.0, 0, CGFloat(M_PI_2), 0)
CGContextSetRGBStrokeColor(context, 0.45, 0.77, 0.83, 1)
CGContextDrawPath(context, CGPathDrawingMode.Stroke)
```

畫一個橘色矩形

```
let context = UIGraphicsGetCurrentContext()
let rect = CGRectMake(100, 200, 100, 200)
CGContextAddRect(context, rect)
CGContextSetRGBStrokeColor(context, 1.00, 0.50, 0.0, 1)
CGContextSetFillColorWithColor(context, UIColor(red: 1.00, green: 0.5, blue: 0.0, alpha: 1).CGColor)
CGContextDrawPath(context, CGPathDrawingMode.Fill)
```

另，一種簡便的做法

```
let rect = CGRectMake(100, 200, 100, 200)
UIColor .orangeColor().set()
UIRectFill(rect)
```

或者來個矩形框？

```
let rect = CGRectMake(100, 200, 100, 200)
UIColor .orangeColor().set()
UIRectFrame(rect) // 矩形框
```

畫文字

```
let text: NSString = "你什麼都沒有，還敢開店？--《蠟筆小新》第一部，第一集，《買東西記》"
let font = UIFont.systemFontOfSize(18)
let dict = [NSForegroundColorAttributeName: UIColor.cyanColor(), NSFontAttributeName: font]
var rect = text.boundingRectWithSize(CGSizeMake(200, 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict, context: nil) // 這樣計算通常用來換行，比如根據文本計算UIlabel的size
rect.origin  = CGPointMake(100,100)
UIColor.lightTextColor().set()
UIRectFill(rect)
text.drawInRect(rect, withAttributes: dict) // text.drawAtPoint(CGPointMake(100, 100), withAttributes: dict) 是不能換行的，文字一長就超過了整個view。
```

畫圖片

```
let image = UIImage(named: "apple")
image?.drawAtPoint(CGPointMake(100, 100))  // 指定座標點 ，默認就是圖片尺寸
```
如果想規定圖像顯示的範圍的話用下面這個：

```
image?.drawInRect(CGRectMake(100, 100, 50, 50)) // 指定 範圍
```
或者使用混合模式

```
image?.drawAtPoint(CGPointMake(100, 100), blendMode: CGBlendMode.Copy, alpha: 1.0)
```

保存上下文，恢復上下文

如果不保存，我們會看到兩個橢圓，第一個圓設置的放大，第二個也一樣被設置了。如果保存了上下文，設置第二園之前恢復上下文，那麼第二個還是圓。這就好比把以前的設置都作廢了。

```
let context = UIGraphicsGetCurrentContext()
CGContextSaveGState(context) // 保存上下文
let rectOne = CGRectMake(50, 100, 100, 100)
CGContextScaleCTM(context, 1.0, 2.0)
CGContextAddEllipseInRect(context, rectOne)
CGContextSetFillColorWithColor(context, UIColor.cyanColor().CGColor)
CGContextDrawPath(context, CGPathDrawingMode.Fill)
CGContextRestoreGState(context)  // 恢復上下文
let rectTwo = CGRectMake(150, 100, 100, 100)
CGContextAddEllipseInRect(context, rectTwo) 
CGContextDrawPath(context, CGPathDrawingMode.Fill)
```

生成UIImage 

table拖動，導航條變色，就可以用這種，生成Image的方式，拖動的時候，改變UIColor的alpha。給人感覺變色了。

```
let size = CGSizeMake(100, 100)
UIGraphicsBeginImageContext(size)
UIColor.cyanColor().set()
UIRectFill(CGRectMake(0, 0, size.width, size.height))
let image = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
```


參考鏈接：

《OC – 8.Quartz2D Core elements》<http://www.codes9.com/mobile-development/ios/oc-8-quartz2d-core-elements/>

《封装CoreGraphics的API简化绘图操作》<http://www.cnblogs.com/YouXianMing/p/4617337.html#undefined>

JigsawPuzzle (一個9x9的拼圖)<https://github.com/nealCeffrey/JigsawPuzzle>

《一些有关图像处理的代码片段(抓图、倒影、圆角)》 <http://www.cnblogs.com/lovecode/archive/2011/11/12/2246421.html>







