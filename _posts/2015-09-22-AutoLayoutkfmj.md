---
layout: post
title: "《AutoLayout开发秘籍》读后感"
category: iOS
date: 2015-09-22 12:15
---
难得有一本讲iOS自动布局的书，可以以此巩固一番！AutoLayout是一门iOS6之后的布局技术。项目中采用自动布局可以通过`IB`（所谓的拖控件的界面既`StoryBoard`跟`xib`的统称）或者`写布局代码`。跟之前`纯代码的计算`（也就是每个控件必须是有x、y、width、height既控件的frame，也就是控件的位置）还有`IB`中使用AutoResizing（也是一种IB布局方式，缺点不够灵活）。Autolayout的思路是线性布局技巧，只需要考虑控件之间的关系。不用再非得确定控件的`frame`。比纯代码的计算更为省事。让你头脑更专注于布局逻辑，而不是加减乘除算半天。

借用这本书，复习了之前已会的一些零散的知识。书中有些章节像是使用说明手册。介绍如何使用xcode中自动布局每个按钮，选项是做什么的。除了IB的布局介绍，还有`NSLayoutConstrains`类的介绍，这里比较重要的是可视化格式的使用（这是苹果推荐的格式，从作者单独的拿出一章既第四章，介绍说明这个布局方式有的确不错）。非常适合初学者入门。如果你懒的写笔记。这本书也为你整理好了。

除了初学者，也适合用来进阶。作者分享了自己的一些布局的技巧。并且作者有自己的一些封装来简化笨重的代码（嗯，如果没有框架跟封装，写死你，简单的效果要很多代码，如果封装了。不仅简洁，而且省事。）。这样也为你提供了封装的思路。第五章还有一些调试的技巧。帮你无论从界面还是从控制台日志中，都能有清晰的轮廓（这点对代码自动布局有很大帮助，IB自动布局，你看IB基本就ok了，而且IB直观的告诉你冲突或者欠约束，而代码不会有提示，只有控制台的日志输出能告诉你了。几十行没有一个中文的日志，看着心情也没有了！当然，实际开发中，我们会使用框架比如大家常用的`Masonry`）

第六章是AutoLayout的实战章节。告诉你怎么更好，更合理的去布局。布局中该思考什么。我看后是这么想得：代码有代码抽取的方法，那么IB也应该有自己的抽取方法（这么一想，界面似乎不会很美观，你想，一个IB分成多个IB，页面再也没有那么直观了。），这是看了作者说的模块化创建引出的思考。作者的示例是一个界面，我们能放入一个父控件管理是最好（我是这么解读的），web前端也该能明白我说的，也就是，头部div，中间div，底部div。然后每个div负责管理自己的标签。是不是觉得我们前端有相同的思想吧？

第七章是解决疑难杂症的一个章节，确实，蛮实用的。也许你平常不会去尝试写这些不好解决的布局。比如，你一直用代码，或者某个不好解决的地方使用代码！其实，我最初也是这么想得，的确不好解决，我在想如果xcode再智能点多好。这里就拿`UIScrollView`布局举例吧，因为都说不好用IB布局，我就没有尝试，不过前些日子尝试了一次。的确需要奇技淫巧才好布局。当然第七章还有其他的奇技淫巧，这里就不赘述了。

总之，从AutoLayout的介绍、AutoLayout的核心、AutoLayout的代码跟IB的如何使用、AutoLayout的调试和最后的实战与突破。这本书一层一层，循环渐进。适合新手，也适合进阶。让你对AutoLayout的使用更加得心应手。

ps.当然这本书只是一个学习AutoLayout的一个方式，互联网是个大千世界，搜索搞定一切！你可以不看书，但是不能不去搜索！

我写的跟AutoLayout有关的三篇Blog：

* 《Scrollview的Autolayout》<http://yanshinian.com/ScrollviewAutolayot/>
* 《AutoLayout 练习》<http://yanshinian.com/autolayoutpractice/>
* 《Auto Layout 约束的优先级》<http://yanshinian.com/piority/>














