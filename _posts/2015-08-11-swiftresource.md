---
layout: post
title:  "Swift跟OC开发的不同以及Swift学习资源"
category: swift
date: 2015-08-10
---

###Swift跟OC开发的不同

> 貌似面试官会问，Swift 跟 OC的区别。我个人觉得，不同貌似很多，你比如说王巍的书100个tips，那肯定至少有100个不同。面试官也许想知道你对语言的看法来看你学习的深度吧？真的是这样么？不管怎么样。从OC转Swift开发，我们知道这些。有助于我们开发更加的顺利！不是么？

1.swift 不支持 隐式转换，值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。

2.OC没有命名空间，用了Swift再也不用总是引用头文件了。

3.Swift不能使用 #pragma mark 开始使用  MARK: 参考[《swift pragma mark》](http://ju.outofmemory.cn/entry/104921)

4.Swift 增加了OC没有的高阶数据类型比如`元组`（Tuple）。元组可以创建或传递一组数据，比如作为函数的返回值时，可以用一个元组返回多个值。还增加了可选（Optional）类型，用于处理值缺失的情况。可选表示“那儿有一个值，并且它等于x”或者“那儿没有值”。可选有点像在OC中使用nil，但是可选可以用在任何类型上。

5.`类型推断`。Swift声明变量，对比OC很少需要声明类型了。

6.Swift的nil和OC中的nil不同。OC中，nil是一个指向不存在对象的指针。Swift中，nil不是指针，它是一个确定的值，用来表示值缺失。

7.Swift中将宏定义彻底从语言中拿掉了。

8.在Objective-C中，数组和字典可以包含任意你想要的类型。但是在Swift中，数组和字典是类型化的。并且是通过使用我们上面的朋友—泛型来类型化的！Swift 中 数组可以放数字。而OC中数字我们通常是弄成NSNumber才行。

9.log输出。swift中是print（2.0 Beta版本里，没有了println, print默认状态就是换行的，如果想不换行，要这样写`print("测试 ", appendNewLine: false)）`。swift的print性能好过OC中的NSLog。

10.Swift 中没有像OC中的NSArray ，NSMutable 的类型了。取而代之的是`let`和`var`。var声明的是变量。let 声明的是常量！let相当于之前的const。一旦声明就不可变。

11.Swift支持全部Unicode字符集。你可以在字符串中使用任何Unicode码位，甚至是函数和变量的名字！

12.Swift的另一个非常棒的扩展是字符串比较。你很清楚在Objective-C中使用==来比较字符串是不正确的。取而代之地，你应该使用isEqualToString:方法。因为前者是指针比较。Swift移除了这个间接的标准，相反地让你能够直接使用==比较字符串。这也意味着字符串可以用于switch语句。

13.swift 的switch 必须写default 语句。每个case之下不用再写break！

14.Swift支持泛型。

15.Swift 没有提供显式的指针，参数传递根据数据类型的不同分为值类型和引用类型，值传递进行内存拷贝，引用传递最终传递的是一个指向原有对象的指针。这一点和 Java 的参数传递是类似的。
<!--7.Swift支持引用传值。OC不支持。-->

16.与 C语言 和 Object-C不同，Swift的赋值操作并不返回任何值。以下代码是错误的：

17.创建的String变量，当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。在任何情况下，都会对已有的字符串值创建新副本，并对该新副本进行传递或赋值操作。值类型在`结构提和枚举是值类型`中进行了详细的描述。

与`NSString` 不同，创建的NSString实例，传递给一个函数/方法，或者是赋值给一个变量，你传递或者赋值的是该NSString实例的一个引用，除非特别要求进行值拷贝，否则字符串不会生成新的副本来进行赋值操作。

18.

```
var (x, y) = (1, 2)
if x = y {
    // x = y,并不返回任何值
}
```
  
### 学习资源

####国内
1.梁杰 《The Swift Programming Language》中文版 <https://www.gitbook.com/@numbbbbb>

2.花川学院 <http://www.hcxy.me>

3.另一份《The Swift Programming Language 中文版》 <http://wiki.jikexueyuan.com/project/swift/>

4.Swift 资源汇总 <http://dev.swiftguide.cn/>

5.Let's Swift <http://letsswift.com>

####国外
1.We❤️Swift <http://www.weheartswift.com/>

2.Swift Programming: Introduction <https://www.youtube.com/playlist?list=PLDj3dknzoPvMYvf3skevfJb3zV3qt1_Fp>

3.Swift Video Tutorials <http://www.swiftvideotutorials.com/>

4.practicalswift<http://practicalswift.com/>

参考资料：

* swift与OC之间不得不知道的21点 <http://www.cnblogs.com/dsxniubility/p/4294658.html>
* 《The Swift Programming Language》中文版<https://www.gitbook.com/book/numbbbbb/-the-swift-programming-language-/details>
* Objective-C开发者对Swift亮点的点评 <http://letsswift.com/2014/06/objective-c-developer-view-swift/>
* 苹果新贵 Swift之前世今生<http://letsswift.com/2014/06/swift-past-and-future/>
* 行走于 Swift 的世界中<http://www.onevcat.com/2014/06/walk-in-swift/>




