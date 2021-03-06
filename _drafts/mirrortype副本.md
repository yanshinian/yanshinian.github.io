#反射──Mirror（swift 2.0）

> 注意：本人英语水平有限，如有错误，请说下哈
> 
>注意：advance的使用，在xcode 7beta版 跟 xcode 7.0.1 （7的正式版，我没用）是不一样的


###前奏，在使用`Mirror`之前我们先建立一个对象，方便测试！

创建Person.swift，文件内容如下：

```
import UIKit

class Person: NSObject {
    var name: String?
    var age: Int = 0
    
}

```
###其次，我们介绍下`Mirror`

任意`对象实例`的`子结构`跟`可选显示类型`的展现。

例如 存储属性，集合元素，元组或者枚举

####常用属性

* `subjectType`：对象`类型`

* `children`：反射对象的`属性集合`

* `displayStyle`：反射对象展示`类型`



### Mirror 使用

#### 创建一个 `Person` 对象，使用`Mirror` 反射

```
let p = Person()
p.name = "小强"
p.age = 13

let mirror: Mirror = Mirror(reflecting:p)
```

####获取`对象类型`

```
mirror.subjectType 

print(mirror.subjectType) // 打印出：Person
```
####获取`对象属性`以及`属性的值`

```
for p in mirror.children {
    let propertyNameString = p.label! // 使用!因为label 是 optional类型 
    let v = p.value // 这个是属性的值，name 是可选属性打印为Optional("小强")
13
    print(v)
    print(propertyNameString)
}
```
除了上面的遍历，你还可以这样：

```
for (index, value) in mirror.children.enumerate() {
	index // 0
    value.label!
    value.value 
    print(value.label)
    print(value.value)
}
```
#### 获取属性的`类型`


##### 获取`指定`的属性`类型`

指定——就是说我们知道这个类肯定有属性，而且还知道有几个，否则 advance中，你填写了 100，没有100个属性，就崩溃了

```
let children = mirror.children
let p0 = advance(children.startIndex, 0, children.endIndex) // name 的位置
let p0Mirror =  Mirror(reflecting: children[p0].value) // name 的反射
print(p0Mirror.subjectType) //Optional<String> 这个就是name 的类型
```
##### 获取`动态`的属性`类型`

我并不知道我有几个属性。

```
for p in mirror.children {
    let propertyNameString = p.label!
    let v = p.value
    let vMirror =  Mirror(reflecting: v) // 通过值来获取 属性的 类型
    print(vMirror.subjectType)
}
```
### 应用场景

1. 有个成都的小伙子写的字典转模型的`框架`——`Reflect`。就用的这个`反射`写成的。

2. 给FMDB封装一层？对吧，这是我自己想的，在写这个类。`自定义模型`继承这个类使用
	
	* 比如：p.insert(),就是Peron对象p中的对象插入到数据库，你可以做类型校验，假设，你插入的是Text 而数据类型是 Integer，校验之后，报个错提示下用户。（你可以封装成,p.where("age>14").select(),注意，swift中不能使用where跟select做函数名字，因此我换成了p.condition("age>14").find()。😭）
	


<
!---
swift2.0示例：截取最后一个字符
环境 7.0 beta 6
let a = "a,b,c,"
let ad = advance(a.endIndex, -1)
print(a.substringToIndex(ad))
环境 7.0.1 正式版
let a = "a,b,c,"
print(a.substringToIndex(a.endIndex.advancedBy(-1)))
那么截取范围呢？
beta如下：
print(a.substringWithRange(Range(start: advance(a.endIndex, -2),end: advance(a.endIndex, -1))))
正式如下：
 print(a.substringWithRange(Range(start: a.endIndex.advancedBy(-2), end: a.endIndex.advancedBy(-1))))
参考链接：http://stackoverflow.com/questions/28182441/swift-how-to-get-substring-from-start-to-last-index-of-character
--->

参考链接：

* Mirror  <http://swiftdoc.org/v2.0/type/Mirror/>





