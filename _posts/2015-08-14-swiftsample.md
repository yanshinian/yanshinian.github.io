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

###闭包

* 闭包表达式 （Closure Expressions）
* 尾随闭包 （Tailing Closures）
* 值捕获 （Capturing Values）
* 闭包是引用类型（Closures Are Reference Types）

闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift中的闭包与C和OC中的代码块（blocks）以及其他一些编程语言中的lambdas函数比较相似。

闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭合并包裹着常量和变量，俗称闭包。Swift会为你管理在捕获过程中涉及到的所有内存操作。

在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一：

* 全局函数是一个有名字但不会捕获任何值的闭包
* 嵌套函数是一个有名字并可以捕获并封闭函数域内值的闭包
* 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

Swift的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化， 主要优化如下：

* 利用上下文推断参数和返回值类型
* 隐式返回但表示闭包，既单表达式闭包可以省略可以省略`return`关键字
* 参数名称缩写
* 尾随（Trailing）闭包语法

####闭包表达式（closure Expressions）

嵌套函数 是一个在复杂函数中方便进行命名和定义自包含代码块的方式。当然，有时候撰写小巧的没有完整定义和命名的类函数结构也是很有用处的，尤其是处理一些函数并需要将另外一些函数作为该函数的参数时。

闭包表达式是一种利用简洁语法构建内联闭包的方式。闭包表达式提供了一些语法优化，使得撰写闭包变得简单明了。


#####sort函数

Swift标准库提供了名为`sort`的函数，会根据您提供的用于排序的闭包函数将已知类型数组中的值进行排序。一旦排序完成，`sort(_:)`方法会返回一个与原数组大小相同，包含同类型元素且元素已正确排序的新数组。原数组不会被`sort(_:)`方法修改。

下面，我们对字母数组进行逆序排序
```
let letters = ["A", "B", "C", "D", "E", "F", "G"];
```

`sort(_:)`方法需要传入两个参数：

* 已知类型的数组
* 闭包函数，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面，排序闭包函数需要返回`true`，反之返回`fasle`。

该例子对一个String类型的数组进行排序，因此排序闭包函数类型需为`(String, String) -> Bool。`（api`public func sort(@noescape isOrderedBefore: (Self.Generator.Element, Self.Generator.Element) -> Bool) -> [Self.Generator.Element]`）

提供排序的闭包函数的一种方式是撰写一个复合其类型要求的普通函数，并将其作为`sort(_:)`方法的参数传入：

```

func backwards(l1: String, l2: String) ->Bool {
    return l1 > l2
}

var reversed = letters.sort(backwards)
```
如果第一个字符串`l1`大于第二个字符串`l2`，`backwards`函数返回`true`，表示在心得数组中`l1`应该出现在`l2`前。对于字符串中的字符来说，“大于”表示“按照字母顺序较晚出现”。

这种写法还是有些冗长，本质上只是写了一个单表达式函数（a > b）。在下面的例子中，利用闭合表达式语法可以更好的构造一个内联排序闭包。

#### 闭包表达式语法（Closure Expression Syntax）

闭包表达式语法有如下一般形式：

```
{ (parameters) -> returnType in
	statements
}
```
闭包表达式语法可以使用常量、变量和`inout`类型作为参数，不提供默认值。也可以在参数列表的最后使用可变参数。元组也可以做为参数和返回值。

下面的例子展示了之前`backwards`函数对应的闭包表达式版本的代码：

```
reversed = names.sort({ (s1: String, s2: String) -> Bool in 
	return s1 > s2
})
```
需要注意的是内联闭包参数和返回值类型声明与`backwards`函数类型声明相同。在这两种方式中，都写成了`(l1: String, l2: String) -> Bool`.然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。

闭包函数体部分由关键字`in`引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。

因为这个闭包的函数体部分如此短一枝花与可以将其该写成一行代码：



这说明`sort(_:)`方法的整体调用保持不变，一对圆括号仍然裹住了函数中整个参数集合。而其中一个参数现在变成了内联闭包


####根据上下文推断类型（Inferring Type From Context）

因为排序闭包函数是作为`sort(_:)`方法的参数进行传入的，Swift可以推断其参数和返回值的类型。`sort`期望第二个参数是类型为`(String, String) -> Bool`的函数，因此实际上`String，String`和`Bool`类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头`->`和围绕在参数周围的括号也可以被省略：

```
reversed = letters.sort {l1, l2 in return l1 > l2}

reversed = letters.sort ({l1, l2 in return l1 > l2})
```
实际上任何情况下，通过内联闭包表达式构造的闭包作为参数传递给函数时，都可以推断出闭包的参数和返回值类型，这意味着你几乎不需要利用完整格式构造任何内联闭包。

如果完整格式的闭包能够提高代码的可读性，则可以采用完整格式的闭包。而在`sort(_:)`方法这个例子里，闭包的目的就是排序，读者能够推测出这个闭包是用于字符串处理的，因为闭包是为了处理字符串数组的排序。

#####单表达式闭包隐式返回（Implicit Return Single-Expression Clossures）

单行表达式闭包可以通过隐藏`return`关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：

```
reversed = letters.sort ({l1, l2 in l1 > l2})
```
这个例子中，`sort(_:)`方法的第二个参数函数类型明确了闭包必须返回一个`Bool`类型值。因为闭包函数体只包含了一个单一表达式`l1 > l2`，该表达式返回`Bool`类型值，因此这里没有歧义，`return`关键字可以省略。

##### 参数名称缩写（Shorthand Argument Names）

Swift 自动为内联函数提供了参数名称缩写功能，可以直接通过`$0，$1,$2`来顺序调用闭包的参数。

如果在闭包表达式中使用参数名称缩写，可以在闭包参数列表中省略对其的定义，并且对应参数名称缩写的类型会通过函数类型进行推断。`in`关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：

```
reversed = letters.sort({ $0 > $1 }) // $0 和 $1表达闭包中第一个和第二个String类型的参数
```
##### 运算符函数（Operator Functions）

实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。Swift中的`String`类型定义了关于大于号`>`的字符串实现，其作为一个函数接受两个`String`类型的参数并返回`Bool`类型的值。而这正好与`sort(_:)`方法的第二个参数需要的函数类型相符合。因此，可以简单的传递一个大于号，可以自动推断出你想使用大于号的字符串函数实现。
```
revered = letters.sort(>)
```
####尾随闭包 （Trailing Closures）

如果需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。

```
// 以下是不使用尾随闭包进行函数调用
bibao({
    
    
})

// 以下是用尾随闭包
bibao(){

}
bibao { () -> Void in
    
}



我们拿UIView的一个动画举例
public class func animateWithDuration(duration: NSTimeInterval, animations: () -> Void) 

// 一般 调用
UIView.animateWithDuration(0.75, animations: {
    print("哈哈嘿嘿")
})
// 尾随 闭包 调用
UIView.animateWithDuration(0.75) { () -> Void in
    print("哈哈")
}
// 尾随 闭包 简化
UIView.animateWithDuration(0.75) { () in
    print("哈哈嘻嘻")
}
UIView.animateWithDuration(0.75) {  _ in
    print("哈哈嘻嘻哇哇")
}
UIView.animateWithDuration(0.75) {
    print("哈哈嘻嘻哇哇咔咔")
}
```
> 注意：如果函数只需要闭包表达式一个擦描述，当你使用尾随闭包时，甚至可以把（）省略掉
```
上面的bibao函数调用可以这样简化
bibao{

}
上面的sort函数可以这样简化

reversed = letters.sort(){ $0 > $1 }
reversed = letters.sort{ $0 > $1 }
```
当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用。举例来说，Swift的`Array`类型有一个方法，其获取一个闭包表达式作为其唯一参数。数组中的每一个元素调用一次该闭包函数。并返回该元素所映射的值（也可以是不同类型的值）。具体映射方式和返回值类型由闭包来指定。

当提供给数组闭包函数后，`map` 方法将返回一个新的数组，数组中包含了与原数组一一对应的映射后的值。

下例介绍了如何在`map`方法中使用尾随闭包将`Int`类型数组`[16,58,510]`转换为对应的`String`类型的数组`["OneSix, "FiveEight", "FiveOneZero"]`:

```

```
如上代码创建了一个数字位和他们名字映射的英文版本字典。同时定义了一个准备转换为字符串的整型数组。

现在可以通过传递一个尾随闭包给`numbers`的`map`方法来创建对应的字符串版本数组。需要注意的是调用`number.map`不需要在`map`后面包含任何括号，因为其只需要传递闭包表达式这样一个参数，并且该闭包表达式参数通过尾随方式进行撰写：

```

```

#### 捕获值（Capuring Values）

闭包可以在其定义的上下文捕获常量或变量。即使定义这些常量和变量的原域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。

Swift最简单的闭包形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。

下例为一个叫做`makePlus`的函数，其包含了一个叫做`plus`嵌套函数。嵌套函数`plus`从上下文中捕获了两个值，`a`和`b`。之后`makePlus`将`plus`作为闭包返回。每次调用`plus`时，其会以`b`作为增量增加`a`的值。

```
func makePlus(b: Int) -> () -> Int {
    var a = 0;
    func plus() -> Int {
        a += b;
        return a
    }
    return plus
}
```
`makePlus`返回类型为`() -> Int`。这意味着其返回的是一个函数，而不是一个简单类型值。该函数在每次调用时不接受参数只返回一个`Int`类型的值。

####闭包是引用类型（Closures Are Reference Types）


### 枚举（Enumerations）

* 枚举语法（Enumeration Syntax）
* 匹配枚举值与Switch语句（Matching Enumeration Values）
* 相关值（Associated Values）
* 原始值（Raw Values）
* 递归枚举（Recursive Enumerations）

枚举定义了一个通用类型的一组相关值，使你可以在你的代码中以一种安全的方式来使用这些值。

如果你熟悉C语言，就会知道，在C语言中枚举将枚举名和一个整型值相对应。Swift中的枚举更加灵活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是字符串，字符或是一个整型值或浮点数。

此外，枚举成员可以指定任何类型的相关值存储到枚举成员值中，就像其他语言中的联合体`unions`和变体`variants`。你可以定义一组通用的相关成员作为枚举的一部分，没一组都有不同的一组与它相关的适当类型的数值。

在Swift中，枚举类型是一等公民（first-class）。它们采用了很多传统上只被类（class）所支持的特征，例如计算型属性（computed properties），用于提供关于枚举当前值的附加信息，实例方法（instancemethods），用于提供和枚举所代表的值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始的实现基础上扩展它们的功能；可以遵守协议（protocols）来提供标准的功能。

####枚举语法

使用`enum`关键词来创建枚举并且把它们的整个定义放在一对大括号内：

```
枚举，春夏秋冬
enum Season {
    case Spring
    case Summer
    case Autumn
    case Winter
}```
一个枚举中被定义的值（例如`Spring`,`summer`,`autumn`和`winter`）是枚举的成员值（或者成员）。`case`关键词表明新的一行成员值将被定义。

>注意：和C和OC不同，Swift的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的`Season`例子中，`spring`、`summer`等这四个成员不会隐式的赋值为了0，1，2和3。相反的，这些不同的枚举成员在`Season`的一种显示定义中拥有各自不同的值。

多个成员值可以出现在同一行上，用逗号隔开：

```
enum season {
	case Spring,Summer,Autumn,Winter
}
```
每个枚举定义了一个全新的类型。像Swift中其他类型一样，它们的名字必须以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字，以便于读起来更加容易理解：

```
var currentSeason = Season.Autumn
```
currentSeason的类型可以在它被`Season`的一个可能值初始化时推断出来。一旦`currentSeason`被声明为一个`Season`，你可以使用一个缩写语法`.`将其设置为另一个`Season`的值：

```
currentSeason = .Winter
```
当`currentSeason`的类型已知时，再次为其赋值可以省略枚举名。使用显式类型的枚举值可以让代码具有更好的可读性。

####匹配枚举值和Switch语句

使用`switch`语句匹配单个枚举值：

```
switch currentSeason {
case .Spring:
    print("春天花会开")
case .Summer:
    print("夏天大腿白")
case .Autumn:
    print("秋天看落叶")
case .Winter:
    print("冬天玩雪人")
}
```
在判断一个枚举类型的值时，`switch`语句必须穷举所有情况。如果忽略了`.West`这种情况，上面那段代码将无法通过编译，因为它没有考虑到`Season`的全部成员。强制性全部枚举的要求确保了枚举成员不会被意外遗漏。

当不需要匹配每个枚举成员的时候，可以提供一个默认的`default`分支来涵盖所有未明确被提出对的枚举成员：

```
switch currentSeason {
case .Spring:
    print("春天花会开")
case .Summer:
    print("夏天大腿白")
case .Autumn:
    print("秋天看落叶")
default:
    print("咦，冬天呢？")
}
```

####相关值（Associated Values）


#### 原始值 （Raw Values）
枚举成员默认（称为原始值）赋值，这些原始值具有相同类型。

```
enum Letter: Character {
    case a = "a"
    case b = "b"
    case c = "c"
}
```
这里`Letter`的枚举类型的原始值类型被定义为字符型`Character`，并被设置了一些比较常见字母。

原始值可以是字符串，字符，或者任何整型值或浮点型值。每个原始值在它的枚举声明中必须是唯一的。

> 原始值和相关值是不同的。

#####原始值的隐藏赋值（Implicitly Assigned Raw Values）


###类和结构体

* 类和结构体对比
* 结构体和枚举是值类型
* 类是引用类型
* 类和结构体的选择
* 字符串、数组和字典类型的赋值与复制行为

类和结构体是人们构建代码所用的一种同游且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量）和添加方法，从而扩展类和结构体的功能。

与其他语言不同的是，Swift并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或者结构体，系统将会自动生成面向其他代码的外部接口。

> 注意：通常一个`类`的实例被称为`对象`。然而在Swift中，类和结构体的关系要比在其他语言中更加的密切，本章中所讨论的大部分功能可以用在类和结构上。因此，我们主要的使用`实例`而不是`对象`

####类和结构体对比

Swift中类和结构体有很多共同点。共同之处在于：

* 定义属性用于存储值
* 定义方法用于提供功能
* 定义附属脚本用于访问值
* 定义构造器用于生成初始化值
* 通过扩展以增加默认实现的功能
* 实现协议以提供某种标准功能

与结构体相比，类还有如下的附加功能：

* 继承允许一个类继承另一个类的特征
* 类型转换允许在运行时检查和解释一个类实例的类型
* 解构器允许一个类实例释放任何其所被分配的资源
* 引用计数允许对一个类的多次引用

> 注意：结构体总是通过被复制的方式在代码中传递，因此请不要使用引用计数

####定义

类和结构体有着类似的定义方式。通过关键字`Class`和`Struct`来分别表示类和结构体。

```
class ClassName {
	// body
}
```
```
struct StructName {
	// body
}
```
> 注意：每次定义新类或者结构体的时候，实际上你是有效的定义了一个新的Swift类型。命名方式采用大驼峰。属性，方法使用小驼峰。

结构体和类的示例：

```
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

上面例子我们定义了一个结构体`Resolution`用来描述显示器的分辨率。结构体中有两个`存储属性`。存储属性是捆绑和存储在类或结构体中的常量或变量。属性赋值为0，被推断为Int类型

还定义类一个VideoMode的类，描述视频显示器的特定模式。类包含类四个存储属性变量。


####类和结构体实例

结构体和类使用构造器语法生成新的实例:

```
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

####属性访问

点语法访问

```
someVideoMode.resolution.width
```
也可以使用点语法为属性变量赋值：

```
someVideoMode.resolution.width = 1280
```

> 注意：与OC语言不同的是，Swift允许直接设置结构体属性的子属性。

####结构体类型的成员逐一构造器（Memberwise Initializers for Structure types）

所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器中：

```
let vga = Resoluton(width:640, height: 480)
```
与结构体不同，类实例没有默认的成员逐一构造器。

#### 结构体和枚举是值类型

值类型被赋予一个变量、常量或者本身被传递给一个函数的时候，实际上操作的是其的拷贝。

swift中所有的基本类型（浮点、整数、布尔、字符串、数组、字典）都是值类型，并且都是以结构体的形式在后台所实现。

Swift中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。

```
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
```
因为是值类型，cinema 跟 hd 不是一个东东（不是一个实例），cinema是hd拷贝的副本。它们是相互独立的，彼此修改会影响到彼此。（枚举也遵循相同的行为准则）

####类是引用类型

既然是引用，那么引用的是已存在的实例本身而不是对其拷贝。

#### 恒等运算符

因为类是引用类型，有可能有多个常量和变量在后台同时引用某一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝）

判定两个常量或者变量是否引用同一个类实例的方法：

* 等价于 ===
* 不等价于 !==

注意`等价于`（===）与`等于`（==）的不同：

* “等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
* “等于”表示两个实例值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相比于“相等”，这是一中更加合适的叫法。

####指针

Swift中常量或变量引用一个类型的实例与C语言中的指针类似，不同的是并不直接指向内存中的某个地址，也不要求使用`*`来表明你在创建一个引用。Swift中这些引用与其他常量或变量定义方式相同。

####类和结构体的选择

按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：

* 结构体的主要目的是用来封装少量相关简单数据值。
* 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是引用。
* 任何在结构体中存储的值类型属性，也将会被拷贝，而不是引用。
* 结构体不需要继承另一个已存在的类型的属性或者行为。

以下情景中适合使用结构体：

* 几何形状
* 一定范围的路径
* 三维座标系内一点

在所有其他案例中，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，意味着绝大部分的定义数据构造都应该是类，而非结构体。

####字符串、数组和字典类型的赋值与复制行为

Swift中字符串、数组和字典均以结构体的形式实现。意味着这些类型数据被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会发生拷贝行为（值传递方式）。

OC中这些类型均以类的形式实现。NSString、NSArray和NSDictionary在发生赋值或者传入函数（或方法）时，不会发生值拷贝，而是传递已存在的实例的引用。

> 注意：Swift管理所有的值拷贝以确保性能最优化。所以，你也没有必要去避免赋值以保证最优性能。（实际赋值由系统管理优化）

### 属性

* 存储属性（Stored Properties）
* 计算属性（Computed Properties）
* 属性观察器（Property Observers）
* 全局变量和局部变量（Global and Local Variables）
* 类型属性（Type Properties）

属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分，而计算属性计算（不是存储）一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。

存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接作用于类型本身，这种属性称为类型属性。

还可以定义属性观察器来监控属性值的变化，一次来触发一个自定义的操作。属性观察器可以添加到自己定义的存储属性上，也可以添加到从父类继承的属性上。

####存储属性

存储在特定类或结构体的实例里的一个常量或变量。可以在定义存储属性的时候指定默认值。也可以在构造过程中设置或修改存储属性的值，甚至修改常量存储属性的值。

```
struct FixedLengthRange {
    var firsValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firsValue: 0, length: 3)

rangeOfThreeItems.firstValue = 6
```
length在创建实例的时候被初始化，它是一个常量存储属性，之后无法修改了。

####常量结构体的存储属性

如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使定义了变量存储属性：

```
let rangeOfFourItems = FixedLengthRange(firsValue: 0, length: 3)
// rangeOfFourItems.firstValue = 6 这样赋值是会报错的
```

为什么呢？结构体是值类型属性。当值类型的实例被声明为常量的时候，它的所有的属性也成为了常量。

属于引用类型的类则不一样。把一个引用类型的实例赋值给一个常量后，仍然可以修改该实例的变量属性。

##### 延迟存储属性

延迟存储属性是值当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用`lazy`标示延迟存储属性。

> 必须将延迟存储属性声明成变量，因为属性的初始值可能在实例构造完之后才会得到。而常量属性在构造完成之前必须要有初始值，因此无法声明成延迟属性。

延迟属性，当属性的值依赖于在实例的构造过程结束后才会知道具体的外部因素时，或者获得属性的初始值需要复杂或大量计算时，可以只在需要的时候计算它。

下面例子使用延迟存储属性来避免复杂类中不必要的初始化。

```
class DataImporter {
    /*
    DataImporter 是一个将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这是提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这是提供数据管理功能
}

let manager  = DataManager()

manager.data.append("数据")
manager.data.append("更多数据")

// DataImporter 实例的importer 属性还没有被创建
```

`DataImporter`完成初始化需要消耗不少时间：因为它的实例在初始化时可能打开文件，还有读取文件内容到内存。所以，弄成lazy，用到它的时候，它才会被实例化。importer 才会被创建

> 注意：如果一个被标记为`lazy`的属性没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。

####存储属性和实例变量

OC为类实例存储值和引用提供两种方法。对于属性来说，可以使用实例变量作为属性值的后端存储。


Swift编程语言中把这些理论统一用属性来实现。Swift中的属性没有对应的实例变量，属性的后端存储也无法直接访问。这就避免了不同场景下访问方式的困扰，同时也将属性的定义简化成一个语句。一个类型中属性的全部信息——包括命名、类型和内存管理特征——都在唯一一个地方（类型中定义中）定义。

####计算属性

除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个个getter和一个可选的setter，来间接获取和设置其他属性或变量的值。

```
struct Point {
	var x = 0.0,y = 0.0
}
struct Size {
	var width = 0.0, height = 0.0
}
struct Rect {
	var origin = Point()
	var size = Size()
	var center: Point {
		get {
			let centerX = origin.x + (size.width / 2)
			let centerY = origin.y + (size.height / 2)
			return Point(x: centerX, y: centerY)
		}
		set(newCenter) {
			origin.x = newCenter.x - (size.width / 2)
			origin.y = newCenter.x - (size.height / 2)
		}
	}
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center

square.center = Point(x: 15.0, y: 15.0)
```
这个例子定义了3个结构体来描述几何形状

* Point 封装了一个（x, y）的座标
* Size 封装了一个width和一个height
* Rect 表示一个有原点和尺寸的规矩

Rect 提供了一个center计算属性。一个巨型的中心点可以从原点`origin`和尺寸`size`算出，所以不需要将它以显示声明的`Point`来保存。`Rect`


####便捷setter声明

如果计算属性的setter没有定义新值的参数名，可以使用默认的名称`newValue`。下面是使用了便捷setter声明的`Rect`结构体代码：

```
struct Rect {
	var origin = Point()
	var size = Size()
	var center: Point {
		get {
			let centerX = origin.x + (size.width / 2)
			let centerY = origin.y + (size.height / 2)
			return Point(x: centerX, y: centerY)
		}
		set {
			origin.x = newVlaue.x - (size.width / 2)
			origin.y = newValue - (size.height / 2)
		}
	}
}
```


####只读计算属性

> 注意：必须使用var关键字定义计算属性，包括只读计算属性，因为它们的值是不固定的。let关键字只用来声明常量属性，表示初始化后再也无法修改的值。

只读计算属性的声明可以去掉`get`关键字和花括号：

```
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
```

####属性观察器

属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，甚至新的值和现在的值相同的时候也不例外。

可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重载属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。

>注意：不需要为非重载的计算属性添加属性观察器，因为可以通过它的setter 直接监控和响应值的变化。

可以为属性添加如下的一个或全部观察器：

* `willSet`在新的值被设置之前调用
* `didSet`在新的值被设置之后立即调用

`willSet`观察器会将新的属性值作为常量参数传入，在`willSet`的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，默认名称newValue来表示。

`didSet`观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名`newValue`

> 注意：父类的属性在子类的构造器中被赋值时，它在父类中的`willSet`和`didSet`观察器会被调用

这里是一个`willSet`和`didSet`的实际例子，其中定义了一个名为`StepCounter`的类，用来统计当人步行时的总步数。这个类可以跟计步器或其他日常锻炼的统计装置的输入数据配合使用。

```
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print(newTotalSteps)
        }
        didSet {
            if totalSteps > oldValue {
                print(totalSteps - oldValue)
            }
        }
    }
}
let stepCounter = StepCounter()

stepCounter.totalSteps = 200

stepCounter.totalSteps = 300
```
当`totalSteps`设置新值的时候，它的`willSet`和`didSet`观察器都会被调用，甚至当新的值和现在的值完全相同也会调用。

例子中的`willSet`观察器将表示心智的参数自定义为`newTotalSteps`，这个观察器只是简单的将新的值输出。

`didSet`观察器在`totalSteps`的值改变后被调用，它把新的值和旧的值进行对比。didSet如果没有为旧的值提供自定义名称，默认为oldValue

> 注意： 如果在一个属性的didSet观察器里为它赋值，这个值会替换该观察器之前设置的值。

####全局变量和局部变量

计算属性和属性观察器所描述的模式可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法、闭包内部定义的的变量。

前面章节提到的全局或局部变量都属于存储型变量，跟存储属性类似，提供特定类型额存储控件，并允许读取和写入。

在全局或局部范围都可以定义计算型变量和为存储型变量定义为观察器。计算型变量跟计算属性一样，返回一个计算的值而不是存储值，格式声明也完全一样

> 注意：全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记`lazy`特定。局部范围的常量或变量不会延迟计算。

####类型属性

不管类型有多少个实例，这些属性都只有唯一一份。这种属性就是类型属性。

类型属性用于定义特定类型所有实例共享的数据，比如所有实例都能用的一个常量（就像C语言中的静态常量），或者所有实例都能访问的一个变量（C语言中的静态变量）。

> 注意：必须给存储类型属性指定默认值，因为类型本身无法在初始化工程中使用构造器给类属性赋值。


### 方法

* 实例方法
* 类型方法 （Type Methods）

方法是与某些特定类型相关联的函数。类、结构体和枚举都可以定义实例方法也可以定义类型方法。类型方法与OC中的类方法（class methods）相似。

结构体和枚举能够定义方法是Swift与C/OC的主要区别之一。OC中类是唯一能够定义方法的类型。但是Swift中，你不仅能选择定义一个类/结构体/枚举，还能灵活的在你创建的类型（类/结构体/枚举）上定义方法。

#### 方法的局部参数和外部参数名称（Local and External Parameter Names for Methods）

函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用），



















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



