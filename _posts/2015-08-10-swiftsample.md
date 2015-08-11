---
layout: post
title:  "Swift2.0简单语法回顾"
date:2015-08-10
category: swift
---
###控制语句
```
OC中是 YES/NO ，swift 中是 true / false， swift 没有非零即真的概念
var a = 1;
var b = 1;
if a == b{
	print("a=b");
}

if - let 语句 检查 一个可选类型变量是否包含值。如果包含，则将这个值指定给一个常量变量，然后运行某段代码。这样可以减少很多行代码，同时又能保证安全性，首先查看一个可选变量是否拥有要处理的值。

var name : String? = "swift2.0";

if let tempName = name {
    print("name = " + tempName)
} else {
    print("name = nil")
}

```

###循环

```
// 注意：需要使用 var 而不是 let
for var i = 0; i < 10; i++ {
    print(i)  // 2.0 开始，合并了 print跟println
}

// for in 写法，in 0..<10 表示，取值大于等于0小于10
for i in 0..<10 {
    print(i)
}

for i in 0...10 {
    print(i)
}

//  `_` 表示忽略，函数方法使用`_`表示忽略参数
for _ in 0...10 {
    print("swift2.0", appendNewline: true) //打印换行可以这么做
}

var i = 0
repeat {
    i++
    print(i)
} while i < 10 // do-while 更名成 repeat-while
```
### 可选类型 Optional

声明方式：类型+？ 

好处：如果没有赋值，就给个nil，打印出来就是 `nil`。那么，如果不是可选类型，不赋值无法使用，报错提示你 `变量没有赋值`

```
var str1 : String?
str1 = "swift2.0";
print(str1);	// 打印出来是 Optional("swift2.0")
print(str1!); // 打印出来是 swift2.0 ! 是解包的意思 
```

参考资料：

* [译] Swift 2.0 简要介绍 <http://www.tuicool.com/articles/RZNJfqV>



