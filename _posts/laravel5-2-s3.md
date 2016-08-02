---
layout: post
title: "laravel5.2之使用AWS——S3"
category: laravel
date: 2016-08-02  00:45
---

下载laravel 的 包 https://github.com/aws/aws-sdk-php-laravel （没有使用）

而是按照的下面这个教程

<https://laravel.com/docs/master/filesystem>

按照教程遇到了这个问题

```
S3Exception in WrappedHttpHandler.php line 192:
Error executing "PutObject" on "https://s3-eu-west-1.amazonaws.com/culiu.cdn/afp-wap/"; AWS HTTP error: cURL error 60: SSL certificate problem: unable to get local issuer certificate (see http://curl.haxx.se/libcurl/c/libcurl-errors.html)
```

解决办法：


<http://stackoverflow.com/questions/21114371/php-curl-error-code-60>

下载保存成 .pem文件

```
配置下 php.ini 的选项

curl.cainfo = "E:\phpenv\xampp\php\path_to_cert\cacert.pem"
```


默认时区问题

默认us-east-1，这是个坑呀

会出现

```
FatalErrorException in CurlMultiHandler.php line 100: Maximum execution time of 30 seconds exceeded
```

于是我参考了

《 Amazon AWS 中国区的那些"坑"》 把时区改成了`cn-north-1`

 于是文件夹创建成功了

参考资料：

*《Amazon AWS 中国区的那些"坑"》<http://www.jianshu.com/p/0d0fd39a40c9>
