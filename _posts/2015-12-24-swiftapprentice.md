---
layout: post
title: "Swift.Apprentice.v1.1[书摘]"
category: iOS
date: 2015-12-24 12:15
---

对于这本书，我是抱着复习还有总结的心态看的。把没见过的，或者感觉写的少的。摘录下来。


###Chapter 1: Coding Essentials &
 
 
####计算机是如何工作的

计算机的核心是一个CPU。这基本上是一台数学机器。它执行加法，减法和其他算术操作数。你看到的一切当你操作计算机的时候都是建立在每秒百万次运算的CPU上。

CPU上面存储数字的最小存储器单元称之为寄存器。CPU能从计算机的主存储器中读取数字，叫做随机存储器。

 Editor\Execute Playground

### Chapter 4: Strings

#### 两种转换成String的方法
String 的显示转换

```
let exclamationMark: Character = "!"
message += String(exclamationMark) // "Hello my name is Matt!"
```

插值

```
￼let name = "Matt"
let message = "Hello my name is \(name)!" // "Hello my name is Matt!"
```

####Unicode

计算机只能处理1跟0那么字符串都是 字符对应数字，于是有了字符集。双向映射。Unicode 它定义了几乎所有的计算机使用的字符集映射。

有些语言认为下面的是不相等的，但是swift默认相等，因为它们在逻辑上是相等的

```
let stringA = "café"
let stringB = "cafe\u{0301}"

let equal = stringA == stringB  //equal = true
// 它们的count、都是 4，这是因为显示出来都是四个
stringA.characters.count
stringB.characters.count
```

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

###Chapter 10: Arrays

#### 数组声明

显示

let numbers: Array<Int>

推断

let inferredNumbers = Array<Int>()

let alsoInferredNumbers = [Int]()

#####字面量

```
let evenNumbers = [2, 4, 6, 8]

```

```
let allZeros = [Int](count: 5, repeatedValue: 0)// > [0, 0, 0, 0, 0]
```
#### 元素访问

var players = ["Alice", "Bob", "Cindy", "Dan"]

##### 常用方法

返回最小值

players.minElement()


#####使用range

```
let upcomingPlayers = players[1...2]print(upcomingPlayers)
```

#### 枚举遍历

如果你需要每个元素的索引，你可以遍历数据中的enumerate()方法返回的值，并返回一个数组中 的索引，每个元素的值的元组。

```
for (index, playerName) in players.enumerate() {
    print("\(index + 1). \(playerName)")
}
```

#### Sequence operations

##### Reduce 

reduce(_:combine:) 需要一个初始值作为第一个参数，并且返回积累的值。

```
var  scores = [75,86,89,99,100, 1]
let sum = scores.reduce(0, combine: +)
print(sum)
```

类似  let sum = 0 + scores[0] + scores[1] + ... + scores[5].
 

##### Filter  

返回一个过滤后的数组。唯一的参数是返回布尔值的闭包。并且它将在数组中的每个元素执行这个闭包。如果闭包返回true，把这个元素添加到返回数组中。否则忽略该元素。

```
print(scores.filter({ $0 > 5 }))
```
##### Map

map(_:) 需要一个闭包参数。将每一个 值映射到一个新值。

```
let newScores = scores.map({ $0 * 2 })
print(newScores) // "[150, 172, 178, 198, 200, 2]\n"
```

#### 时间复杂度

访问元素： 复杂度O(1)

插入元素：

* 添加到开头，O(1)
* 添加到中间，因为该索引之后的索引都会往后移动，O(N)
* 末端添加一个，是O(1).如果没有控件，需要腾出控件，并在其他地方复制整个数组，然后添加。然后复杂度是O(N)。平均复杂度为O(1)
    
删除元素：
  
* 删除头跟尾部元素复杂度是O(1)
* 如果删除中间元素，复杂度是O(N)
 
搜索元素： 复杂度O(N)











