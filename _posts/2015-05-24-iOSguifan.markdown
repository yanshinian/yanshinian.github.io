---
layout: post
title:  "开发规范（总结）"
category: iOS进阶
date:   2015-05-24
---


##自动变量

Cocoa 是动态类型语言，开发者很容易对手头的对象类型感到迷糊。容器（数组、字典、NSSet等）没有关联的类型，因此开发者经常会不小心写出下面的代码:

```
NSArray *dates = @[@"1/1/2015", @"8/9/2016"];

NSDate *firstDate = [dates firstObject];
```

这段代码可以编译，没有警告。但是，后续如果使用firstDate程序就有可崩溃。写出这样的代码或许因为命名不是很明确。应该命名成dateStrings，让人一看就明了，容器存放的是字符串。避免发生低级错误。

##方法

方法的名字应该很清晰地表明他接受的参数类型和返回值的类型。比如，下面方法会让人迷惑：

```
- (void)add; // 会让人迷惑
```
看起来 add 应该有个参数，但是实际上没有。它也许执行某种”添加“行为。

如果按照下面命名方式，或许让人豁然开朗：

```
- (void)addEmptyRecord;

- (void)addRecord:(Record *)record;
```

很明显addRecord:接受一个Record参数。有时候，为了避免对参数的误解，形参名应该有类型名的影子,也就是看到形参就知道是什么类型。

```
- (void)setURL:(NSString *)URL; // 错误的方式
```
通常我们会认为，URL应该是NSURL类型的形参。然而，代码中确实NSString类型。不妨我们改成如下代码！

```
- (void)setURLString:(NSString *)string;

- (void)setURL:(NSURL *)URL;
```
不要滥用这个规则，有些类型的变量不用这样添加类型信息。属性名name 比 nameString好，只要你的系统中没有Name类就不会让读代码的人误会。

不要用alloc、new、copy或者mutableCopy开头。因为以上述几个词汇开头，调用者拥有返回的对象，对象的引用计数器会加一，调用者必须负责释放。

###为私有的方法加前缀

有时候更改API，有的标记成私有方法，我们自然知晓用于类的内部，然后就不用再去更改。给私有方法加前缀，更容易跟公共的方法区分开

不要用单用一个下划线做私有方法的前缀，这是苹果公司御用的。可以在方法的名字之前加`p_`

##属性跟实例变量

##多用字面量语法，少用与之等价的语法

使用字面量语法来创建字符串、数值、数组、字典。与创建此类对象的常规方法相比，这么做更加简明扼要。

数组通过下标操作访问数组元素，字典通过键操作访问对应元素。

字面量语法创建数组或者字典时，若值中有nil，则会抛出异常。务必确保没有nil值。

##多用类型常量，少用#define预处理指令

有时候，你想把播放动画的时间提取为常量，你也许是这么做的：


	#define ANIMATION_DURATION 0.3


这样的定义没有类型信息。假设此命令在某个头文件中，那么所有引入这头文件的代码，其ANIMATION_DURATION都会被替换。

如果想解决这个问题，应该设法用编译器的某些特性才对。有个办法比用预处理指令来定义常量更好。

	 static const NSTimeInterval kAnimationDuration = 0.3;
	 

用上面的方式，清晰描述了常量的含义。你也很明白这这个常量的类型。更加有助于编写开发文档。能让阅读代码的人更容易理解你的意图。

常量的命名：若常量局限于某“编译单元”（translation unit，也就是实现的文件内 也就是.m文件呗），在前面加字母k；如果再类之外可见，则通常以类名为前缀了。


##用枚举表示状态、选项、状态码

常量来表示错误状态码或可组合的选项时，极宜使用枚举为其命名枚举。枚举只是一种常量的命名方式。某个对象所经历的各种状态就可以定义为一个简单的枚举集（enumeration set）。比如，可以用下列枚举表示“套接字连接”（socket connection）的状态：

```
enum EOCConnectionState {
    EOCConnectionStateDisconnected,
    EOCConnectionStateConnecting,
    EOCConnectionStateConnected,
};
```
每种状态都用一个便于理解的值来表示，所以写出来的代码更容易读懂。编译器会为枚举分配一个独有的编号，从0开始，每个枚举递增1.

指定底层数据类型的做法是：

```
enum EOCConnectionState : NSInteger{/* …… */}
```
Foundaiton 框架中定义了一些辅助的宏，用这些宏定义枚举类型时，也可以指定用于保存枚举的底层数据类型。

```
typedef NS_ENUM(NSInteger, UIViewAnimationTransition) {
    UIViewAnimationTransitionNone,
    UIViewAnimationTransitionFlipFromLeft,
    UIViewAnimationTransitionFlipFromRight,
    UIViewAnimationTransitionCurlUp,
    UIViewAnimationTransitionCurlDown,
};

typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
    UIViewAutoresizingNone                 = 0,
    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
    UIViewAutoresizingFlexibleWidth        = 1 << 1,
    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
    UIViewAutoresizingFlexibleHeight       = 1 << 4,
    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
};
```

`NS_OPTIONS`,这种方式常用于定义选项的时候。这种定义使得各项之间通过“按位或操作符”来组合。就像上面举列的。每个选项可`启用`或`禁用`还可以多个组合（通过按位与操作符）。

##为常用的块类型创建typedef

##多用块枚举，少用for循环

##instancetype

为了保持一致性，init方法和快捷构造方法返回的类型最好都用instancetype

##开发中使用断言

使用断言可以有效的防止程序的错误。断言要求程序中特定的语句必须为真。如果不为真，说明程序正处于一种无法预测的运行状态，这个时候不应该继续下去。

```
NSAssert(x == 4, @"x must be four");
```
如果测试条件返回NO，NSAssert就会抛出一个异常。异常处理程序捕获异常之后，会调用abort结束程序。iOS开发中，不管是在哪个线程中发生异常，默认行为都是调用abort结束程序。

建议在发布版本的时候禁用断言。可以在编译设置面板的`“Preprocessor Macros”（GCC_PREPROCESSOR_DEFINITIONS）`中设置`NS_BLOCK_ASSERTIONS`以禁用NSAssert。设置之后会再程序中完全删除断言。

建议在对断言做些改动以便在日志中留下记录。下面的RNLog（NSLog）的别名函数可以用来记录日志。`不建议经常使用#define`，这里使用很有必要，因为需要把`__FILE
__`跟`__LINE__`转换为调用者代码所在的文件和行号。

把NSCAssert包装成 RNCAssert,在C语言中使用断言应该使用这个。

```
define RNLogBug NSLog //如果使用的是Lumberjack日志框架，要把NSLog换成DDLogError。
#define RNAssert(condition, desc, ...) \
if(!(condition)) { \
    RNLogBug((desc), ## __VA_ARGS__); \
    NSAssert((condition), (desc), ## __VA_ARGS__); \
}

#define RNCAssert(condition, desc, ...) \
if(!(condition)) { \
    RNLogBug((desc), ## __VA_ARGS__); \
    NSCAssert((condition), (desc), ## __VA_ARGS__); \
}

```

断言的使用应该放在程序崩溃之前。下面举两个例子。

if条件中的使用。如果断言条件跟if条件不匹配，就可能产生BUG。
```
if (foo != nil) {
	[arry addObject:foo];
} else {
	RNAssert(NO, @"foo 不能为 nil");
}
```

switch中，断言建议放在default分支处：

```
switch (foo) {
        case kFooOptionOne:
            ...
            break;
        case kFooOptionTwo:
            ...
            break;
        default:
            RNAssert(NO, @"Unexpected value for foo: %d", foo);
            break;
    }
```
##异常

OC中异常不是处理错误的方式。异常是用来处理那些永远不应该发生却发生的错误，这时候应该结束程序运行。NSSAssert 就是作为异常实现的。

不建议使用@trow 和 @catch这些异常的处理指令。如果希望抛出异常表明程序错误，最好是用NSAssert抛出`NSInternalInconsistencyException`异常，或者自定义的异常对象（继承自NSException）。通常使用NSAssert，毕竟简洁也更有用。

##收集崩溃报告

iOS应用时，有几种收集崩溃转储的途径。

###iTunes Connect

iTunnes Connect 允许下载应用的崩溃报告。登陆后到应用的详细页面下载崩溃报告。从iTunes Connect中拿到的崩溃报告并没有经过符号化，你应该用构建提交的应用时生产呢过的dSYM文件来对其进行符号化。可以用xcode自动完成，或是动手进行（使用命令行工具symbolicatecrash）。

###友盟Crash

###腾讯Crash



##源代码管理工具CocoaPods

以后开发就使用CocoaPods，方便第三方框架的管理。

使用参考链接：[http://blog.devtang.com/blog/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/](http://blog.devtang.com/blog/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/)


##性能调优

###Instruments

####leaks

####Time Profiler




性能测试一定要在Release 模式（默认的是Debug）下进行，这样才能进行优化处理


##封装
`软件设计的黄金法则：变动需要抽象`

如果有多个类共有相同的行为，但是实际实现不同，则可能需要某种抽象类型作为其父类被继承。抽象类型定义所有相关具体类型将共有的共同行为。



参考资料：

* 《iOS编程实战》【美国】Rob Napier Mugunth Kumar 著 美团移动 译
* 《编写高质量iOS与OS X 代码的 52个有效方法》（英国）Matt Galloway 著 爱飞翔 译
* 《高效程序员的45各习惯：敏捷开发修炼之道》

