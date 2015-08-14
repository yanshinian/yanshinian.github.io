---
layout: post
title:  "Swift2.0简单语法回顾"
category: swift
date: 2015-08-10
---
###常量，变量

常量声明不可更改，变量反之。比如你的名字，生下来叫`言十年`，那就是常量了。但是你的年龄可以一直再变，那就是变量了。
```
let name = "言十年"
var age = 18
```
###类型标注
声明变量的时候，告诉别人这个变量是报错啥类型的。但是声明变量直接赋初始值就可以不加。可以推断类型。
```
let name: String = "言十年"
var age: Int = 19
var height: Double
height = 166.5
```
### 数据类型

####整数
Int 

* 在32位平台上，Int 和 Int32 长度相同
* 在64位平台上，Int 和 Int64长度相同

一般使用Int 就够了，可以提高代码一致性和可复用性。

####浮点数

* `Double`表示64位浮点数。适合存储很大或者很高精度的浮点数。
* `Float`表示32位浮点数。适合存储精度要求不高的浮点数。

###控制语句

OC中是 YES/NO ，swift 中是 true / false， swift 没有非零即真的概念

```
var a = 1;
var b = 1;
if a == b{
	print("a=b");
}
```

if - let 语句 检查 一个可选类型变量是否包含值。如果包含，则将这个值指定给一个常量变量，然后运行某段代码。这样可以减少很多行代码，同时又能保证安全性，首先查看一个可选变量是否拥有要处理的值。

```
var name : String? = "swift2.0";

if let tempName = name {
    print("name = " + tempName)
} else {
    print("name = nil")
}
```
if - let 嵌套，请看<http://nshipster.cn/swift-1.2/>



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
### 字符串

Swift中String 用来声明字符串变量，不同于NSString的是，它是结构体，效率高，支持快速遍历。

遍历

```
let letters = "abcdefghijklmn";

for l in letters {
    print(l)
}
```

拼接

```
let a = "swfit"
let b = "2.0"
let c = a + b;
```
打印结构体

```
let frame = CGRectMake(10, 10, 10, 10)

print(frame)
```
转换成

### 数组

```
var arr = [String]() // 声明一个空数组
let arr1 : [Int];
arr1 = [1,2,3];
//arr1.append(3) // 不可变不能追加元素
print(arr1)

```

OC中的数组的元素都是对象，如果我们放数字 `3` ，必须搞成NSNumber，`@(3)`,swift 元素可以直接放`数字`。

```
var arr2 = [1, 2, "3", "4", 5]; 
arr2.append("6")
arr2.removeAll(keepCapacity: false) // keepCapacity 是否保持容量

```

参考资料：

* [译] Swift 2.0 简要介绍 <http://www.tuicool.com/articles/RZNJfqV>
* 《Swift与Cocoa框架开发》[澳] 曼宁（Jonathon Manning），巴特菲尔德-艾迪生（Paris Buttfield-Addison），纽金特（Tim Nugent） 著；贾洪峰 译 
* 《Swift 1.2》<http://nshipster.cn/swift-1.2/>



