---
layout: post
title: "FMDB简单的封装——工具FMDBOperator"
category: swift
date: 2016-02-17 12:15
---

###FMDBOperator

用swift对FMDB框架进行简单的封装（OC也封过一次没封完）。主要文件有两个一个是`FMDBOperator`，对FMDB基本操作类，可以继承该类。第二个是`DBManager`,对·NSObject·的数据库操作分类，不用继承就可以使用。框架地址：<https://github.com/yanshinian/FMDBOperator>

由于`DBManager`里面的方法跟`FMDBOperator`功能一样。所以`FMDBOperator`里面相似功能的方法加上了前缀`f_`。目前只支持简单的CURD。并没有连表查询。因为现在公司业务用不到。

封装的不是很好。或者说是封装的很渣。刚开始不会，简单的参考了下ThinkPHP（以前用过php的这个框架）的数据库操作类的封装。没有能力都借鉴过来。不舍得鄙视我自己！有时间我会借鉴下其他的框架！学习下封装！


参考资料：

* ThinkPHP框架<http://www.thinkphp.cn/>