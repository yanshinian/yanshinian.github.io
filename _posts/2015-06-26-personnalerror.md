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
###发布app篇

1.new apps and app updates submitted to the app store must be built with public(GM) versions of Xcode ……（具体看见下图）（另：GM版通常是正式版发布前，最后一个测试版。）

![image](/images/personnalerror/fabu_error01.png)

```
解决办法：有人说，是xcode版本过低的缘故。请升级xcode。（如果你复合他说的请升级xcode，试试看行不？）我的情况是我的系统是10.11beta。我的发布的xcode从xcode6.3换成xcode6.4。还是不行。我在想我难道要用xcode7.0发布？

不过，我没有这么做，我同事的电脑系统还没升级还是10.10，我用他的xcode6.4开始发布。

为啥我不用xcode7发布呢？因为图中说，不能用beta软件发布。当然，我也没有尝试，因为急着发布。以后可以试下用 10.11beta + xcode7beta。毕竟下个项目要用swift2.0开发了。也希望苹果的正式版赶紧出来。
```

参考资料：
* iOS应用打包发布常见问题<http://chenhbc.iteye.com/blog/2106959>








