
---
layout: post
title:  "Swift2.0匹配字符串"
category: Swift
date:   2015-09-08
---

匹配字符串至少有三种方式，看如下代码

1.字符串处理方法


```
//MARK: - 验证手机号
func verifyPhoneNo() -> Bool? {
    if let match = self.rangeOfString("^1[3|4|5|7|8][0-9]{9}$", options: .RegularExpressionSearch) {
        return true
    }
    return false
}
```

2.NSPrediate（谓词）

```
//MARK: - 验证是否是纯数字
func verifyNumber() -> Bool {
    let pattern = "^[0-9]+$"
    if NSPredicate(format: "SELF MATCHES %@", pattern).evaluateWithObject(self) {
        return true
    }
    return false
}
```

3.正则表达式


```
//MARK: - 验证身份证
func verifyId() -> Bool {
    let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
    let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.DotMatchesLineSeparators)
    if let result = regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) {
        return true
    }
    return false
}
```

参考资料：

* Swift 的正则表达式<http://www.tuicool.com/articles/vu6JzmU>

	




 















