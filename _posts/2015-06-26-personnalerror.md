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










