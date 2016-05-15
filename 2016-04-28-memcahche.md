---
layout: post
title: "memcache精要"
category: php
date: 2016-04-28
----


## Memcache 的使用场景

1.非持久化存储：对数据存储要求不高
2.分布式存储：不适合单机使用（用内存，怕影响到其他功能的使用）
3.key/value存储：格式简单，不支持List、Array数据格式

ps. 不要只使用Memcache保存重要数据。定期查看缓存的分布状况和击中情况


一款Nosql的产品，高性能，分布式的内存对象缓存系统。key-value存储形式。

##安装

mac 

```
brew install memcached
```

启动

```
/usr/local/bin/memcached -d
```

```
/usr/local/bin/memcached -d -m 2048  -p 11211 -u nobody
```

常用的命令参数通过`memcached -h`查看参数含义：

```
-p <num>      TCP port number to listen on (default: 11211)
#端口 <数字> 默认是 11211
-m <num>      max memory to use for items in megabytes (default: 64 MB)
#最大内存

-f <factor>   chunk size growth factor (default: 1.25)
#增长因子


```

###命令操作数据

telnet localhost 11211 

退出是quit

增

```
add key flag expire length
#添加 名字（看成变量名） 标识（正整数） 有效期（单位秒）
```
flag：根据flag 可以区分保存的值是什么类型的。虽然，memached基于文本协议，通过字符串形式存储。但是，对象序列化也可以存呀。或者json的字符串。这时候flag就派上用场了。

expire：缓存的有效期，可以指定多少秒，也可以指定具体的时间，如果想不过期就设置为0（表示不过期，除非坏掉，或断电）。
`get key` ，通过key的名字来取值

```
add goods_name 1 0 5 
nokia
STORED
get goods_name // 
VALUE goods_name 1 5
nokia
END
```

delete


```
delete goods_name
DELETED
get goods_name
END
```

replace

set

```
set goods_name 1 0 7
samsung
STORED
get goods_name
VALUE goods_name 1 7
samsung
END
```





















