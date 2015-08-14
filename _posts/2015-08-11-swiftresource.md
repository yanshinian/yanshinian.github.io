---
layout: post
title:  "Swift跟OC开发的不同以及Swift学习资源"
category: swift
date: 2015-08-10
---

###Swift跟OC开发的不同

1.swift 不支持 隐式转换，值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。

2.OC没有命名空间，用了Swift再也不用总是引用头文件了。

3.Swift不能使用 #pragma mark 开始使用  MARK: 参考[《swift pragma mark》](http://ju.outofmemory.cn/entry/104921)

4.Swift 增加了OC没有的高阶数据类型比如`元组`（Tuple）。元组可以创建或传递一组数据，比如作为函数的返回值时，可以用一个元组返回多个值。还增加了可选（Optional）类型，用于处理值缺失的情况。可选表示“那儿有一个值，并且它等于x”或者“那儿没有值”。可选有点像在OC中使用nil，但是可选可以用在任何类型上。

5.`类型推断`。Swift声明变量，对比OC很少需要声明类型了。
  
### 学习资源

1.梁杰 《The Swift Programming Language》中文版 <https://www.gitbook.com/@numbbbbb>

2.花川学院 <http://www.hcxy.me>

3.另一份《The Swift Programming Language 中文版》 <http://wiki.jikexueyuan.com/project/swift/>

4.Swift 资源汇总 <http://dev.swiftguide.cn/>



参考资料：

* swift与OC之间不得不知道的21点 <http://www.cnblogs.com/dsxniubility/p/4294658.html>
* 《The Swift Programming Language》中文版<https://www.gitbook.com/book/numbbbbb/-the-swift-programming-language-/details>




