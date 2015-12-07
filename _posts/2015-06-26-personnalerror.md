---
layout: post
title:  "个人报错以及解决办法"
category: 报错
date:   2015-06-26
---

###代码篇

####1.2015-06-11 14:10:30.442 hyq2048[9621:2201840] *** Assertion failure in -[UITableView _configureCellForDisplay:forIndexPath:], /SourceCache/UIKit_Sim/UIKit-3318.16.14/UITableView.m:7344

(lldb) 

####2. 真机测试报错 armv7的问题   

```
ld: in '/usr/lib/system/libcommonCrypto.dylib', missing required architecture arm64 in file /usr/lib/system/libcommonCrypto.dylib (2 slices) for architecture arm64
clang: error: linker command failed with exit code 1 (use -v to see invocation)

逗逼了，把自带的库删掉了
```
####3.2015-06-26 15:05:34.589 HYQ[38374:2409347] Unknown class ViewController in Interface Builder file.

```
2015-06-26 15:05:35.301 HYQ[38374:2409347] CUICatalog: Invalid asset name supplied: (null)
2015-06-26 15:05:35.301 HYQ[38374:2409347] CUICatalog: Invalid asset name supplied: (null)
 http://blog.csdn.net/itianyi/article/details/8547902
 ```
####3.在用cell的时候NSScanner: nil string argument  
 
 ```
检查控件的关联的属性
 ```

####4.ld: '/Users/xxx/Desktop/xxx1.6/xxx1.3/Class/Main/Lib/LLPay/libssl.a(s2_meth.o)' does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target. for architecture arm64

参考链接：

《iOS9适配》 <http://blog.csdn.net/lvxiangan/article/details/48675881>

《理解Bitcode：一种中间代码》<http://www.cocoachina.com/ios/20150818/13078.html>

####5. 重新安装 cocopod 时候出现ERROR:  While executing gem ... (Errno::EPERM)Operation not permitted - /usr/bin/xcodeproj


解决方案：

```
sudo gem install -n /usr/local/bin cocoapods
```
参考链接：

《安装Cocoapods， 更新gem出现的问题。》<http://segmentfault.com/q/1010000002926243/a-1020000002928938>

《Cannot install cocoa pods after uninstalling, results in error》<http://stackoverflow.com/questions/30812777/cannot-install-cocoa-pods-after-uninstalling-results-in-error/30851030#30851030>

《解决OS X 10.11 升级 cocoapods带来的问题》 <http://www.tuicool.com/articles/AFVVvaE>
 
####6.使用 `reloadRowsAtIndexPaths` 出现`reloadRowsAtIndexPaths  exception 'NSInternalInconsistencyException', reason: 'attempt to delete row 1 from section 1, but there are only 1 sections before the update'`报错

原因是：指定的`section`跟`row`可能没有。修改对了就可以了。

例如：刷新第一个section的第一个cell

```
[NSIndexPath indexPathForRow:0 inSection:0]; 
```

参考链接：

《iOS开发小技巧：刷新UITableView》<http://worldligang.baijia.baidu.com/article/146837>
 
####7. 提交到ApppStore出现的问题：`ERROR ITMS-90474: "Invalid Bundle. iPad Multitasking support requires these orientations: 'UIInterfaceOrientationPortrait,UIInterfaceOrientationPortraitUpsideDown,UIInterfaceOrientationLandscapeLeft,UIInterfaceOrientationLandscapeRight'. Found 'UIInterfaceOrientationPortrait' in bundle 'xxx.xxx.xxx'."`还有一个`ERROR ITMS-90475: "Invalid Bundle. iPad Multitasking support requires launch story board in bundle 'xxx.xxx.xxx'."`

解决方案：《iPad Multitaskingに対応したメモ》<http://qiita.com/jollyjoester/items/c8bb1592d01fdef663f9>
 
####8. 提交到ApppStore出现的问题（是跟上面的同时出现的，但是跟上面的两个问题无关）： `Error ITMS-90535: Unexpected CFBundleExecutable Key - xxxx.bundle`

解决方案：《Unexpected CFBundleExecutable key》<http://stackoverflow.com/questions/32096130/unexpected-cfbundleexecutable-key>
 
###svn篇

####1..xccheckout' remains in conflict

```
解决办法:http://stackoverflow.com/questions/20785547/xccheckout-remains-in-conflict

In terminal go to the specific path and reach your MyProject.xccheckout file (MyProject.xcodeproj/MyProject.xcworkspace/xcshareddata/MyProject.xccheckout)
svn resolved MyProject.xccheckout
you will get a svn message "conflict resolved on this file"
Now svn has resolved the conflict on that file and will allow you to commit the project ahead.

svn resolved /Users/ios/Documents/xxx/xxx/Pods/Headers/Public/MJRefresh/MJRefreshAutoStateFooter.h
svn commit -m "更新到测试环境"
```

#####2.svn: E145001: Entry '/Users/ios/Documents/xxx/xxx/Pods/Headers/Private/MJExtension/NSString+MJExtension.h' has unexpectedly changed special status

```
解决办法：http://www.4pmp.com/2010/02/svn-entry-has-unexpectedly-changed-special-status/

http://blog.csdn.net/godleading/article/details/8477309
````

####3.svn 提交的时候 Transaction is out of date

```
更新一下再提交就好了 

Transaction is out of date 
svn: Commit failed (details follow): 
svn: Out of date: '/project/test/branches/test' in transaction 'i' 

解决：这个是由于本地版本与svn上版本不同造成的，更新一下在提交就OK了
 ```
 
####4.svn提交错误file is scheduled for addition, but is missingsvn: E155010: '/Users/ios/Documents/xxx/ismartsvn/xxx/xx/Images.xcassets/LaunchImage.launchimage/Default-568h' is scheduled for addition, but is missing

```
错误原因：

产生问题的原因是有一个文件已经加入到版本库中，但是后来在文件系统中又移除了这个文件，所以不能够提交。

解决方法：
svn revert /Users/qrh/Desktop/work/svn/yb2.0/TVAPP/Images/share/moviePause@2x.png 

svn ci -m "update"
```
### XCode篇

1.new apps and app updates submitted to the app store must be built with public(GM) versions of Xcode ……（具体看见下图）（另：GM版通常是正式版发布前，最后一个测试版。）

![image](/images/personnalerror/fabu_error01.png)

```
解决办法：有人说，是xcode版本过低的缘故。请升级xcode。（如果你复合他说的请升级xcode，试试看行不？）我的情况是我的系统是10.11beta。我的发布的xcode从xcode6.3换成xcode6.4。还是不行。我在想我难道要用xcode7.0发布？

不过，我没有这么做，我同事的电脑系统还没升级还是10.10，我用他的xcode6.4开始发布。

为啥我不用xcode7发布呢？因为图中说，不能用beta软件发布。当然，我也没有尝试，因为急着发布。以后可以试下用 10.11beta + xcode7beta。毕竟下个项目要用swift2.0开发了。也希望苹果的正式版赶紧出来。
```
参考资料：

* iOS应用打包发布常见问题<http://chenhbc.iteye.com/blog/2106959>
 
2.(null):  Couldn't codesign /Users/ios/Library/Developer/Xcode/DerivedData/hyq2.0-ghkupheqogsvdpeqhaprewzzqhfb/Build/Products/Debug-iphoneos/hyq2.0.app/Frameworks/libswiftCore.dylib: codesign failed with exit code 1

解决办法：

<http://www.raywenderlich.com/forums/viewtopic.php?f=45&t=20561>









