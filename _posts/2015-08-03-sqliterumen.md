---
layout: post
title:  "Sqlite 入门学习（01）"
category: SQLite
date:   2015-08-03
---

#### 命令行程序

SQLite CLP 是使用和管理SQLite 数据库最常用的工具。CLP其实是两个程序，既可以在Shell模式下以交互的方式执行查询操作，又可以运行在命令行模式下完成各种数据库的管理任务
#### Shell 模式下的CLP
```
sqlite3 就可以了
```
#### 链接数据库
```
sqlite3 数据库路径
```
如果不指定数据库名，SQLite将会使用一个内存数据库（其内容在退出CLP时将会丢失）

CLP以交互形式运行，可以执行查询、获得schema信息、导入/导出数据和其他数据库任务。CLP会将输入的任何语句当成查询命令，除非命令是以（.）开始的，这些以点号开始的命令是为指定的CLP操作预留的，键入`.help`可以得到这些操作的完整列表：

#### 退出 CLP shell
```
.exit 或者 Control+D
```
#### 命令行模式的CLP

```
sqlite3 -help
```
命令行中的CLP可以接受以下参数：

* 可选列表（可选的）
* 数据库文件名（可选的）
* 要执行的SQL命令（可选的）

除了init是指定SQL命令的批处理文件外，绝大部分选项控制输出格式化。数据库文件名是必需的。SQL命令是可选的。


### 数据库管理

##### 创建数据库（Shell模式的CLP）

```
sqlite3 test.db
```
虽然我们提供了数据库名称，但如果该数据库不存在，SQLite 实际上就未创建该数据库，直到在数据库内部创建一些内容（例如表或者视图）时，SQLite才创建该数据库。这样做的原因是，让你有机会在数据库结构提交到磁盘前进行各种永久数据库设置（例如页面大小）。数据库一旦创建，一些设置例如页面大小、字符集（UTF-8、UTF-16等）是不能轻易改变的。因此在创建数据库前，有机会指定这些参数。我们只需创建一个表，从Shell中启动如下语句：`create table test(id integer primary key, value text);`

这样，磁盘中就有了test.db的数据库文件，数据库中有一个名为test的表。该表有两列：

* 名为id的主见列，默认自动增长属性。（我们可以指定值，不指定）
* 名为value 的简单文件域。 

向表中插入几行数据：

```
insert into test (id, value) values(1, '言');
insert into test (id, value) values(2, '十');
insert into test (value) values('年');
```
返回插入内容：

```
.mode column
.headers on
select *from test;
```
.mode 和 .headers 用于改善显示格式

查看最后一条插入的id值

```
select last_insert_rowid();
```
添加一个索引和视图。

```
create index test_idx on test(value);

create view schema as select * from sqlite_master;
```
#### 获取数据库的 Schema 信息

命令`.tables[pattern]`可以得到所有表和视图的列表，其中[pattern]可以是任何like操作符理解的SQL。没有提供pattern项，返回所有的表和视图。
```
.table
```
若要显示一个表的索引，可以键入命令 .indices[table name]

```
.indices[test]
```
显示一个表或视图的（DDL）语句。如果没有提供表名，则返回所有数据库对象（包括table、index、view和triger）的定义语句：

```
.schema test

CREATE TABLE test(id integer primary key, value text);
CREATE INDEX test_idx on test(value);
```
```
.schema
CREATE TABLE test(id integer primary key, value text);
CREATE INDEX test_idx on test(value);
CREATE VIEW schema as select * from sqlite_master;
```
更详细的schema信息可以通过SQLite的重要系统视图sqlite_master得到。这个视图是一个系统目录。

字段名 | 说明
----- |----
type | 对象类型（table、index、trigger、view）
name | 对象名称
tbl_name | 对象关联的表
Rootpage | 对象根页面在数据库的索引（开始的编号）
sql | 对象的SQL定义（DDL）

查询当前数据的sqlite_master表，

```
.mode col
.header on
select type, name, tbl_name, sql from sqlite_master order by type;

type        name        tbl_name    sql                                 
----------  ----------  ----------  ------------------------------------
index       test_idx    test        CREATE INDEX test_idx on test(value)
table       test        test        CREATE TABLE test(id integer primary
view        schema      schema      CREATE VIEW schema as select * from 
```
我们看到的 test.db 对象的完整清单包括：一个表、一个索引和一个视图，每一个都有各自最初的DDL创建语句。

还有其他几个通过 SQLite编译指示命令table_info、index_info、index_list 获取模式。

#### 导出数据

`.dump` 命令可以将数据对象导出成SQL格式。不带任何参数时，.dump将整个数据库导出为数据库定义语言（DDL）和数据库操作语言（DML）命令（这些命令会被写入文本或在标准输出上显示）,适合重新创建数据库对象和其中的数据。

如果提供了参数，Shell将参数解析为表名或视图，导出任何匹配给定参数的表或视图，那些不匹配的将被忽略。在shell模式中，默认情况下，.dump命令的输出定向到屏幕。.dump[filename]命令是定向到指定文件。执行.output stdout 是恢复输出到屏幕。

```
.output file.sql
.dump
.output stdout
```
如果file.sql 不存在，会自动创建。如果存在会被覆盖。

#### 导入数据

文件由SQL语句构成，可以使用.read 命令导入（执行）文件中包含的命令。

文件包含由逗号或其他分隔符的值（comma-separated values，CSV）组成，可以使用.import[file][table]命令，解析指定的文件并尝试将数据插入到指定的表中。通过使用管道字符（|）作为分隔符解析文件的没一行，并将已分析的列插入到表中。文件中解析字段的数量应与表中的列数匹配。可以使用`.separator`命令指定不同的分隔符。若要查看分隔符的当前值，可以使用`.show`命令。将显示Shell中定义的所有设置：

````
.show
     echo: off
      eqp: off
  explain: off
  headers: off
     mode: list
nullvalue: ""
   output: stdout
separator: "|"
    stats: off
    width: 
```
.read 命令导入.dump命令创建的文件。如果使用之前备份文件所导出的file.sql，先要移除已经存在的数据库对象（test表跟schema视图），然后导入file.sql文件

```
drop table test;
drop view schema;
.read file.sql
```
#### 格式化
CLP提供了几个格式化选项命令，这些命令可以使解国际和输出更简洁整齐。最简单的是.echo，将回显输入命令。.headers 设置为on时，查询结果带有字段名。当遇到NULL值，使用.nullvalue命令设置。例如，如果需要以一个字符串NULL来显示null值，只需执行.nullvalue NULL命令。默认情况下，这种null显示时是空串。

如果改变CLP的Shell提示符，使用.prompt[value],如：

```
.prompt 'sqlite3>'
```
.mode命令可以设置结果数据的几种输出格式空。可选的格式有csv、column、html、insert、line、list、tabs和tcl，每种格式都有不同的用途。默认是list,list模式下显示结果集时以默认的分隔符分隔。如果想以CSV格式输出一个表的数据，可以进行如下操作：

```
.output file.csv
.separator
select * from test;
.output stdout
```
```
cat file.csv 
1|言
2|十
3|年
```

实际上，因为Shell中已经定义了一个CSV模式，所以下面的命令会得到相似的结果：

```
.output file.csv
.mode csv
select * from test;
.output stdout
```
得到的结果是相同的，区别在于CSV模式将自动换行字段值并加上双引号，而列表模式（默认）不加

##### 导出带分隔符的数据
结合导出、导入和设置数据格式的三个部分，有一种以分隔符号导出和导入数据的简便方法。例如，导出test表中以字母m开始的值并以逗号分割，导出到test.csv文件


#### 备份数据库

命令行方法
```
test.db .dump > test.sql
```
Shell中方法
```
.output file.sql
.dump
.output stdout
.exit
```
导入方法：
```
sqlite3 test.db < test.sql
```
备份二进制数据库（备份前需要清理数据库，释放一些已删除对象不再使用的控件，这样数据库文件就会会变小）：

```
sqlite3 test.db vacuum
cp test.db test.Backup
```
备份总结：

备份二进制文件没有备份SQL移植性好。SQLite具有很好的向后兼容性。备份SQL文件才是长久之计。

#### 获得数据库文件的信息

获取逻辑数据库的信息（例如：表名、DDL语句等）的主要方法是使用sqlite_master视图，该视图提供有关给定数据库包含的所有对象的详细信息。

如果希望了解物理数据库结构的信息，可以使用一种称为SQLite Analyzer的工具，可以从SQLite网站下载该工具的二进制包。SQLite Analyer提供有关SQLite数据库磁盘结构的详细技术信息，这些信息包括数据库、表和索引分类的单个对象，以及聚合的统计信息。
















参考资料：

* 《SQLite权威指南（第二版）》