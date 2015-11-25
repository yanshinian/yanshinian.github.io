命令

查看xcodebuild所有命令：`man xcodebuild`（不知道命令怎么使用就用man）

xcodebuild -version 显示版本号

```
Xcode 7.1.1
Build version 7B1005
```
xcodebuild -showsdks 显示当前SDK

```
OS X SDKs:
	OS X 10.11                    	-sdk macosx10.11

iOS SDKs:
	iOS 9.1                       	-sdk iphoneos9.1

iOS Simulator SDKs:
	Simulator - iOS 9.1           	-sdk iphonesimulator9.1

tvOS SDKs:
	tvOS 9.0                      	-sdk appletvos9.0

tvOS Simulator SDKs:
	Simulator - tvOS 9.0          	-sdk appletvsimulator9.0

watchOS SDKs:
	watchOS 2.0                   	-sdk watchos2.0

watchOS Simulator SDKs:
	Simulator - watchOS 2.0       	-sdk watchsimulator2.0

```

xcodebuild -list 显示工程信息

先cd到工程目录下（有＊.xcodeproj的目录，比如Map.xcodeproj），然后输入命令
```
Information about project "map":
    Targets:
        map
        mapTests
        mapUITests

    Build Configurations:
        Debug
        Release

    If no build configuration is specified and -scheme is not passed then "Release" is used.

    Schemes:
        map
```
xcodebuild build

由于xcodebuild默认的第一个参数就是`build`，所以可以省略这个参数

默认打包第一个`target`

假设我又添加了一个`target`叫做`love`，那么打包love就是

```
xcodebuild -target 'love'  
```


xcodebuild clean

默认删除的是Release而且默认删除的是第一个`target`，如果要删除Debug，命令后加 `-configuration Debug`，如果要删除其他的`target`：

```
xcodebuild -target targetName clean
```

```
=== CLEAN TARGET map OF PROJECT map WITH THE DEFAULT CONFIGURATION (Release) ===

Check dependencies

Clean.Remove clean build/Release-iphoneos/map.app.dSYM
    builtin-rm -rf /Users/ios/Documents/iCode/iSwift/map/build/Release-iphoneos/map.app.dSYM

Clean.Remove clean build/map.build/Release-iphoneos/map.build
    builtin-rm -rf /Users/ios/Documents/iCode/iSwift/map/build/map.build/Release-iphoneos/map.build

Clean.Remove clean build/Release-iphoneos/map.app
    builtin-rm -rf /Users/ios/Documents/iCode/iSwift/map/build/Release-iphoneos/map.app

** CLEAN SUCCEEDED **
```
xcrun 打包成ipa文件

```
xcrun -sdk iphoneos PackageApplication -v /Users/ios/Documents/iCode/iSwift/map/build/Release-iphoneos/map.app  -o /Users/ios/Documents/iCode/iSwift/map/build/Release-iphoneos/map.ipa

```


参考链接：

《iphone-命令行编译之--xcodebuild》<http://www.cnblogs.com/xiaodao/archive/2012/03/01/2375609.html>
《xcodebuild命令行编译打包iOS应用和企业发布》<http://www.tuicool.com/articles/FBbmEn>