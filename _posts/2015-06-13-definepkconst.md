---
layout: post
title: "多用Const，少用#define"
description: 多用Const，少用#define
date: 2015-06-13 12:15:48
category: OC语法
---


###\#define跟Const的比较
我们经常会定义一些常量为我们服务！比如你定义动画的时长也许会用这样的方法：

```
#define ANIMATION_DURATION 0.3
```
此后，你只要使用上述的定义出来的`ANIMATION_DURATION`就会被替换。然而，这样定义出来的没有类型信息。预处理过程会把碰到所有的`ANIMATION_DURATION`一律替换成0.3。那么，只要引入过这个文件的代码，其中的`ANIMATION_DURATION`都会被替换。

应该利用编译器的特性才对。`Const`比预处理指令来定义常量更好。

```
static const NSTimeInterval kAnimationDuration = 0.3;
```
`Const`定义的常量包含了`类型信息`，清楚了的描述了常量的含义！由此可知该常量类型为NSTimeInterval，有助于编写开发文档。更能让人明白意图。

命名方式：

如果常量局限于某个“编译单元”（也就是.m文件）之内，就在前面加上字母k；如果常量需要暴露在类外让其它类也能访问，则通常以类名为前缀。

定义常量位置很重要。我们总喜欢在头文里声明预处理指令，这样做真的很糟糕，有有可能与其他类中的常量（命名一样）发生冲突。`static const`定义的常量也不应该在头文件中。因为OC没有“命名空间”，所以那样做等于声明一个名叫`kAnimationDuration`的全局变量。


如果不打算公开这个常量，那就放到.m文件。变量一定要同时用static与const来声明。如果视图修改由const修饰符所声明的变量。那么编译器就会报错。static意味该变量仅在定义此变量的编译单元中可见（作用域有了限制，仅限于.m所生成的目标文件中。也就是.O文件）。如果不加static，别的文件就可以访问，有可能发生同名冲突。

```
小细节

const int age = 20; // 只有初始化的时候可以赋值。 正确

const int age; // 错误

age = 29; //这是不对的
```

一个变量既声明为static，又声明为const，那么编译器根本不会创建符号。而是会像#define预处理指令一样，把所有遇到的变量都替换为常值。

如果需要对外公开某个常量。比如，发送通知，你要通知别人的时候，通知的名称就可以用常量。并且是别人可以访问的。那样，在.h文件中，用`extern`（.h中是extern NSString *const xxNotification;.m中是NSString *Notification = @"xxNotificationName";），你也可以学习苹果的风格使用`UIKIT_EXTERN`。以后，接收通知的人，不需要知道值是啥子东西，就知道这个常量代表啥就够了。

`extern`关键字就是告诉编译器，全局符号表中将会有一个名字叫`xxNotification`的符号。编译器无需查看其定义就允许代码使用该常量。它知道，链接成二进制文件，肯定能找到这个常量。

```
苹果的风格如下，键盘通知
UIKIT_EXTERN NSString *const UIKeyboardWillShowNotification;
UIKIT_EXTERN NSString *const UIKeyboardDidShowNotification; 
UIKIT_EXTERN NSString *const UIKeyboardWillHideNotification; 
UIKIT_EXTERN NSString *const UIKeyboardDidHideNotification;
```
这样定义常量要优于#define预处理指令，编译器会保证常量值不变。而预处理指令可能会遭人修改，导致应用程序各部分所使用的值不同。



###宏定义

#### 好处
* 不需要在栈区单独压栈（参看坏处第一条），用空间换取栈区的消耗
* 有时候是不可替代的，例如：拼接生成变量名，抽取单例宏时，定义shared##className

```
e.g.
拼接：
// 可以连接两个字符串
#define CONTACT(x, y) x##y
转字符串：
// 使用一个#，可以将参数直接转换为字符串
#define TO_STR(x) #x

printf("%s", TO_STR(言十年));

单例：
// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
\
    return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
    if (_instance == nil) { \
        _instance = [[class alloc] init]; \
    } \
\
    return _instance; \
}

```
#### 坏处

* 重复的占用空间
* 有一些副作用（比如：宏定义涉及到一些计算操作）

####注意事项

* 关于宏的副作用，使用宏的时候，尽量避免做计算操作
* 宏是将代码复制到对应的位置，为了保证代码的稳定，尽量的使用括号

副作用举例：

```
 #define MAX(x, y) ((x) > (y) ? (x) : (y))

 int a = 10;
 int b = 1;
 int c = MAX(++a, b);
 printf("%d",a); //a 是 12，因为执行了两次 ++a
```
###Const

const推出的初始目的，正是为了取代预编译指令，消除它的缺点，同时继承它的优点。const可以节省空间，避免不必要的内存分配。

```
#define PI1 3.14159 // 常量宏
const double PI2 = 3.14159; // 此时并未将Pi放入RAM中
double a = PI2; // 此时为Pi分配内存，以后不再分配！
double b = PI1; // 编译期间进行宏替换，分配内存
double c = PI2; // 没有内存分配
double d = PI1; // 再进行宏替换，又一次分配内存
```
const定义常量从汇编的角度来看，只是给出了对应的内存地址，而不是象#define一样给出的是立即数，所以，const定义的常量在程序运行过程中只有一份拷贝，而#define定义的常量在内存中有若干个拷贝。

####Const 使用

const所在的位置与类型无关，`const int` 与 `int const`没有半毛钱区别。

使用const可以保证变量的安全，在其它函数调用过程中，变量的内容不会被修改

int * const a => a的地址是常量，禁止修改其指向的地址

const int * a => *a的内容是常量，禁止修改*a的内容

```
int sum(int * const a, const int *b)
{
    *a = 80;
    int i = 70;
    
    return *a + *b;
}
```
 
#####面试常问的蛋疼问题

 ```
Const 放到什么位置代表什么意思？
题目一：
int i = 10;

// 是锁定内容
const int *p = &i;
int const *p1 = &i;
    
// 是锁定地址
int * const p3 = &i;
    
// 内容和地址都不能改
const int * const p2 = &i;

题目二：
const int i = 10；
//使用指针的目的，通过间接的方式，修改变量
//如果定义了一个常量，是不允许通过指针间接修改的
int *p = &i;
    
//*p 可以读取i的内容，但是不能修改i的内容
const int *p = &i;
int const *p = &i;
    
//只锁定地址，是可以间接修改变量内容的
int * const p = &i;

 ```
 


参考资料：

* 《编写高质量iOS与OS X代码的52个有效方法》(英国) Matt Galloway 著 爱飞翔 译
*  某播客某期iOS培训班某节视频与ppt 
*   \#define命令的一些高级用法 <http://blog.csdn.net/xiahouzuoxin/article/details/9494503>