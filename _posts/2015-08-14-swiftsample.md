---
layout: post
title:  "Swift2.0简单语法回顾"
category: swift
date: 2015-08-14
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

### 类型安全和类型推断

Swift 是类型安全的，它会在编译你的代码时进行类型检查（type checks），把不匹配的类型标记为错误。这样在写代码的时候，会尽快发现并修复错误。

Swift使用类型推断（type inference）选择合适类型。原理很简单，只要检查你赋的值即可。

### 数据类型转换

Swift 不像OC那样支持隐式转换。类型不同无法运算。

####整数转换

```
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandPlusOne = twoThousand + UInt16(one)
```
#### 整数和浮点数转换

```
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
```
###类型别名

类型别名（type aliases）就是给现有类型定义一个名字。使用`typealias`关键字来定义类型别名。是不是让你想起了OC中的，`typedef`了？

```
typealias int = Int
```
定义了一个类型的别名之后，你就可以在任何使用原始名的地方使用别名了。

###元组

元组(tuples)把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求相同类型

元组访问，可以通过下标访问。也可以通过元素名访问。

```
let result = (true, "查询到的结果集")
let receiveResult =  result
print(receiveResult.0)
print(receiveResult.1)
```
```
let result = (status: false, data: "错误的状态码或者提示")
print(result.0)
print(result.data)

````

如果你只需要一部分的元组值，分解的时候可以把要忽略的部分用下划线（_）标记：

```
let (status, _) = result
print(status)
```

使用元组交换变量

```
func swapMe<T>(inout a: T, inout b: T) {
    (a, b) = (b, a);
}
```

元组作为函数返回值非常有用。比如用元组做错误处理。

```
func doSomethingMightCauseError() -> (Bool, NSError?){
    // 做某些操作，成功结果放在success中
    if success {
        return (true, nil);
    } else {
        return (false, NSError(domain: "domain", code: 1, userInfo: nil));
    }
}
```
### 可选类型

使用可选类型（optionals）来处理值可能缺失的情况。

一个可选类型的`Int`被写作`Int?`而不是`Int`。问号暗示包含的值是可选类型，也就是说可能含`Int`值也可能不包含值。（不能包含其他任何值比如`bool`值或者`String`值。只能是`Int`或者什么都没有）

#### nil

你可以给可选变量赋值为`nil`来表示它没有值：

```
var a: String?
print(a) // 不赋值，打印出来就是 nil
```
nil 不能用于非可选变量和变量。

Swift的nil和OC中的nil不同。OC中，nil是一个指向不存在对象的指针。Swift中，nil不是指针，它是一个确定的值，用来表示值缺失。

####if 语句以强制解析

使用`if`语句和 nil比较来判断一个可选值是否包含值。可以使用 “相等”（==）或“不等”（!=）来执行比较。

####可选绑定（optional binding）

可选绑定判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。

#### 隐式解析可选类型
有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型总会有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。

这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（`String`）改成感叹号（`String!`）来声明一个隐式解析可选类型。

当可选类型被第一次赋值之后就可以确定之后一直有值的时候，隐式解析可选类型非常有用。`隐式解析可选类型主要被用在Swift中类的构造过程中`。

一个隐式解析可选类型其实就是一个普通的可选类型，但是可以被当作非可选类型来使用，并不需要每次都使用解析来获取可选值。下面的例子展示了可选类型`String`和隐式解析可选类型`String`之间的区别：

```
let a: String?
a = "letter a"
print(a!) // 取值要解包 

let b: String!
b = "letter b"
print(b)
```

ps.比较常见的隐式解包的Optional就是用IB创建的IBOutLet了，我们的代码其他部分，还是少用这样的隐式解包的Optional微妙。（`详情见王巍的书`）

### 断言

`断言`会在运行时判断一个逻辑条件是否为true。为true继续执行代码。为false，终止当前的程序。你可以使用断言来保证在运行其他代码之前，某些重要的条件已经被满足。

####何时使用断言

适用情景：

* 检测数组的

###基本运算符

Swift 支持大部分标准C语言的运算符，且改进许多特性来减少常规编码错误。比如：`=`不返回值。`+、-、*、/、%`等会检测并不允许值溢出，以此来避免保存变量时由于变量大于或小于其类型最大，最小值的异常结果。如果想溢出呢有`溢出运算符`。区间运算符`a..<b`和`a...b`。

当然还有一些高级运算符，如何自定义运算符，以及如何进行自定义类型的运算符重载。

####术语

运算符有一元、二元和三元运算符。

* 一元运算符。前置运算符和后置运算符。`-a`、`!b`、`i++`、`--i`等

* 二元运算符。`a * b`、`a -= b`等

* 三元运算符。三目运算符。

#### 赋值运算符

如果赋值的右边是一个多元组，它的元素可以马上被分解成多个常量或变量。

```
let (a, b) = ("七"=, "夕" );

//a + b 等于 "七夕"
```

与C跟OC不同的是，Swift赋值操作不返回任何值（这个特性使你无法把`==`错写成`=`）：

```
if a = b {} // 这是错误的写法
```
#### 复合赋值(Ternary Conditional Operator)

其他运算符和赋值运算符组合的复合赋值运算符，比如组合加运算`+=`。

#### 空和运算符(Nil Coalescing Operator)

空合运算符（`a ?? b`）将可选类型`a`进行空判断，如果`a`包含一个值就进行解封，否则就返回一个默认值`b`。

这个运算符有两个条件：

* 表达式`a`必须是Optional类型
* 默认值`b`的类型必须要和`a`存储值的类型保持一致

相当于如下代码：

```
a != nil ? a! : b
```

如果a为非空值（non-nil），那么值b将不会被估值。所谓的短路求值。

#### 区间运算符

* 闭区间运算符。`a...b`,`b`必须大于等于`a`。

* 半开区间运算符。`a..<b`。

#### 逻辑运算

* 逻辑非`!a`
* 逻辑与`a && b`（短路运算short-circuit evaluation）
* 逻辑或`a || b`

### 字符串和字符

`String`和`NSString`进行了无缝桥接。可以将任何字符串转成`NSString`，并调用任意的`NSString`API。你也可以在任意要求传入NSString实例作为采纳书的API中用String类型的值代替。


#### 初始化空字符串

```
var emptyString = ""

var anotherEmptyString = String()
// 两个字符串均为空等价

emptyString.isEmpty 通过isEmpty 检测字符串是否为空
```
#### 字符串是值类型（Value Types）

创建的字符串，当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。在任何情况下，都会对已有的字符串值创建新副本，并对该新副本进行传递或赋值操作。值类型在`结构提和枚举是值类型`中进行了详细的描述。

> 与`NSString` 不同，创建的NSString实例，传递给一个函数/方法，或者是赋值给一个变量，你传递或者赋值的是该NSString实例的一个引用，除非特别要求进行值拷贝，否则字符串不会生成新的副本来进行赋值操作。

在实际编译时，编译器会优化字符串的使用。使实际的复制只发生在绝对必要的情况下，意味着您将字符串作为值类型的同时可以获得极高性能。

#### 使用字符

```
let c: Character = "c"

let cs:[Character] = ["c", "h","a"];
```

#### 字符串插值（String Interpolation）

字符串插值是一种构建新字符串串的方式，可以在其中包含常量、变量、字面量和表达式。插入的字符串字面量的每一项都是在以反斜线为前缀的圆括号中：

```
let niu = "牛郎"

let qx = "\(niu)爱织女"

print(qx)
```

####访问和修改字符串

你可以通过字符串的属性和方法来访问和读取一个它，当然也可以用下标语法完成

##### 字符串索引（String Indices）

每一个字符串都有一个关联的索引类型，String.index,对应着字符串中的每一个字符串的位置。

前面提到，不同的字符可能会占用不同的内存空间数量，所以要知道字符的确定位置，必须从字符串开头遍历每一个Unicode标量到字符串结尾i。因此Swift 的字符串不能用整数（integer）做索引。

使用`startIndex`属性可以获取字符串第一个字符。使用`endIndex`属性可以获取最后的位置（其实endIndex在值上与字符串的长度相等）。如果字符串是空值，`startIndex`和`endIndex`是相等的。

通过调用String.index的predecessor()方法，可以获得前面一个索引，调用successor()方法可以立即得到后面一个索引。任何一个字符串的索引都可以通过锁链作用的这些方法来获取另一个索引，也可以调用advance(start:n:)函数来获取。越界获取会报运行时错误。

```
let qixi = "qixi jie ri"

print(qixi.startIndex)

print(qixi.endIndex)

print(qixi[qixi.startIndex])

let index = advance(qixi.startIndex, 4)

print(index)
print(qixi[index])

qixi[qixi.endIndex] // error
qixi[qixi.endIndex.successor()] // error
```
使用全局函数indices 会创建一个包含全部索引的范围（Range），用来在一个字符串中访问分立的字符。


####追加、插入和删除

直接使用 +

使用 append()方法

调用insert(_:atIndex:)：在指定索引插入一个字符。

调用splice(_:atIndex:)方法可以在一个字符串的指定索引插入一个字符串。

调用removeAtIndex(_:)撒谎拿出指定索引的字符串

调用removeRange(_:)删除指定范围的字符串


####比较字符串

Swift提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等
 
字符串/字符可以用等于操作符`==`和不等于操作符`!=`

如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等的，那就认为它们是相等的。在这种情况下，即使可扩展的字形群集是有不同的Unicode标量构成的，只要它们有同样的语言意义和外观，就认为它们标准相等。

前后缀相等，使用`hasPrefix(_:)`跟`hasSuffix(_:)`方法来检查字符串是否拥有特定前缀/后缀。






###集合类型（Collection Types）

Swift提供了Arrays、Sets、Dictionaries三种基本的集合类型用来存储集合数据。数组是有序数据的集。集合是无序无重复数据的集。字典是无序的键值对的集。Swift中它们存储的数据值类型必须明确。不能把不正确的数据类型插入其中。

> Swift 的Arrays、Sets和Dictionaries类型被实现为泛型集合。


####数组

数组使用有序列表存储同意类型的多个值。相同的值可以多次出现在一个数组的不同位置中。

创建一个空数组`var kong = [String]()`

####通过两个数组相加创建一个数组

```
let j = [1, 3, 5, 7]
let o = [2, 4, 6]

print(j+o)
```
#### 访问和修改数组

使用`count`看元素的个数，使用isEmpty 检查数组的count 是否为0

使用append 追加数组元素

使用下标访问数组的数据项。

使用下标改变多个数组值，即使新数据和原有数据的数量是不一样的。

> 不可以用下标访问的形式在数组尾部提添加新项。

####数组的遍历

`enumerate`方法：返回一个每个数据项索引值和数组值组成的元组。我们可以把这个元组分解成临时常量或者遍历进行遍历：

####集合

集合Set用来存储相同类型并且没有确定顺序的值。当集合元素不重要的时或者希望确保每个元素只出现一次时可以把集合当作是数组的另一种形式。

####字典
Swift 的字典使用Dictionay<Key, Value>定义，其中Key是字典中键的数据类型。Value是字典中对应于这些键所存储值的数据类型。也可以使用[Key: Value]的方式定义。

> 一个字典的key类型必须遵循Hashable协议，就像Set 的值类型。

####读取和修改字典

通过字典的只读属性count 获取字典的数据项数量，使用isEmpty检查字典的count属性是否等于0。

使用update(_:forKey:)方法可以设置或者更新特定键对应的值。这个方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的值。dic[key] = newValue 不同的是这个方法会返回更新之前的原值。这样方便我们检查是否更新成功。返回是可选类型的值。

我们可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里删除一个键值对，此外，也可以使用`removeValueForKey()`。这个方法会在键值对存在的情况下移除该键值对。并且返回被移除的值或者在没有值的情况下返回nil；

####字典遍历

Swift 的字典是无序的。那么可以对字典的keys或values 属性使用sort方法排序。那么就能按照特定顺序遍历了。

### 控制流

swfit 中的Switch 比C更强大。不用写break。case可以匹配更多的类型模式，包括区间匹配，元组和特定类型的描述。case语句中匹配的值可以是由case体内部临时常量或者变量决定，也可以由where分句描述更复杂的匹配条件。

####循环
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
####条件语句

#####If
OC中是 YES/NO ，swift 中是 true / false， swift 没有非零即真的概念

```
var a = 1;
var b = 1;
if a == b{
	print("a=b");
}
```
#####switch

#####不存在隐式的贯穿（No Implicit Fallthrough）

> 如果想要贯穿至特定的case分支

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
* 《Swifter - 100 个 Swift 必备 tips 》 作者王巍 <https://leanpub.com/swifter/read>



