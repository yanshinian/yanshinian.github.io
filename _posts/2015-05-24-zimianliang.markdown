---
layout: post
title:  "多用字面量语法，少用与之等价的方法（读书笔记）"
category: iOS进阶
date:   2015-05-24
---

OC中我们经常用到这几个类NSString、NSArray、NSDictionary、NSNumber。从类名就明了了各自表示的数据结构了。

OC以语法繁杂著称。不过，从OC 1.0起，可以通过“字符串字面量”（string literal）来创建NSString对象了。

```
NSString *xiaoyan = @"言十年";
```
我们就不用通过调用示例方法，或者类方法来创建了，方便简洁，并且可读性强。字面量的语法也能用到NSNumber、NSArray、NSDictionary的实例。

##字面数值

用NSNumber的字面量包装方法，把整数、浮点数、布尔值、字符包装成对象。


```
NSNumber *intNumber = @1;

NSNumber *floatNumber = @2.5;

NSNumber *doubleNumber = @3.141592653;

NSNumber *charNumber = @'a';
```
字面量也可以这样用：

```
int x = 5;

int y = 6.32f;

NSNumber *expressionNumber = @(x * y);
```

## 字面量数组

```
NSArray *heroes = @[@"董存瑞", @"黄继光", @"邱少云", @"杨根思"];
```
上面的做法不仅简单，还便于操作数组。数组的常见操作就是取下标。我们能想到一个方法“objextAtIndex:”。

```
NSString *firstHero = [heroes objectIndex:1];

如果用字面量呢？

NSString *firstHero = heroes[1];

```

这里用字面量除了方便简洁外有个注意的地方，若数组元素对象有nil，则会抛出异常，因为字面量语法实际上只是一种”语法糖“（syntactic sugar），其效果等于先创建一个数组，然后把方括号内的所有对象都加到这个数组中。抛出的异常会是这样:

```
*** Terminating app due to uncaughtexception

'NSInvalidArgumentException', reason: '***

-[__NSPlaceholderArrayinitWithObjects:count:]: attempt to

insert nil object from objects[0]'
```
两种创建数组的语法对比：

```
id obj1 = /* ... */;

id obj2 = /* ... */;

id obj3 = /* ... */;

NSArray *arrA = [NSArrayarrayWithObjects:

obj1, obj2, obj3, nil];

NSArray *arrB = @[obj1, obj2,obj3];
```
设想，obj1跟obj3是非nil，obj2是nil。那么这两种方式会有什么反应呢？字面量语法创建的arrB会抛出异常直接崩了。arrA则不会，它只有一个”obj1“的元素。因为”arrayWithObjects:“方法会一次处理各个参数，发现”nil“就停止了，由于”obj2“是nil，该方法提前结束了。

这样看来使用字面量语法更为安全。抛出异常然后终止程序，这比创建好数组之后才发现元素个数少了要好。通过字面量语法我们可以更快的发现这个错误。


延伸一个知识点：`[NSArray firstObject]` （《iOS编程实战》iOS7那版的，第31页）
```
iOS7.0 出来的方法。如果数组为空，firstObject返回nil，而不会像objectAtIndex:0那样崩溃

```
##字面量字典

”字典“是一种映射型数据结构，可以向其中添加键值对。与数组一样。创建方式如下：

```
NSDictionary *personData = [NSDictionary dictionaryWithObjectsAndKeys:@"Matt", @"firstName",@"Galloway",@"lastName",[NSNumber numberWithInt:28],@"age",nil];
```
这样写令人困惑，因为是<对象>，<键>，<对象>，<键>。这与通常理解的顺序想法，我们一般是吧”键“映射到”对象“。这种方式可读性不好。字面量方式让你一目了然。

```
NSDictionary *personData = @{@"firstName" : @"Matt", @"lastName" : @"Galloway", @"age" : @28};
```
字典中的对象和键必须是OC对象。你不能直接存放数字类型的变量。用NSNumber（包装类）包装即可！数字之前加@即可！

与数组一样，字面量创建字典时也有个问题，一旦值有nil，就会抛出异常。这也许是个好事。便于我们查错。

字典也可以向数组那样用字面量访问

```
NSString *lastName = personData[@"lastName"];
比
NSString *lastName = [personDataobjectForKey:@"lastName"];
爽多了
```
###可变数组和字典

取值跟不可变的方法一样。修改值的方法如下：

```
[mutableArray replaceObjectAtIndex:1withObject:@"dog"];

[mutableDictionarysetObject:@"Galloway" forKey:@"lastName"];
```

字面量方法如下：

```
mutableArray[1] = @"dog";

mutableDictionary[@"lastName"] =@"Galloway";
```
##局限性

字面量语法有个小限制，除了字符串以外，所创建的对象必须属于Foundation 框架才行。如果自定义了这些类的子类，则无法使用字母量语法创建其对象。要想创建自定义子类实例，必须用”非字面量语法“（noliteral syntax）。可是，由于NSArray, NSDictionary, 和 NSNumber 是”类簇“（class cluster，参见第9条）。很少有人从中自定义子类，真要做也比较麻烦。标准的实现足够了。创建字符串可以使用自定义子类，然而必须要修改编译器的选项才行。除非你明白这样做的后果，否则不鼓励使用此选项，用NSString就足够了

使用字面量语法创建的字符串、数组、字典对象都是不可变的（immutable）。若想要可变的版本的对象。需要复制一份

```
NSMutableArray *mutable = [@[@1, @2, @3,@4, @5] mutableCopy];
```
这么做会多调用一个方法，还要再创建一个对象，不过好处多于缺点吧。

参考资料：

*  Effective Object-C 2.0 第一章（条目3） [http://blog.csdn.net/lpstudy/article/details/22578501?utm_source=tuicool](http://blog.csdn.net/lpstudy/article/details/22578501?utm_source=tuicool)
* XCode中Objective-C功能支持情况索引 (http://blog.csdn.net/annkie/article/details/9722511)[http://blog.csdn.net/annkie/article/details/9722511]
* 《编写高质量iOS与OS X 代码的 52个有效方法》（英国）Matt Galloway 著 爱飞翔 译 