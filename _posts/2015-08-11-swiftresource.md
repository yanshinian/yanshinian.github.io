---
layout: post
title:  "Swift跟OC开发的不同以及Swift学习资源"
category: swift
date: 2015-08-10
---

###Swift跟OC开发的不同

貌似面试官会问，Swift 跟 OC的区别。我个人觉得，不同貌似很多，你比如说王巍的书100个tips，那肯定至少有100个不同。面试官也许想知道你对语言的看法来看你学习的深度吧？真的是这样么？

1.swift 不支持 隐式转换，值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。

2.OC没有命名空间，用了Swift再也不用总是引用头文件了。

3.Swift不能使用 #pragma mark 开始使用  MARK: 参考[《swift pragma mark》](http://ju.outofmemory.cn/entry/104921)

4.Swift 增加了OC没有的高阶数据类型比如`元组`（Tuple）。元组可以创建或传递一组数据，比如作为函数的返回值时，可以用一个元组返回多个值。还增加了可选（Optional）类型，用于处理值缺失的情况。可选表示“那儿有一个值，并且它等于x”或者“那儿没有值”。可选有点像在OC中使用nil，但是可选可以用在任何类型上。

5.`类型推断`。Swift声明变量，对比OC很少需要声明类型了。

6.Swift的nil和OC中的nil不同。OC中，nil是一个指向不存在对象的指针。Swift中，nil不是指针，它是一个确定的值，用来表示值缺失。

7.Swift中将宏定义彻底从语言中拿掉了。

8.Swift 中 数组可以放数字。而OC中数字我们通常是弄成NSNumber才行。

9.log输出。swift中是print（2.0 Beta版本里，没有了println, print默认状态就是换行的，如果想不换行，要这样写`print("测试 ", appendNewLine: false)）`。swift的print性能好过OC中的NSLog。
<!--7.Swift支持引用传值。OC不支持。-->
  
### 学习资源

1.梁杰 《The Swift Programming Language》中文版 <https://www.gitbook.com/@numbbbbb>

2.花川学院 <http://www.hcxy.me>

3.另一份《The Swift Programming Language 中文版》 <http://wiki.jikexueyuan.com/project/swift/>

4.Swift 资源汇总 <http://dev.swiftguide.cn/>

5.Let's Swift <http://letsswift.com>


参考资料：

* swift与OC之间不得不知道的21点 <http://www.cnblogs.com/dsxniubility/p/4294658.html>
* 《The Swift Programming Language》中文版<https://www.gitbook.com/book/numbbbbb/-the-swift-programming-language-/details>




