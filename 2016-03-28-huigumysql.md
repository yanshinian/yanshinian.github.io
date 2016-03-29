---
layout: post
title: 回顾mysql
category: iOS
date: 2016-03-28 12:15
---

mysql中文乱码问题

在创建数据库的时候指定编码
mysql> create database student character set utf8 collate utf8_general_ci;

删除自增长的主键id，要注意的问题

1.先要删除自增长

```
alter table student change id id int(20);
```

2.然后才能删除主键

```
alter table student drop primary key;
```