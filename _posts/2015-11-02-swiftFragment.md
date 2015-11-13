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
 
获取包含字符串位置，并截取

例如 ：WebView交互

```
let urlString = request.URL?.absoluteString.stringByRemovingPercentEncoding!
if let u = urlString {
    // 如果包含这个协议，开始做交互
    if u.hasPrefix("protocol://") {
        let range = u.rangeOfString("protocol://")
        let protocolName = u.substringFromIndex((range?.endIndex)!)
        
        if let b = protocolBlock {
            b(protocolName: protocolName)
        }
        return false
    }
}

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

8.class跟static区别

在C或Objective-C中，与某个类型关联的静态常量和静态变量是作为全局（global）静态变量定义的。但是Swift编程语言中，类型属性是作为类型的一部分，作用范围是在类型支持的范围内。

使用关键字static定义类型属性。为类定义计算类型属性时，可以用关键词class 支持子类对父类的实现进行重写。class 不能用于 存储属性。

class跟static都能修饰类方法。static 修饰的属性或者方法都是不能被继承重写的。

9.XIB 加载失败的处理

```
override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
}
deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
}
required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
convenience  init() {
    let nibNameOrNil = String?("HomeViewController")
    self.init(nibName: nibNameOrNil, bundle: nil)
}
```

10.ATS（App Transport Security ）

```
在Info.plist中添加NSAppTransportSecurity类型Dictionary。
在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
```

参考链接：

《iOS9 HTTP 不能正常使用的解决办法》 <http://segmentfault.com/a/1190000002933776>

11.页面跳转技巧（数组操作）

```
var vcs:[UIViewController] = (self.navigationController?.viewControllers)!
vcs[0].presentViewController(nvc, animated: true, completion:{
    self.navigationController?.viewControllers = vcs
    vcs[0].tabBarController?.selectedIndex = 0
})
```
参考链接：
<http://stackoverflow.com/questions/410471/how-can-i-pop-a-view-from-a-uinavigationcontroller-and-replace-it-with-another-i>

12.class跟Struct 的相似处与不同处



共同点：

* 定义属性用于存储值
* 定义方法用于提供功能
* 定义附属脚本用于生成初始化值
* 通过扩展以增加默认实现的功能
* 实现协议以提供某种标准功能

与结构体相比，类还有一下附加功能：

* 继承允许一个类继承另一个类的特征
* 类型转换允许在运行时检查和解释一个类实例的类型
* 解构器允许一个类实例释放任何其被分配的资源
* 引用计数允许对一个类的多次引用（结构体总是通过被复制的方式在代码中传递，因此不需要引用计数）
结构体跟枚举是值类型。值类型被赋予给一个变量、常量或者本身被传递给一个函数的时候，实际上的操作的是其被拷贝。swift所有的基本类型都是值类型。以结构体的形式在后台实现。

