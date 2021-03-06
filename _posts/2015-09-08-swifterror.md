---
layout: post
title:  "使用Swift出现的报错"
category: Swift
date:   2015-09-08
---
1.expected hexadecimal code in braces after unicode escape (`xcode7.0 beta 5 ，swift 2.0`)

当我使用 `(^[\u4e00-\u9fa5]{2,12}$)|(^[A-Za-z0-9_-]{4,12}$)`正则的时候，xcode 报错

参考链接：初学Swift 疑问记录   <http://www.cocoachina.com/bbs/read.php?tid=220911>

2.-[__NSCFNumber length]: unrecognized selector sent to instance 0xb00014f24e2

```
    /** 文章的 ID **/
    var artiId: String?
    /** 文章的标题 **/
    var title: String?
    /** 文章发布时间 **/
    var createTime: String?
```
改成了如下（一般类型要赋一个初始值的，否则会有问题）
```
    /** 文章的 ID **/
    var artiId: Int = 0
    /** 文章的标题 **/
    var title: String?
    /** 文章发布时间 **/
    var createTime: Int = 0
```
3.Cannot subscript a value of type '[UIViewController]' with an index of type'()'

![如图](/image/swifterror/error01.png)

其实，问题也简单，编译器有时候会帮你解决。但是没有的话手动改。

```
navigationController!.childViewControllers[1]

或者改成 

(navigationController?.childViewControllers[1])!
```
参考链接：<http://www.cnblogs.com/hw140430/p/4142195.html>

4. xib 自定义 cell ，运行报错`invalid nib registered for identifier (CellTableIdentifier) - nib must contain exactly one top level object which must be a UITableViewCell instance'`

```
我在cell中不小心拖了其他的控件，所以报错，删了就好了
```

参考链接： tableView identifier问题    <http://www.cocoachina.com/bbs/read.php?tid=263211>


5. `*** NSForwarding: warning: object 0x7fee43693d00 of class 'Regx.Car' does not implement methodSignatureForSelector: -- trouble ahead`


原因是没有继承NSObject

参考链接:Does not implement methodSignatureForSelector: — trouble ahead <http://handy-wang.iteye.com/blog/1162857>





 















