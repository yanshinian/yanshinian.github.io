---
layout: post
title:  "shell的基本语法"
category: Linux
date:   2015-08-28 
---

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

流程控制

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

[ -f "somefile"]： 判断是否是一个文件

[ -x "/bin/ls"]：判断/bin/ls是否存在并有可执行权限

[ -n "$var" ]： 判断$var变量是否有值

[ "$a"="$b" ]：判断$a和$b是否相等

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

* 《Unix & Linux 大学教程 - 第十三章 学习笔记》 <http://su1216.iteye.com/blog/1631238>
* 《Linux Shell脚本面试25问》<http://www.linuxidc.com/Linux/2015-04/116474.htm>















