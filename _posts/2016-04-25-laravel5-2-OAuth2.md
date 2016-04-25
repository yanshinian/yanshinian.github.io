---
layout: post
title: "Laravel5.2框架OAuth2.0集成"
category: php
date: 2016-04-25 11:45
---


网上资料很多。比如这篇[8. Laravel5学习笔记：在laravel5中使用OAuth授权](http://blog.csdn.net/hel12he/article/details/46820711)。我大部分是参照这篇的。但是，也有个问题。一是版本升级到了5.2。二是，作者演示信息不全。不过还算实现了！谢谢这篇文章！

首先，不要太着急用他的代码！或者，用他的代码之前要有心理准备。语法会变动。其实，你可以先去github去看下英文的文档。毕竟github代码更新，文档也会更新的。


###配置

这篇博客中提到的配置。还是按照github上的文档来吧！因为变动了！[laravel-5.md](https://github.com/lucadegasperi/oauth2-server-laravel/blob/master/docs/getting-started/laravel-5.md)

###数据库处理

数据库添加原始数据要按照顺序添加哈！因为有外键么！顺序不对会提示的！

```
insert into wx_users (name,password,email) values('yanshinian','123456’,’x’); 
#这里的passWord-123456是个错误示范，你可千万别这么写。你需要用方法去生成一个。Hash::make('123456')，意思就是加密了`123456`

#下面的数据，就是按照博客中的来了
insert into wx_oauth_scopes (id,description) values('scope1','获取scope1 的权限'),('scope2','获取scope2的权限');

insert into wx_oauth_clients(id, secret,name) values('demo','123','123');

insert into wx_oauth_client_scopes (id, client_id,scope_id) values(2,'demo','scope1');

insert into wx_oauth_client_endpoints (id, client_id, redirect_uri) values(1,'demo','http://localhost:8000/callback');
```

添加数据用多种方法。我用的是mac终端。你可以用navcat其他客户端。或者使用laravel的`数据库迁移，填充`。可参考这篇博客[Laravel学习笔记（六）数据库 数据库填充](http://www.cnblogs.com/huangbx/p/Laravel_6.html)。这篇博客提到一个命令`php artisan migrate:make`，现在变成了`php artisan make:migration。[具体参考](http://stackoverflow.com/questions/25840643/php-artisan-migratemake-create-mytable-fails-migratemake-is-not-defined) 



###错误区(盲目使用旧版本代码)：

1.Fatal error: Class 'Input' not found (

解决：In Laravel 5.2, the Input alias was removed. You can still use it by adding it to your config/app.php file, but rather than doing that, the simplest way is probably to use the request() helper function:

<http://stackoverflow.com/questions/36629259/prob-with-laravel-input-not-found>

其实先看英文文档<https://github.com/lucadegasperi/oauth2-server-laravel/blob/master/docs/authorization-server/auth-code.md>就不会这么傻缺了！罪过！总想看中文资料！


2.TokenMismatchException in VerifyCsrfToken.php line 67:

解决：form 中添加，<input type="hidden" name="_token" value="{{ csrf_token(); }}">

<http://stackoverflow.com/questions/32239596/no-solution-for-tokenmismatchexception-in-verifycsrftoken-php-line-53-in-laravel>


参考资料：

* 《8. Laravel5学习笔记：在laravel5中使用OAuth授权》 <http://blog.csdn.net/hel12he/article/details/46820711>