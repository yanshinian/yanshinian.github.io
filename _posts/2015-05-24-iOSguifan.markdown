---
layout: post
title:  "开发规范（总结）"
category: iOS进阶
date:   2015-05-24
---

每个语言的开发规范都是从命名开始的。命名的规范，让人感觉到代码的整洁。让人顾名思义。神清气爽！

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

##属性跟实例变量
##多用字面量语法，少用与之等价的语法

使用字面量语法来创建字符串、数值、数组、字典。与创建此类对象的常规方法相比，这么做更加简明扼要。

数组通过下标操作访问数组元素，字典通过键操作访问对应元素。

字面量语法创建数组或者字典时，若值中有nil，则会抛出异常。务必确保没有nil值。

##多用类型常量，少用#define预处理指令


##用枚举表示状态、选项、状态码

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

#收集崩溃报告







##封装
`软件设计的黄金法则：变动需要抽象`

如果有多个类共有相同的行为，但是实际实现不同，则可能需要某种抽象类型作为其父类被继承。抽象类型定义所有相关具体类型将共有的共同行为。



参考资料：

* 《iOS编程实战》【美国】Rob Napier Mugunth Kumar 著 美团移动 译
* 《编写高质量iOS与OS X 代码的 52个有效方法》（英国）Matt Galloway 著 爱飞翔 译
* 

