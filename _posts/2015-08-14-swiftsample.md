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

> 如果想要贯穿至特定的case分支中，请使用`fallthorough`

##### 区间匹配

##### 元组

可以是哟更元组在同一个`switch`语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线`_`来匹配所有的可能的值。

```
let screenPosition = (10,10)
switch screenPosition {
    case (10, 10):
        print("在所在管理区域One")
    case (0...10, 10...20):
        print("在所在管理区域Two")
    case (_,10):
        print("在所在管理区域Three")
    default:
        print("默认处理")
}
虽然三个case都满足，但是只是执行满足的第一个case。

```
##### 值绑定（Value Bindings）
case分支的模式允许将匹配的值绑定到一个临时的常量或变量，这些常量或变量在该case分支里就可以被引用了——这种行为被称为值绑定。

```
let screenPosition = (10,10)

switch screenPosition {
    case (let x, 10):
        print("x=\(x)")
    case (0, let y):
        print("y=\(y)")
    case (let x, let y):
        print("x=\(x),y=\(y)")
}

```
注意，这个`switch`语句不包含默认分支。这是因为最后一个case——`case let(x, y)`声明了一个可以匹配余下所有值的元组。这使得`switch`语句已经完备，因此不需要再书写默认分支。

#####Where
case 分支的了模式可以使用where 语句来判断额外的条件。

### 控制转移语句（Control Transfer Statements）
控制转移语句改变你代码的执行顺序，通过它你可以实现现代码的跳转。Swift有四种控制转移语句。

* continue
* break
* fallthrough
* return
* throw

#### Continue

告诉一个循环体停止本次循环迭代，重新开始下次循环迭代。

#### Break

立即结束整个控制流的执行。当你想要更早的结束一个`switch`代码块或者一个循环体时，都可以使用break语句。

#####循环语句中的break

当在一个循环体中使用break时，会立刻中断该循环体执行。然后跳转到表示循环体结束的大括号`}`的第一行代码。不会再有本次循环迭代的代码被执行，也不会再有下次的循环迭代产生。

#####Switch 语句中的break

当在一个`Switch`代码块中使用break时，会立即中断该Switch代码块的执行，并且跳转到表示Switch代码块结束的大括号`}`后的第一行代码。

#### 贯穿（FallThrough）

#### 带标签的语句

> label name:While condition {statements}

#### 提前退出

像`if`语句一样，`guard`的执行取决于一个表达式的布尔值。我们可以使用`guard`语句的代码。不同于`if`语句，一个`guard`语句总是有一个`else`分句，如果条件不为真则执行`else`分局中的代码。

相比于可以实现同样功能的if语句，按需使用guard语句会提升我们代码的可靠性，它可以使你的代码连贯的被执行而不需要将它包在else块中，可以使你处理违反要求的代码接近要求。

###函数（Functions）

* 函数定义与调用
* 函数参数与返回值
* 函数参数名称
* 函数类型
* 函数嵌套

函数使用来完成特定任务的独立代码块。Swift统一的函数语法足够灵活，可以用来表示任何函数，包括从最简单的没有参数名字的C风格函数，到复杂的带局部和外部参数名的OC风格函数。参数可以提供默认值，以简化函数调用。参数也可以既当传入参数，也当做传出参数，也就是说，一旦函数执行结束，传入的参数值可以被修改。

在Swift中，每个函数都有一种类型，包括函数的参数值类型和返回值类型。你可以把函数类型当作任何其他普通变量类型一样处理，把函数当成别的函数的参数，或者从其他函数中返回函数。

####函数的定义与调用


#####无返回值函数
> 无返回值函数，虽然没有返回值被定义，但是没有定义返回类型的函数会返回特殊的值，叫`void`。其实它是一个空的元组，没有任何元素，可以写成`()`。

#####多重返回值函数
可以使用元组让多个值作为一个复合值从函数中返回。

需要注意的是，元组成员不需要在函数中返回时命名，因为他们的名字已经在函数返回类型中有了定义。

#####可选元组返回类型
如果函数返回的元组类型中有可能在整个元组中含有“没有值”，你可以使用可选的（Optional）元组返回类型反映整个元组可以是`nil`的事实。

>注意：可选元组类型如`(Int, Int)?`与元组包含可选类型属性如`(Int?, Int?)`是不同的。可选的元组类型，整个数组是可选的，而不只是元组中的每个元素值。

####函数参数名称
函数参数都有个外部参数名和一个本定参数名。外部参数名用来标记给函数的参数，本地参数名在实现函数的时候使用。

通常，第一个参数省略其外部参数名，第二个以后的参数使用其本地参数名作为自己的外部参数名。所有参数需要有不通过的本地参数名，可以共享外部参数名。

#####指定外部参数名（Specifying External Parameter Names）

可以在本地参数名前指定外部参数名，中间以逗号分隔。

> 如果你提供了外部参数名，那么函数在被调用的时，必须使用外部参数。

```
func run(withName name:String, age: Int) {
    print(name)
}
run(withName: "刘翔", age: 23)
```
#####忽略外部参数名（Omitting External Parameter Names）

如果你不想为第二个及后续的参数设置参数名，用一个下划线`_`代替一个明确地参数名。

```
func run(withName name:String, _ age: Int) {
    print(name)
}
run(withName: "刘翔", 23)
```
#####默认参数值
> 默认参数放到参数列表的最后。

##### 可变参数（Variadic Parameters）

一个`可变参数`可以接受零个或多个值。函数调用时，你可以用可变参数来传入不确定数量的输入参数。通过在变量类型后面加入`...`的方式来定义可变参数。

传入可变参数的值在函数体内当作这个类型的一个数组。

> 最多可以有一个可变参数函数，和它必须出现在参数列表中，为了避免歧义在调用函数有多个参数。如果你的函数有一个或者多个参数有默认值，还可以有一个可变的参数将可变参数写在参数列表的最后。

#####常量参数和变量参数

函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。
```
func mathOperation(operation:(a: Int, b: Int) -> Int) {
    let aa = 10;
    let bb = 10;
    print(operation(a: aa, b: bb))
}

mathOperation { (a, b) -> Int in
    a + b
}
注意：aa必须是let ，因为传递给 operation使用，函数参数是常量
```

但是，有时候，如果函数中有传入参数的变量值副本将是很有用的。你可以通过指定一个或多个参数为变量参数，从而避免自己在函数中定义新的变量。变量参数不是常量，你可以在函数中把它当作心得可修改副本来使用。

通过在参数名前加关键字`var`来定义变量参数：

#####输入输出参数（In-Out parameters）

变量参数，正如上面所述，仅仅能在函数体内被修改。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束之后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。

定义一个输入输入参数时，在参数定义前加`inout`关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。

你只能将变量作为输入输出参数。你不能传入常量或者字面量（literal value），因为这些量是不能修改的。当传入的参数作为输入输出参数时，需要在参数前加`&`符，表示这个值可以被函数修改。

> 注意：输入输出参数不能有默认值，而且可变参数不能用`inout`标记。如果你用`inout`标记一个参数，这个参数不能被`var`或者`let`标记。输入输出参数是函数对函数体外产生影响的另一种方式。

####函数类型
每个函数都有种特定的函数类型，由函数的参数类型和返回类型组成。

```
func plus(a: Int, _ b: Int) -> Int{
    return a + b
}
print(plus(1, 2))
```
plus函数代码中`(Int, Int) -> Int`可以读做这个函数的类型。有两个`Int`型的参数并返回一个`Int`型的值。

#####使用函数类型

在Swift中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将函数赋值给它：

```
var add = plus

print(add(3, 5))
```
##### 函数类型作为参数类型

你可以用`(Int, Int) -> Int`这样的函数类型作为另一个参数的参数类型。这样你可以将函数的一部分实现交由给函数的调用者：
```
func mathOperation(operation:(Int, Int) -> Int, _ a: Int, _ b: Int) {
    print(operation(a, b))
}
mathOperation(add, 30, 20)
```
mathOperation函数的作用就是输出另一个合适类型的数学函数的调用结果。不用关心函数是如何实现的，只关心这个传入的函数类型是正确的。这使得mathOperation可以以一种类型安全的方式来保证传入函数的调用是正确的。

#####函数类型作为返回类型

函数类型作为另一个函数的返回类型。需要做的是在返回箭头`->` 后写一个完整的函数类型。

```
func plus(a: Int, _ b: Int) -> Int{
    return a + b
}

func minus(a: Int, _ b: Int) -> Int{
    return a - b
}
func devide(a: Int, _ b: Int) -> Int{
    return a / b
}

func manageOperation(symbol: String) ->(Int, Int)->Int {
    switch symbol {
        case "+":
            return plus
        case "-":
            return minus
        default:
            return devide
    }
}

manageOperation("*")(30, 30)
```
你可以通过 manageOperation获得一个函数，根据你的需要。

####嵌套函数（Nested funcions）

这章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。把函数定义在别的函数体中，称作嵌套函数（nested functions）。

默认情况下，嵌套函数是对外界不可见的，但是可以被它们封闭函数（enclosing function）来调用。一个封闭函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。


```
func manageOperation(symbol: String) ->(Int, Int)->Int {
    func plus(a: Int, _ b: Int) -> Int{
        return a + b
    }
    
    func minus(a: Int, _ b: Int) -> Int{
        return a - b
    }
    func devide(a: Int, _ b: Int) -> Int{
        return a / b
    }

    switch symbol {
        case "+":
            return plus
        case "-":
            return minus
        default:
            return devide
    }
}
manageOperation("*")(30, 30)
```























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



 
### 可选类型 Optional

声明方式：类型+？ 

好处：如果没有赋值，就给个nil，打印出来就是 `nil`。那么，如果不是可选类型，不赋值无法使用，报错提示你 `变量没有赋值`

```
var str1 : String?
str1 = "swift2.0";
print(str1);	// 打印出来是 Optional("swift2.0")
print(str1!); // 打印出来是 swift2.0 ! 是解包的意思 
```
 

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



