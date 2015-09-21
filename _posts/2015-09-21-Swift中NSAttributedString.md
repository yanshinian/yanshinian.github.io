---
layout: post
title:  "Swift(2.0)中NSAttributedString[简译]"
category: Swift
date:   2015-09-21
---

原文：《NSAttributedString in Swift》 <https://www.invasivecode.com/weblog/attributed-text-swift/>（英语不好，翻译好累，鸣谢谷歌跟百度）


过去我们讲过很多在你的app中有关如何自定义文本来提高你的应用UI。iOS 6之前，Core Text是开发者唯一可选的。尽管是一个大框架，但是，Core Text不是易用的工具。你可以看我们的OC的CoreText[教程](https://www.invasivecode.com/weblog/core-text)。iOS 6中，苹果介绍了`NSAttributedString`。你可以看两篇文章[这篇](https://www.invasivecode.com/weblog/introduction-to-nsattributedstring-for-ios-ive)还有[这篇](https://www.invasivecode.com/weblog/attributed-strings-for-ios-using-interface)。

Core Text 用于特殊的情况下而`NSAttributedString`相比之下没有那么麻烦。如果可能，你可以把它作为首选。2014年6月，苹果推出了`swift`，我们要用`swift`跟`NSAttributedString`创建一个项目。

首选，让我告诉你更多简单使用文本定制相关的`一些Cocoa类`。UILabel, UIButton, UIPickerView, 还有 UITableViewCell 的文本属性可以使用`NSAttributedString`自定义。

使用这些属性，你必须在你的项目中添加 UILabel, UIButton, UIPickerView 或者 UITableViewCell实例并且赋值一个`NSAttributedString`。拿一个`UILabel`举例，可能做的跟下面这样：

```
labelName.attributedText = attributedString
```

### 我们创建一个示例

使用`swift`来创建`属性字符串`

启动Xcode创建一个`single-view`样板的应用工程——`属性字符串示例`。在`viewController.swift`文件的`viewDidLoad()`方法中编辑，如下：

```
override func viewDidLoad() {
    super.viewDidLoad()
    if let titleFont = UIFont(name: "Copperplate", size: 50.0)  {
        let shadow : NSShadow = NSShadow()
        shadow.shadowOffset = CGSizeMake(-2.0, -2.0)
        
        let attributes = [
            NSFontAttributeName : titleFont,
            NSUnderlineStyleAttributeName : 1,
            NSForegroundColorAttributeName : UIColor.blueColor(),
            NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
            NSStrokeWidthAttributeName : 3.0,
            NSShadowAttributeName : shadow]
        
        let title = NSAttributedString(string: "NSAttributedString", attributes: attributes) //1
        
        let label = UILabel(frame: CGRectMake(((self.view.bounds.size.width - title.size().width) / 2.0), 40.0, title.size().width, title.size().height)) //2
        label.attributedText = title //3
        
        view.addSubview(label) //4
    }
}
```

这里，我们在第一行创建了一个`属性字符串`。在这个特别的案例中，我们设置了`字体`、`尺寸`、`文字效果`（NSTextEffectAttributeName）、`字体颜色`、`字体阴影`还有`下划线`这些属性

第二行创建了一个`label`的实例并且在第三行把`属性字符串`赋值给了`label`。最后一行第四行，把`label`添加到`viewController`的`view`上。在IB中我们把这个view的背景设置成了蓝色。现在，编译，运行，就是下面这个样子：

![](/images/NSSAttributeString/NSAttributedString_0070.PNG)

这个示例演示了怎么去创建属性字符串以及怎么去赋值给`UILabel`的`attributedText`属性。简单对吧？但是你可能会疑惑，哪些字符串我可以应用？让我们去一个一个的去查看它们。

### 字符属性

我们看下可以用到你的文字中当前可用的属性

#### NSFontAttributeName（字体）

文字字体的设置。如果没有指定，默认是 12个点 的Helvetica(Neue)字体。

####NSParagraphStyleAttributeName（段落样式）

一段文本的范围可以应用多个属性（例如：对齐，制表符和终端模式）

####NSForegroundColorAttributeName（前景色）

默认文字渲染为黑色。下图例子中是红色的前景色

![](/images/NSSAttributeString/NSAttributedString_0083.PNG)

####NSBackgroundColorAttributeName（背景色）

默认情况下没有颜色。下面图片中是黄色背景。

![](/images/NSSAttributeString/NSAttributedString_0084.PNG)

####NSLigatureAttributeName（）

![](/images/NSSAttributeString/NSAttributedString_0073.PNG)

####NSKernAttributeName （紧排）

`紧排`指定两个字符之间的空间（间隙）。默认为0。任意指定字符间的点数。

下图中，设置两种不同的字符间隙示例。（上面文本是 10，下面是0）

![](/images/NSSAttributeString/NSAttributedString_0074.PNG)

####NSStrikethroughStyleAttributeName（删除线样式）

这个属性表示是否有删除线。默认是无样式，但是你可以指定一系列不同样式来穿过文本。

下图是这个属性不同值的应用效果：

![](/images/NSSAttributeString/NSAttributedString_0075.PNG)


####NSUnderlineStyleAttributeName（下划线样式）

这个属性表示是否有下划线渲染。默认没有，但是你能指定相似风格的不同的删除线风格

![](/images/NSSAttributeString/NSAttributedString_0076.PNG)

####NSStrokeColorAttributeName（轮廓颜色）

文本的轮廓颜色。默认跟前景色一样。

#### NSStrokeWidthAttributeName

This value represent the amount to change the stroke width. By default is 0, for no additional changes. A positive value will change the stroke width alone, a negative value will stroke and fill the text.

Find an example in the image below.

改变轮廓宽度的值。默认为0，没有改变。一个正值改变轮廓宽度。一个复的值会填充文本。

如下图所示：

![](/images/NSSAttributeString/NSAttributedString_0077.PNG)


####NSShadowAttributeName

为文本添加阴影的属性。默认为nil，也就是没有阴影。

如下图所示：

![](/images/NSSAttributeString/NSAttributedString_0085.PNG)

####NSTextEffectAttributeName（文本效果）

指定文本的效果。默认值为nil，没有效果。

####NSAttachmentAttributeName（附件）

可以指定一个`NSTextAttachment`对象。默认为nil，也就是没有附件


####NSLinkAttributeName（链接）

`NSURL`或`NSString`的属性值。默认为nil，没有链接。

####NSBaselineOffsetAttributeName（基线偏移）

用点表示字符基线的偏移。基线是一行文本所依赖 ​的假想线。默认偏移为0。

下图是一个红色基线：

![](/images/NSSAttributeString/NSAttributedString_0078.PNG)

####NSUnderlineColorAttributeName（下划线颜色）

下划线的颜色。默认采用前景色。

下图是一个绿色的删除线：
![](/images/NSSAttributeString/NSAttributedString_0080.PNG)

####NSStrikethroughColorAttributeName（删除线颜色）

贯穿线的颜色。默认采用前景色。

下图是一个红色的删除线：

![](/images/NSSAttributeString/NSAttributedString_0079.PNG)

####NSObliquenessAttributeName（斜体）

默认为0，也就是不倾斜。正值向右倾斜，负值向左倾斜。无论如何，在你创建之前，

下图使用的是`Academy Engraved LET`字体。 倾斜值为 1.

![](/images/NSSAttributeString/NSAttributedString_0081.PNG)

####NSExpansionAttributeName

![](/images/NSSAttributeString/NSAttributedString_0082.PNG)

#### NSWritingDirectionAttributeName

####NSVerticalGlyphFormAttributeName

![](/images/NSSAttributeString/NSAttributedString_0072.PNG)

### NSAttributedString 局限性

下面有几点是无法使用属性字符串的。


* 1.属性字符串目前是不能解决文本的垂直渲染。
* 2.如果想绘制除矩形之外的形状，你仍然要用`Core Text`
* 3.如果你想呈现在非水平线的文字（如曲线），你可能会不得不选择核心文本或CATextLayer。



参考链接：

* NSAttributedString in Swift <https://www.invasivecode.com/weblog/attributed-text-swift/>
* iOS 字符属性NSAttributedString描述 <http://my.oschina.net/lanrenbar/blog/395909>
* iOS- 详解文本属性Attributes - 清澈Saup<http://www.tuicool.com/articles/zquENb>


 















