---
layout: post
title: "Xcode常用快捷建汇总"
description: 提高iOS开发效率的网站跟软件
date: 2015-06-01 09:15:48
category: 效率开发（工具篇）
---
> 鸣谢我的朋友！我拷贝他收集的！我自己整理过一些，但是不全乎！记得向身边人学习！——言十年

```
新建项目     com + shift +N
新建文件    com  + N
偏好设置  通用   com + ,


当前行加断点    com + \
移动编辑区最上方   com +  上
移动编辑区最下方   com +  下
移动光标所在行最左边   com +   左
移动光标所在最右边   com +   右
向前/后跳一个单词  option + 左&右
向前删除一个单词   option + delete
删除光标所在行后面的所有字符  control + K
打开过的文件之间切换  com + option + 左&右
当前文件的.h .m之间切换   com + control  + 上&下


选中当前行  com + shift + 左&右
取消选中  左&右
选中当前作用域的局部变量   com +control + E


导航区切换  com +1,….8
组件区切换 com + option + 1…5
关闭或打开左边的导航区  com + 0
关闭或打开右边的组件属性区 com + option + 0

DeBug区视图  打开关闭   com + shift + Y
清理 控制台  com  + K
打开控制台窗口   com + shift + C
全局激活或禁用断点   com + Y
Xcode 全屏   com + control + F


运行程序  com + R
停步程序  com + .
编译程序 com  + B
静态分析  com + shift + B


打开标准编辑器   com + 回车 （enter）
打开助手编辑区   com + option + 回车 （enter）
打版本编辑器视图  com + option + shift + 回车


按键说明（win键盘）control = Ctrl
command = Alt
option = win键
shift = shift
快捷键
1.  esc 　　　　           自动完成, 作用和VS中的ctrl+j类似，像 Eclipse 的 alt+/
2.  command + /　　               注释代码和反注释，用 //，相当于 Eclipse 的 ctrl+/
3.  control + command + 上/下箭头　 快速在头文件（.h）和实现文件（.m）之间切换
4.  command + b　　           编译程序，不运行
5.  command + r　　      编译并运行程序
6.  command + shift + b　　       分析代码，找到潜在内存溢出问题 
7.  command  + 单击         跳转到声明
8.  option + 单击             弹出层中显示帮助信息
9.  option + command + 左/右 方向键，折叠/打开当前方法
10. control + command + f           Xcode 全屏，在 Lion 上支持
11. command + shit + y             打开/关闭控制台窗口
12. control + k              清理控制台
13. control + command + 左/右方向键，在历史的上/下一个文件中切换
14. tab          接受当前的自动完成
15. 双击中括号或者大括号，可以选择相应的封闭语句块
16. command - shift - o: 快速搜索打开文件
17. control 配合 1/2/3/4/5/6 键 : 可以快速打开相关文件/类或代码，我常用 control+1 显示打开的文件，control+6 显示当前类中的变量或方法，都可以输入来过滤
18. command 配合 1/2/3/4/5/6/7 依次显示左边导航中每一个标签的子视图，commandco+ 0 打开或关闭左边导航
19. option + command 配合 1/2/3/4/5/6 依次打开右边属性窗口的每一个标签视图，特别是在 xib 时 常用，用 option + command + 0 关闭右边属性窗口
20. command + shift + j 在左边导航中定位当前打开的文件
21.  command + return 切换到标准编辑器
22.  option + command + return 切换到辅助编辑器，左右可以对比，特别方便编辑 xib 时进行拖拉关联
23. command+shift+f        进行 Search
24. f7            调试时 Step Into
25. f6            调试时 Step Over
26. f8            调试时 Step Out
27. control + command + y : debug断点时continue
28. command + \  ： 当前行设置/取消断点
29. command + y  全局激活或禁用所有的断点
30. command+ 左/右方向键 跳到行首/行尾
31. option + 左/右方向键 向前/后跳一个单词
32. option + delete 向前删除一个单词
33. Ctrl + k 删除光标所在行后面的所以字符；


下面几个暂作收藏
control + .   :   下一个自动完成提示
command + e   :   使用当前选中内容查找
command + g   :   在当前文件中查找下一个
command- + shift + f   :   在项目中查找
command + option + shift +t   :   在Groups&Files里定位到当前编辑的文件
control+ a  :  光标跳转到行首
control +e   :  光标跳转到行尾
command+ g   : 向下查找

command＋shift＋g   ： 向上查找
```