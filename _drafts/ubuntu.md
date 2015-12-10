
###安装ubuntu

1.安装vmware

自己百度，我随便贴个《如何在macbook上安装vmware虚拟机》<http://jingyan.baidu.com/article/02027811b6f5d81bcc9ce5d2.html>

2.安装ubuntu

自己百度，我随便贴个《Mac虚拟机安装Linux Ubuntu》<http://www.parallelsdesktop.cn/install_ubuntu.html>

###常用的一些操作

1.设置root密码（刚开始安装的没有密码，所以初始化）`sudo passwd root`

命令行的快捷键是 `CTRL+ALT+T`

```
yanshinian@ubuntu:~$ sudo passwd root
[sudo] password for yanshinian: 
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully

```

2.进入命令行模式或进入图形界面

2.1快捷键方式

* 进入命令行 `CTRL+ALT+F1~F6 `

* 进入图形界面 `CTRL+ALT+F7`

3.安装ssh

```
apt-get install openssh-server

```

###常用的命令

ls

-a  | -all 目录下所有的文件，包括隐藏文件
-------|----
-A | 但不列出“.”和“..”
-c |配合-lt：根据ctime排序及显示ctime（文件状态最后的更改的时间）配合-l：显示显示 ctime 但根据名称排序否则：根据 ctime 排序
-r |–reverse 依相反次序排列
-R | –recursive 同时列出所有子目录层
-h | –human-readable 以容易理解的格式列出文件大小 (例如 1K 234M 2G)


cd

~ | 当前用户家目录
---|---
- | 返回进入此目录之前所在的目录
!$ | 把上个命令的参数作为cd参数使用。 

pwd 当前工作目录

 
-P | 显示出实际路径，而非使用连接（link）路径；pwd显示的是连接路径
-----|----
|


mkdir 命令用来创建指定的名称的目录，要求创建目录的用户在当前目录中具有写权限，并且指定的目录名不能是当前目录中已有的目录。

-m | 创建带有权限的目录
----|----
-p | 递归创建目录 

rm 该命令的功能为删除一个目录中的一个或多个文件或目录

-f| --force 强制删除文件
----| ---
-r |  -R, --recursive   指示rm将参数中列出的全部目录和子目录均递归地删除

rmdir  命令的功能是删除空目录，一个目录被删除之前必须是空的。

-p 递归删除目录dirname，当子目录删除后其父目录为空时，也一同被删除。

mv move的缩写，可以用来移动文件或者将文件改名（move (rename) files），是Linux系统下常用的命令，经常用来备份文件或者目录。

-b | 若需覆盖文件，则覆盖前先行备份。
----|-----
-f | force强制的意思，如果目标文件已经存在，不会询问而直接覆盖
-i | 若目标文件（destination）已经存在时，就会询问是否覆盖
-t| --target-directory=DIRECTORY move all SOURCE arguments into DIRECTORY，即指定mv的目标目录，该选项适用于移动多个源文件到一个目录的情况，此时目标目录在前，源文件在后。

cp 用来复制文件或者目录，

-i | --interactive        覆盖前询问(使前面的 -n 选项失效)
----|-----
-R, -r | --recursive  复制目录及目录内的所有项目

touch 不常用，一般在使用make的时候可能会用到，用来修改文件时间戳，或者新建一个不存在的文件。

-a  |  或--time=atime或--time=access或--time=use 　只更改存取时间。
----|-----
-m  |  或--time=mtime或--time=modify 　只更改变动时间。
-t  | 使用指定的日期时间，而非现在的时间。 [CC]YY]MMDDhhmm[.SS]     

cat  连接文件或标准输入并打印。这个命令常用来显示文件内容，或者将几个文件连接起来显示，或者从标准输入读取内容并显示，它常与重定向符号配合使用。

-n | --number     对输出的所有行编号,由1开始对所有输出的行数编号
----|-----
-b | --number-nonblank    对非空输出行编号 ，空行不编号

nl linux系统中用来计算文件中行号。nl 可以将输出的文件内容自动的加上行号！其默认的结果与 cat -n 有点不太一样， nl 可以将行号做比较多的显示设计，包括位数与是否自动补齐 0 等等的功能。

-b | 指定行号指定的方式，主要有两种：-b a ：表示不论是否为空行，也同样列出行号(类似 cat -n)；-b t ：如果有空行，空的那一行不要列出行号(默认值)；
----|-----
-n | 列出行号表示的方法，主要有三种：-n ln ：行号在萤幕的最左方显示；-n rn ：行号在自己栏位的最右方显示，且不加 0 ；-n rz ：行号在自己栏位的最右方显示，且加 0 ；
-w  | 行号栏位的占用的位数





