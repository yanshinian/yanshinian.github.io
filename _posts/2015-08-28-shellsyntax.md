---
layout: post
title:  "shell的基本语法"
category: Linux
date:   2015-08-28 
---
> 本文章根据手头资料跟网络资料整理，非原创。将就看吧！ 编写环境 Mac电脑，也有可能是Ubuntu 麒麟


文件开头：

`#! /bin/sh`。符号`#!`告诉系统后面的参数是用来执行该文件的程序。这个例子我们使用`/bin/sh`来执行程序。

执行脚本：

```
第一种：sh 脚本名
第二种:： ./脚本名.sh，但是要确定有`x`执行权限
```

注释：

注释用`#`。行注释

变量：

```
website="http://yanshinian.com"

echo $website  #使用变量要用$
```

有时候变量名容易跟其他文字混淆：

```
hello="hello"

echo "$helloworld!"
```

这并不会打印成`helloworld`。而会打印成"!",shell找不到一个叫$helloworld的变量，那么改成如下就好了

```
echo "${hello}world!"
```

Shell命令和流程控制器

shell脚本可以使用三类命令：

1) Unix命令

常用命令语法及功能：

```
echo 打印

ls： 文件列表

wc -l filec -w filewc -c file：计算文件行数，计算文件中的单词数，计算文件中的字符数

cp 原文件 目标文件： 文件拷贝

mv 旧文件 新文件：重命名文件或移动文件

rm 文件：删除文件

grep 'pattern' file：在文件内搜索字符串比如：grep 'searchstring' file.txt

cut

cat

file

read 

sort

uniq

expr

find

tee

basename

dirname

head

tail

sed:
```

2）概念：管道，重定向和backtick（` 反引号）

管道`|`将一个命令的输出作为另外一个命令的输入。

```
grep "hello" file.txt | wc -l

```
在file.txt中搜索包含有”hello“的行并计算其行数

##控制流结构

###流程控制是什么

```
#!/bin/bash
#创建一个目录
	make /home/yanshinian/shell/txt
#复制所有的txt文件到指定的目录
	cp *.txt /home/yanshinian/shell/txt
	rm -f *txt

```
上面的脚本会出现问题码吗？

如果目录创建失败或成功如何处理

文件拷贝失败如何处理

###4.1条件测试

有时判断字符串是否相等或检查文件状态或是数字测试等。Test命令用于测试字符串，文件状态和数字。

####4.1.1

格式 `test condition` 或 [ condition ](`使用方括号的时候，条件的两边一定要加空格`)

文件测试状态：可以根据`$?`的值来判断，0表示成功，不等于0为失败

命令符|释义 
----|----
-d | 目录
-f | 正规文件
-L | 符号链接
-r | 可读
-s | 文件长度大于0、非空
-w | 可写
-u | 文件有suid 位设置
-x | 可执行
-z | 字符串为空

具体的可以用`man test`了解


#####脚本测试

```
iOSdeiMac:iLinux ios$ ls
Linux视频				shell01
expr.sh					shell01.sh
linux+					ubuntu-14.04.2-64
read.sh					ubuntukylin-14.04.2-desktop-amd64.iso

iOSdeiMac:iLinux ios$ test -d  Linux视频/ 

iOSdeiMac:iLinux ios$ echo $?
0

iOSdeiMac:iLinux ios$ 
```
##### 脚本练习

```
#!/bin/bash
echo "test use 1"
test -w shell01.sh
echo $?
echo "test use2 [] begin"
[ -w shell01.sh ] #如果忘了空格报类似这样的错误，./test.sh: line 6: [: missing `]'
echo $?       
```

对上面的bash 进行`if`控制

```
这个程序 有待到 linux上验证，跟视频中一样的写法，报错了
#!/bin/bash

test -w shell01.sh

if[ $? -eq "0" ];then
        echo "sucess\n";
else
        echo "failure";
fi

echo $?
```

```
if [ $a=1 ];then
echo "\$a=1"
else
echo "\$a!=1"
fi
```
-eq | = | 等于
---|--|--
-ne | !=| 不等于
-gt | > | 大于
-ge | >= | 大于等于
-lt | < |小于
-le | <= |小于等于

测试时使用逻辑操作符

-a 逻辑与，操作符两边均为真，结果为真，否则为假

-o 逻辑或，操作符两边一边为真，结果为真，否则为假的

! 逻辑否，条件为假，结果为真

####4.1.2 字符串测试

格式

```
test "string"

test string_operator "string"

test "string" string_operator "string"

[ string_operator string ]

[ string string_operator string ]
```

操作符 `string operator`

= | 字符串相等
---|----
!= | 字符串不等
-z | 空字符串
-n | 非空字符串

```
if 条件;then
	主体
elif 条件;then
	主体
else
	主体
fi
```
可以使用测试命令来对条件进行测试。比如可以比较字符串、判断文件是否存在及是否可读等等..

```
[ -f "somefile"]： 判断是否是一个文件

[ -x "/bin/ls"]：判断/bin/ls是否存在并有可执行权限

[ -n "$var" ]： 判断$var变量是否有值

[ "$a"="$b" ]：判断$a和$b是否相等
```

执行`man test` 可以查看所有测试表达式可以比较和判断的类型。

通常用”[]“来表示条件测试。注意这里的空格很重要。确保方括号的空格。

```
#! /bin/sh
hello="hello"

echo $hello

if [ "$hello"="hello" ];then
        echo "相等"
fi
```

快捷操作符

```
[ -f "/etc/shadow" ] && echo "This computer uses shadow passwors"
# 如果/etc/shadow 文件存在就打印 This 语句
```

这里的`&&`是一个快捷操作符，如果左边的表达式为真则执行右边的语句。也可以认为是逻辑运算中的`与`操作。同样`或`操作`||`在shell编程中也是可用的。


参考资料：

*  linux公社 <http://www.linuxidc.com/>
* 《Linux shell脚本全面学习》<http://www.linuxidc.com/Linux/2007-06/4767p3.htm>
* 《Unix & Linux 大学教程 - 第十三章 学习笔记》 <http://su1216.iteye.com/blog/1631238>
* 《Linux Shell脚本面试25问》<http://www.linuxidc.com/Linux/2015-04/116474.htm>















