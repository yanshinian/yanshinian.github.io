---
layout: post
title: "Swift.Apprentice.v1.1[书摘]"
category: iOS
date: 2015-12-24 12:15
---

 Chapter 1: Coding Essentials &
 
 
###计算机是如何工作的

计算机的核心是一个CPU。这基本上是一台数学机器。它执行加法，减法和其他算术操作数。你看到的一切当你操作计算机的时候都是建立在每秒百万次运算的CPU上。

CPU上面存储数字的最小存储器单元称之为寄存器。CPU能从计算机的主存储器中读取数字，叫做随机存储器。

 Editor\Execute Playground


### Chapter 6: Repeating Steps

 

跳出循环

```
var sum = 0
rowLoop: for row in 0..<8 {
    columnLoop: for column in 0..<8 {
        if row == column {
            continue rowLoop
        }
        sum += row * column
    }
}
```

延伸阅读：<http://bbc.in/1O89TGP>

###Chapter 8: Closures
 

####声明一个闭包

```
var multiplyClosure: (Int, Int) -> Int

multiplyClosure = { (a: Int, b: Int) -> Int in
    return a * b 
}


let result = multiplyClosure(4, 2) // result = 8

//简写 语法

multiplyClosure = { (a: Int, b: Int) -> Int in
    a*b
}

// 推断返回类型
multiplyClosure = { (a: Int, b: Int) in
    a*b
}

// 忽略参数列表

multiplyClosure = {
    $0 * $1
}
// 参数列表，返回类型和关键字都不见了，你的新的闭包声明比原来的要短得多。
```

####调用一个闭包

```
func operateOnNumbers(a: Int, _ b: Int,
    operation: (Int, Int) -> Int) -> Int {
        let result = operation(a, b)
        print(result)
        return result
}
let addClosure = { (a: Int, b: Int) in
    a+b }
operateOnNumbers(4, 2, operation: addClosure)


// 你也可以传递一个有名字的函数
func addFunction(a: Int, b: Int) -> Int {
    return a + b }
operateOnNumbers(4, 2, operation: addFunction)

operateOnNumbers(4, 2, operation: { (a: Int, b: Int) -> Int in
    return a + b })

operateOnNumbers(4, 2, operation: {
    $0 + $1
})
// trailing closure syntax.
operateOnNumbers(4, 2) {
    $0 + $1
}
```

#### 闭包对变量的访问

闭包能够访问该变量，因为闭包是在同一范围内定义的变量。封闭是说捕捉到的计数器变量。在闭包的内部和外部，任何变化，它使变量是可见的。

```
var a = 55

var closure = {
    print(a) // 是可以访问 而且值是 55
    a = 65
    print(a) // 是可以访问 而且值是 65
}
closure()
print(a) // 值65
```

```
func countingClosure() -> (() -> Int) {
    var counter = 0
    let incrementCounter: () -> Int = {
        return counter++
    }
    return incrementCounter
}

let counter1 = countingClosure()
let counter2 = countingClosure()
counter1() // 0
counter2() // 0
counter1() // 1
counter1() // 2
counter2() // 1
```
 
###Chapter 9: Optionals

内置的安全功能。

有时候有的变量是可以没有值的。比如：职位。这个变量或字段。当你有职位的时候就有值。当你没有职位的时候我们也可以使用nil。

用来表示一个不存在的有效值称为“定点值”。

我们可以认为Optional 是一个盒子：它包含一个值，或者它不包含一个值，包含nil。盒子本身总是存在的，它总是在那里为你打开和让你看到里面。

Optionals变量错误的赋值

```
let ageInteger: Int? = 30
print(ageInteger)

print(ageInteger + 1) 这个 是错误的，因为试图添加一个整数到一个盒子里，而不是在盒子里的值，对于盒子本身，没有意义！
```

####If let binding

单个可选变量

```
let authorName: String? = "Matt Galloway"
let authorAge: Int? = 30
if let name: String = authorName,
    age: Int = authorAge {
        print("The author is \(name) who is \(age) years old.")
} else {
    print("No author or no age.")
}
```

多个可选变量

```
let authorName: String? = "Matt Galloway"let authorAge: Int? = 30if let name: String = authorName,       age: Int = authorAge {  print("The author is \(name) who is \(age) years old.")} else {  print("No author or no age.")}
```
















