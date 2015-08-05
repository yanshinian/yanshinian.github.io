---
layout: post
title: "SQLite中的SQL（02）"
description: SQLite中的SQL（02
date: 2015-08-03 18:15:48
category: 开卷有益
---

SQL 是与关系数据库通信的唯一（也是普遍的）的方法。它专注于信息处理，是为构建、读取、写、排序、过滤、映射、计算、映射、计算、产生、分组、聚集和通常的管理信息而设计的。



#### 语法

##### 命令
每条命令以分号（；）结束。命令是一系列记号组成的。记号可以是常量、关键字、标识符、表达式或者特殊字符。令牌符号以空格分开，例如空格、tab和新一行。

##### 常量

确切的值。包含了3中类型：字符串常量、数字常量和二进制常量。字符串常量由单引号引起来的一个或多个字母或数字字符组成。例如：'Jerry'

虽然SQLite 支持单引号或双引号界定字符串，但是我们建议用单引号。如果字符串中本身包含单引号，需要连续两个单引号，例如，kenny‘s chicken需要写成： 'Kenny''chicken'

数字常量有整数、十进制数和科学记数法表示的数，下面是一些例子：

```
-1
3.142
6.023323
```

二进制值使用x'0000'的表示方法，其中跟每位是一个16进制数。二进制值必须由两个16进制的整数。二进制值必须由两个16进制数的整数倍（8bit）组成，下面是一些例子：

````
x'01'
x'0fff'
x'0F0EFF'
x'0f0effab'
```

##### 关键字和标识符

selec、update、insert、create、drop和begin等。标识符是指数据库里的具体对象，如表或索引。关键字是保留的单词，不能用做标识符。SQL不区分关键字和标识符的大小写。


#####注释

SQL中的单行注释是用两个连续连字符（-）表示。多行注释使用的是C语言风格/**/形式。

除非有充分的理由使用C语言的风格的注释，否则推荐在SQLite的SQL脚本中使用SQL标准的两个连续字符。


#### 创建数据库

##### 创建表

`create [temp] table table_name (column_definitions [, constraints]);`

用 temp 或temporary 关键字声明的表是临时表，这种表是临时的---只存活于当前会话。一旦链接断开，就会自动销毁（如果没有手动销毁的话）。方括号表示可选项。管道符号（|）表示两者选其一（理解成或者）。

`create [temp | temporary] table _;`

column_definitions 由用逗号分隔的字段列表组成，每个字段定义包括一个名称、一个域和一个逗号分隔的字段约束。类型有时也称为“域”。

SQLite中有5种本地类型：integer、real、text、blob和 null。

“约束”用来控制什么样的值可以存储在表中或特定的字段中。例如，unique约束规定所有的记录中某个字段的值要各不相同。

Create table 命令允许在字段列表后面跟随一个附加的字段约束：

```
create table contacts (id integer primary key,
						name text not null collate nocase,
						phone text not null default 'UNKNOWN',
						unique (name,phone)
						);
```
字段id声明为integer型，限制为主键。这种组合在SQLite中有特殊含义，整型主键基本上表示该字段是自增长字段。字段name声明为text类型，约束不能为null，并且排序不区分大小写。字段phone是text类型，也有两条约束。之后，表一级的约束是unique，定义在字段name和phone上。

##### 修改表

alter table table {rename to name | add column column_def}

这里的{}。括起来一个选项列表，表示必须从各选项中选择一个。可以使用rename 重命名表。可以使用 add column添加列。

```
alter table contacts add column email text not null default '' collate nocase;
.schema constacts

CREATE TABLE contacts (id integer primary key,
						name text not null collate nocase,
						phone text not null default 'UNKNOWN', 
						email text not null default '' collate nocase,
						unique (name,phone));
```
#### 数据库查询

DML的核心是select 命令，查询数据库的唯一命令。select 很多操作都来源于关系代数，并且包含了关系代数的很多内容。SQLite通向select命令的方法非常具有逻辑性，具备支持关系数据库的底层关系理论的坚实基础。

##### 关系操作

select 语句提供混合、比较和过滤数据的“关系操作”，这些关系操作通常划分为3中类型。

* 基本操作
	
	--Restriction （限制）
	--Projection（投影）
	--Cartesian Product（笛卡尔积）
	--Union（联合）
	--Diference（差）
	--Rename（重命名）
* 附加操作
	--Intersection（交叉）
	--Natural Join（自然链接）
	--Assign（赋值）
* 扩展操作
	--Generalized Projection（广义投影）
	--Left Outer Join（左外连接）
	--Right Outer Join（右外连接）
	--Full Outer Join（全外连接）

SQLite支持ANSI SQL 中除right和full outer join之外的所有操作。

允许捆绑进关系表达式的操作。例如：选择操作（一种关系）的输出可以是另一个select语句的输入：

```
select name from (slect name, type_id from (select * from foods));
```
最里层的select 的结果作为次里层的select 的输入，而次里层的select的结果又作为最外面的输入，这是单一关系型表达式。

#####select 命令与操作管道

select 命令的通用形式如下：

```
select [distinct] heading
from tables
where *predicate*
group by columns
having predicate
order by columns
limit count,offset;

```
每个关键字如：from、where、having等都是一个单独的子句，每个子句由关键字和跟随的参数（例子的中的斜体字）构成。


理解select 命令最好方法就是将其当成处理关系的管道，该管道有可选流程，可以根据需要选择。





















