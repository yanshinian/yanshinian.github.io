---
layout: post
title: "swift碎知识"
category: Swift2.0
date: 2015-11-02 12:45
---
1.swift 标记

* 无分割线 // MARK: 提示文字
* 有分割线 // MARK: - 提示文字 
* 上下分割线 // MARK: - 提示文字 -
* 备注 // TODO:
*  // FIXME: 

参考链接：

《#pragma mark in Swift?》<http://stackoverflow.com/questions/24017316/pragma-mark-in-swift#comment44291547_24037870>

《Swift’s Answer to #pragma mark, FIXME and TODO》<http://iosdevelopertips.com/xcode/swift-replacement-pragma.html>

《代码中特殊的注释技术——TODO、FIXME和XXX的用处》 <http://www.cnblogs.com/pengyingh/articles/2445826.html>

2.通常情况下 `NSArray`跟`NSDictionary`，在类似如下情况下使用（通常Array跟Dictionary就够用了）：

```
let path = NSBundle.mainBundle().pathForResource("HelpCenter", ofType:"plist")
let arr = NSArray(contentsOfFile: path!) 或 let dict = NSDictionary(contentsOfFile: path!))
```

3.Swift 2.0 字符串截取处理方式

```
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
 
```
参考链接：

http://stackoverflow.com/questions/28182441/swift-how-to-get-substring-from-start-to-last-index-of-character

4.通过字符串实例化控制器

实现这个功能，必须使用 `@objc`关键字。

```
@objc(AboutMeViewController) 
class AboutMeViewController: UIViewController {
	....
}
```

```
let value = "AboutMeViewController"
let vc = NSClassFromString(value) as! UIViewController.Type
                    
navigationController?.pushViewController(vc.init(), animated: true)
```

5.UIWebView 加载文件（e.g html文件）


```
let filePath = NSBundle.mainBundle().pathForResource("index.html", ofType: nil)
do {
    let htmlString =  try NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
    (self.view as! UIWebView).loadHTMLString(htmlString
        as String, baseURL: NSURL(string: filePath!))
} catch let error as NSError  {
    print(error.localizedDescription)
}
```
6.判断来源类

```
// 判断，如果是 从 登录的第一个页面过来，那么，是 pop 出去
if navigationController?.childViewControllers.first?.classForCoder == RegisterFirstController.classForCoder(){
    self.navigationController?.popToRootViewControllerAnimated(true)
    return ;
}
```
7.Swift 的代理的使用

声明
```
protocol QuestionCenterSectionHeaderViewDelegate: NSObjectProtocol {
    func sectionHeaderViewDidSelect(headView:QuestionCenterSectionHeaderView)
}
```

属性 声明

```
weak var delegate: QuestionCenterSectionHeaderViewDelegate? // 使用weak是为了防止循环引用

```

调用

```
self.delegate?.sectionHeaderViewDidSelect(self)
```

