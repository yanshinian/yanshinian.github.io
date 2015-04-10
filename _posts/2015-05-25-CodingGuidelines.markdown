---
layout: post
title: "Cocoa编码规范【整理】"
description: "Cocoa编码规范"
date: 2015-05-25 02:15:48
category: 效率开发
---
命名的心得，那就是多向苹果多学学。学学苹果的命名的方式

* NSString 类，方法的命名。长的跟句子，但是一读便明了，还有它分类的声明与分组。有时候为了方便。把分类写到一起。当然也可以分文件处理。
* UITableViewController类，代理的命名，代理方法的命名。
* UIKit/NSAttributedString.h 类，常量的命名（`能用const就少用#define`）。
* UIButton.h 类，工厂方法创建不同的button。
* UIControl.h 类，学习下枚举的命名方式。
* UINavigationController.h 类，学习下严格的属性声明，能不让外界修改就不让外界修改。

当然出了以上的类，还有其他的类，值得我们去学习，无论是封装还是代码的整洁便于阅读都可看做一个参考标准了。下面是整理的 Cocoa 编码规范。

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
* 包含框架的头文件:所有的框架都有一个头文件，以框架命名，包含框架里所有公开的头文件。

	```
	Foundation.h  Foundation.framwork。
	```
* 为别的框架中类增加API：如果你在一个框架中声明的方法，是另一个框架中类的分类，名字为原来类的名字拼接上“Additions”。一个例子为Applicatiion kit 的NSBuddleAdditions.h头文件。 --相联系的函数和数据类型：如果你有一些相联系的函数、常数、结构体等其他数据类型，将它们放到合适命名的头文件中。例如NSGraphics.h(Applicatiion kit )。

##方法命名

###基本规则

* 方法名采用小驼峰命名。不使用前缀。有两个情况是例外的，方法用到了众所周知的缩写(例如TIFF或PDF)，还有就是你可能定义一些私有的方法
* 如果方法代表对象的某个动作，方法用动词开头：

	```
	- (void)invokeWithTarget:(id)target;

	- (void)selectTabViewItem:(NSTabViewItem *)tabViewItem
	```
	
	不要使用`do`或`does`，它们没有什么含义，并且不要在动词之前使用副词或形容词
* 如果方法返回的是消息发送者(对象)的属性，用属性命名方法。get这个词不需要，除非有多个间接返回的值。

	```
	- (NSSize)cellSize;        正确

	- (NSSize)calcCellSize;    错误

	- (NSSize)getCellSize;	  错误
	```
* 在所有的参数前使用关键词

	```
    - (void)sendAction:(SEL)aSelector toObject:(id)anObject forAllCells:(BOOL)flag; 	正确
    - (void)sendAction:(SEL)aSelector :(id)anObject :(BOOL)flag; 	错误
	```
* 参数前的单词描述参数的意义

	```
     - (id)viewWithTag:(NSInteger)aTag; 	正确
     - (id)taggedView:(int)aTag; 	错误
	```
	
* 当你创建一个基于现有方法的新方法，在一个已有的方法上添加关键词

	```
     - (id)initWithFrame:(CGRect)frameRect; 	NSView,UIView
     - (id)initWithFrame:(NSRect)frameRect mode:(int)aMode cellClass:(Class)factoryId numberOfRows:(int)rowsHigh numberOfColumns:(int)colsWide; 	NSMatrix,NSView的一个子类
```
* 不要使用and去连接多个参数的关键词(对象属性名)

	```
    - (int)runModalForDirectory:(NSString *)path file:(NSString *) name types:(NSArray *)fileTypes; 	正确
    - (int)runModalForDirectory:(NSString *)path andFile:(NSString *)name andTypes:(NSArray *)fileTypes; 	错误
	```
尽管在这个例子中and看起来还不错，但是当方法中有许多参数的时候，再用and就不行了。 

* 如果方法包含着俩个分开的动作，用and去连接它们；

	```
	- (BOOL)openFile:(NSString *)fullPath withApplication:(NSString *)appName andDeactivate:(BOOL)flag;   NSWorkspace
	```
###存取器（Set，Get）方法

存取器放方法是指那些读/写对象属性的方法，根据属性意义的不同，它们有不同的通用格式。(备注：不同格式代表不同对应实例变量的写法，存取器方法形式就是intanceVariables 和 setIntanceVariables俩种形式) 

* 如果属性表示的是名词意思，格式如：
   
   \- (type)noun; 
   
   \- (void)setNoun:(type)aNoun; 
   
   ```
    - (NSString *)title;
    - (void)setTitle:(NSString *)aTitle;
   ```
   
* 如果属性表示的是形容词意思，格式如：
 
	\- (BOOL)isAdjective;
  
	\- (void)setAdjective:(BOOL)flag; (注意type是BOOL) 
   
   ```
   - (BOOL)isEditable; 
   - (void)setEditable:(BOOL)flag;
   ```
   
* 如果属性表示的是动词意思 ， 格式如：

	\- (BOOL)verbObject; 
	\- (void)setVerbObject:(BOOL)flag; (注意type为BOOL)
   
	```
    - (BOOL)showsAlpha; 
    - (void)setShowsAlpha:(BOOL)flag; 
	```
   动词是现在时；    
* 在属性的名称中，不要通过用分词形式将动词转换为形容词；

	```
	- (void)setAcceptsGlyphInfo:(BOOL)flag; 	正确
	- (BOOL)acceptsGlyphInfo; 	正确
	- (void)setGlyphInfoAccepted:(BOOL)flag; 	错误
	- (BOOL)glyphInfoAccepted; 	错误
	```

参考资料：

* iOS开发规范[http://blog.csdn.net/pjk1129/article/details/45146955](http://blog.csdn.net/pjk1129/article/details/45146955)
* Coding Guidelines for Cocoa[https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingBasics.html#//apple_ref/doc/uid/20001281-BBCHBFAH ](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingBasics.html#//apple_ref/doc/uid/20001281-BBCHBFAH )
* iOS:Cocoa编码规范 -[译]Coding Guidelines for Cocoa (http://www.2cto.com/kf/201406/305877.html)[http://www.2cto.com/kf/201406/305877.html]
* [Cocoa]苹果 Cocoa 编码规范(http://blog.csdn.net/kesalin/article/details/6928929)[http://blog.csdn.net/kesalin/article/details/6928929]