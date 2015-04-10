
---
layout: post
title: "Cocoa编码规范"
description: Cocoa编码规范
date: 2015-05-25 02:15:48
categorie: 效率开发
---
命名的心得，那就是多向苹果多学学。学学苹果的命名的方式

##代码命名的基本知识

###一般原则

####清晰 

```
insertObject:atIndex: // 清晰

insert:at: //不清晰；是什么被插入？at又意味着什么？

removeObjectAtIndex: // 清晰，我们知道根据索引来删除

removeObject; // 清晰，删除相关的对象

remove: // 不清晰；什么被删除？

```

通常，不要缩写一些东西的名称，尽管他们拼写起来很长。

```
destinationselection // 清晰

destsel //不清晰

setBackgroundColor:

setBkgdColor: //不清晰，
```
你可能认为一个缩写是众所周知的，但也不尽然，特别是如果开发者遇到你的方法或函数的名称有着不同的文化和语言背景

有的缩写是公用的而且有了一定的年份。你可以继续使用它们。如果方法名称给人感觉有不同的解释，要避免API命名歧义。

```
sendPort  // 是发送端口？还是返回端口？

displayNmae //是展示一个名称？还是在用户界面接受一个标题呢？
```
####一致性

不同类之间的方法做同样的事情，那么名称也应该一样。

```
- (NSInteger)tag //NSView, NSCell, NSControl中都有定义
- (void)(void)setStringValue:(NSString *) //在Cocoa 一些类中也有定义
```
####不要自我引用

命名不应该自我参照

```
NSString // Okay

NSStringObject // NO，自我参照
```

常数（看做标记，可以进行位运算)例外，用作通知名称。

```
NSUnderlineByWordMask // Okay

NSTableViewColumnDidMoveNotification //Okay
```
###前缀

前缀是在编程接口名称的重要组成部分。能够区分不同的功能模块。通常这一软件封装在一个框架或（如是基础和应用套件的情况下）密切相关的框架。前缀避免了第三方开发者和Apple之间的命名冲突（也防止Apple本身）。

前缀有规定的格式。通常由2/3个大写字母组成。不要使用“下划线”或者“子前缀”。

```
NS	Foundation
NS	Application Kit
AB	Address Book
IB  Interface Builder
```
使用前缀来命名类、协议、函数、常数，自定义数据类型(typedef structures)，不要用前缀来命名方法。方法存在类的命名区域中，不要在这区域里面使用前缀。

###书写约定

对于多个单词组成的名字，不要使用标点符号(下划线、破折号等)作为名称部分或作为分隔符。相反每个单词第一个字母大写并且连着写（例如：`runTheWordsTogether`）--驼峰命名。注意一下几点：

 * 对于方法名字，第一个单词小写字母开头,剩下的首字母大写（小驼峰命名规则）,不要用前缀。例如：`fileExistsAtPath:isDirectory:`。一个例外是，方法名称以通用的缩写开头，例如：TIFFRepresentation (NSImage)。
 
 * 对于函数和常数，和相关类使用相同的前缀，并且大写第一个字母。例：NSRunAlertPanel、NSCellDisabled。
 
    ```
    SRunAlertPanel ,
  	NSCellDisabled
    ```

 * 避免使用下划线作为前缀意义在于会导致方法名称私有的意思（可以用它做实例变量）。Apple保留使用该规则。但在第三方用可能导致命名冲突，他们会不自觉的重写自己已有的一个私有方法。
 
###类和协议命名

一个类名应该包含一个名词，这个名词清晰的表示这个类是代表什么，是做什么的。 这个类名还应该包含一个前缀（参见“前缀”）。Foundation跟应用框架有很多这样的例子。`NSString,NSDate,NSScanner,NSApplication`等等

协议的命名应该根据使用协议的相应类行为命名 

* 大多数协议包含的相关方法，不与任何特定的类关联。这种协议的应该命名为使协议与类不能混淆。一个通常的规则是用动名词(...ing)。
 	
 	```
NSLocking  Good
NSLock     一看就是类名称
 	```

* 有的协议包含一些没什么联系的方法（而不是创建多个独立的小协议）。这些协议跟一个类的联系很大，这个类主要体现了这个协议。这种情况下，命名规则为协议名跟类名字一样。一个例子是NSObject 协议，这个协议包含一些方法可以查询任何类在父类中的层次位置等。因为NSObject类实现了协议的大部分方法，所以协议可以以类名命名。
 
##代理的命名
自定义的代理命名方式`名字＋delegate`就好比苹果的tableview的代理`UITableViewDelegate`。

##头文件

怎么命名你的头文件非常重要。因为你的命名表明了类中的内容：

* 声明一个独立的类/协议：如果一个类/协议不是一个文件中的一部分，将其声明独立成一个文件，这个文件的名字表明了该类/协议；

   ```
   NSLocale.h  NSLocale类。
   ```

* 声明联系的类/协议：如果有一些联系的声明（类、协议、分类），将它们声明放到一个文件中，文件的命名根据基础的类、协议、分类；

  ```
  NSString.h	NSString和NSSMutableString
  NSLock.h      NSLocking协议、NSLock、NSConditionLock、NSRecursive类
  ```
* 




参考资料：

* iOS开发规范[http://blog.csdn.net/pjk1129/article/details/45146955](http://blog.csdn.net/pjk1129/article/details/45146955)
* Coding Guidelines for Cocoa[https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingBasics.html#//apple_ref/doc/uid/20001281-BBCHBFAH ](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingBasics.html#//apple_ref/doc/uid/20001281-BBCHBFAH )
* iOS:Cocoa编码规范 -[译]Coding Guidelines for Cocoa (http://www.2cto.com/kf/201406/305877.html)[http://www.2cto.com/kf/201406/305877.html]
* [Cocoa]苹果 Cocoa 编码规范(http://blog.csdn.net/kesalin/article/details/6928929)[http://blog.csdn.net/kesalin/article/details/6928929]