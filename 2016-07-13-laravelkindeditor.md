---
layout: post
title: "laravel上传文件&整合kindeditor"
category: laravel
date: 2016-07-13 00:45
---

laravel项目中使用kindeditor。这是个小功能。没有什么难度。无非要解决以下三点。

1.kindeditor上传的时候，解决csrf的报错？

2.kindeditor上传文件有时候不是我们想要的。如何更改它的插件？

3.kindeditor自带的上传php的demo。我们如何替换成自己的接口？

4.kindeditor实例化是通过textarea的。那么我们如何拿到我们的“富文本”？


###解决csrf的报错

开启csrf的时候，不传_token会报下面的错误。

```
TokenMismatchException in VerifyCsrfToken.php line 67:
```

kindeditor有个参数 `extraFileUploadParams`，顾名思义，额外的上传参数。于是我们就把 `csrf_token`交给它，让它带走。

```
var csrftoken = "{{ csrf_token() }}"; //如果js代码不在页面，就写个隐藏域通过dom获取。
KindEditor.ready(function(K) {
    var options = {
        uploadJson : '/xxx/uploadfile',// 上传文件的配置
        allowFileManager : false,
        extraFileUploadParams : {
            _token:csrftoken  //额外的参数放这里
        }
    };
    K.create('#editor_id', options);
});
```

###简单改kindeditor的插件

如果你想上传音乐呢？比如说，搞活动H5页面需要播放音频。`insertfile`插件就可以。但是我想界面显示的文字都换成我想要的。

ok。上传文件是如下代码。

```
var token = $("input[name='kindeditor_csrftoken']").val();
KindEditor.ready(function(K) {
  var options = {
        uploadJson : '/pagemodule/uploadfile',
        allowFileManager : false,
        extraFileUploadParams : {
            _token:token
        }
    };
    var editor = K.editor(options);
    K('#upfile').click(function() {
      editor.loadPlugin('insertfile', function() {
        editor.plugin.fileDialog({
          fileUrl : K('#file_url').val(),
          clickFn : function(url, title) {
            K('#file_url').val(url);
            editor.hideDialog();
          }
        });
      });
    });
});
```

发现什么了么？是加载插件。上传图片呢？加载的是image插件。我想要有个imusic的插件上传音频。那么，复制一份就可以了。对，复制一份image的文件夹，吧名字一换就可以了。刚才说了要改页面的文件。那么进入`lang/zh-CN.js`文件中，把image的复制一份，对，复制一份，复制的那份image改成imusic。剩下的中文，你自个想把。


```
'imusic.remoteimusic' : '网络音乐',
'imusic.localimusic' : '本地上传',
'imusic.remoteUrl' : '音乐地址',
'imusic.localUrl' : '上传文件',
'imusic.size' : '音乐大小',
```


###封装自己的接口

其实你可以做一个针对于kindeditor的Tool。就像thinkphp下面有相关的类库。我为了完成工作，没有做这么细致。

需要用到的类引入进来

```
use Illuminate\Support\Facades\Input;
```

暂时放到控制器里面。

```
    public function uploadFile(Request $request) {
        // 定义允许的扩展名
        //定义允许上传的文件扩展名
        $ext_arr = array(
            'image' => array('gif', 'jpg', 'jpeg', 'png', 'bmp'),
            'flash' => array('swf', 'flv'),
            'media' => array('swf', 'flv', 'mp3', 'wav', 'wma', 'wmv', 'mid', 'avi', 'mpg', 'asf', 'rm', 'rmvb'),
            'file' => array('doc', 'docx', 'xls', 'xlsx', 'ppt', 'htm', 'html', 'txt', 'zip', 'rar', 'gz', 'bz2'),
        );
        $ext_dir_arr = [
            'image'=>'images',
            'file'=>'files',
            'media'=>'medias'
        ];
        $ext_size_arr = [
            'image'=> [153600, '150kb'],// 150kb
            'file'=>  [102400000, '1MB']// 1M
        ];

        if (!isset($request->dir)) {
            $msg = ['error'=> 1, 'message'=> "dir参数呢？"];
            return  response()->json($msg);
        }
        $dirName = $request->dir;
        $file = Input::file('imgFile');
        $size = Input::file('imgFile')->getSize();//515kb  528379 / 1024 = 515.99511
        $extension = $file->getClientOriginalExtension();
        if (in_array($extension, $ext_arr[$dirName]) === false) {
            $msg = ['error'=> 1, 'message'=> "上传文件扩展名是不允许的扩展名。\n只允许" . implode(",", $ext_arr[$dirName]) . "格式。"];
            return  response()->json($msg);
        }
        if ($size > $ext_size_arr[$dirName][0]) {
            $msg = ['error'=> 1, 'message'=> "上传文件大小不能超过".$ext_size_arr[$dirName][1]];
            return  response()->json($msg);
        }
        $saveName = rand(11111,99999).'.'.$extension;
        $destinationPath = 'uploads/'.$ext_dir_arr[$dirName].'/'.date('Y-m-d', time()); // 根据不同的日期创建不同的存放文件
        $file->move($destinationPath, $saveName);// 移动到指定的位置
        $savePath = '/uploads/'.$ext_dir_arr[$dirName].'/'.date('Y-m-d', time()).'/'.$saveName;

        $msg = ['error'=>0, 'url'=>$savePath];
        return response()->json($msg);
    }
```

改上传接口，初始化的饿时候配置uploadJson参数。

```
uploadJson : '/xxxx/uploadfile'
```

###拿到富文本。

假设，你给textarea添加了id。通过$('#id').val()也是无法拿到的。kindeditor实例化会在页面上嵌入iframe。那么试试下面的代码。

```
$(document.getElementsByTagName('iframe')[0].contentWindow.document.body).html()
```


如果整篇文章看起来都没有难度那就对了。很简单的一篇工作中的思考之文。

参考链接：

* 《jqury 如何获取 kindeditor 中textarea 的值 》<http://blog.csdn.net/java18/article/details/7462304>（标题错了）
* 《django 整合 kindeditor ，解决上传图片 csrf 验证问题》<http://www.cnblogs.com/yeelone/archive/2012/11/17/2774466.html>（虽然是Python的框架，但是同样的问题）
* 《UploadedFile》<http://api.symfony.com/2.7/Symfony/Component/HttpFoundation/File/UploadedFile.html>（更多laravel用到的api请看文档吧）
