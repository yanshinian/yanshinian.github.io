---
layout: post
title:  "NSPredicate(Swift2.0)"
category: MVVM
date:   2015-09-09
---
我们首先建立一个`Person`类

```
class Person: NSObject {
    var name:String?
    init(named: String) {
        name = named
    }
}
```
实例化一个`小明`

```
let p = Person(named: "小明")
let predicate = NSPredicate(format: "name=='小明'")
print(predicate.evaluateWithObject(p)) // true 
```

```
let p1 = Person(named: "小明")
let p2 = Person(named: "小帅")
let p3 = Person(named: "小波")
let p4 = Person(named: "小四")
let p5 = Person(named: "小明")
let predicate = NSPredicate(format: "name='小明'")
let findArr: NSArray = [p1, p2, p3, p4, p5]
let result = findArr.filteredArrayUsingPredicate(predicate)
print(result) // 找到了两条
```
contains 

普通数组使用

```
let findArr: NSArray = ["小明", "小丽", "小二", "小蛋", "老王"]
let predicate = NSPredicate(format: "SELF contains[c] % @", "小")
let result = findArr.filteredArrayUsingPredicate(predicate)
```
对象数组使用
```
let findArr: NSArray = [p1, p2, p3, p4, p5,p6]
let predicate = NSPredicate(format: "SELF.name contains[c] % @", "小")
let result = findArr.filteredArrayUsingPredicate(predicate)
```
SELF.name 的SELF 是可以省略的。

参考链接：

* Cocoa过滤器NSPredicate的完全用法 <http://blog.csdn.net/likendsl/article/details/7570181>
* Objective-C NSPredicate <http://justsee.iteye.com/blog/1816971>
* NSPredicate的用法 <http://www.cnblogs.com/MarsGG/articles/1949239.html>
* Predicate Format String Syntax <https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html>

 















