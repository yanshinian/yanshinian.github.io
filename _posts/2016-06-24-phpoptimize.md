---
layout: post
title: "php简单的优化与思考"
category: php
date: 2016-06-24 00:45
---

本文还是很简单的。没有高大上的东西。



编号|思路|目的
--|--
1|使用PHP版本所允许的最新语法|简洁语法，简洁代码。例如：[],traits
2|使用model层,service层|减轻controller负担
3|针对控制器中js弹框封装到父类|尽量减少硬编码存在
4|针对ajax请求返回值采用统一格式|方便以后扩展
5|评论编辑，可以不用发送ajax从数据库中取，直接dom取！|减少数据库操作
6|添加相关日志记录。是用json还是ver_export 呢？|日志中显示更直观
7|可以多写些注释！| 其他人能看明白
8|把可变的暴露成接口参数！| 尽量的让被调用方法 灵活。谁调就根据自身需求传参，你调你知道你要传什么。
9|拆分大方法，把可变的东西跟不可变的分开。 | 
10|去掉用不到的代码段，dead code。| 避免迷惑
11|把代码中处理二维数组的foreach，看情况更换成 自己封装的处理函数。| 换一种方式也许更简洁。更通用。
12|尽量使用php内置函数。| 快
13|同等实现情况下择优使用 比如: php判断字符串长度 isset()速度比strlen()更快| 提升运行速度
14|节省else 语句 | 简洁                                                                                   


###1

$arr = array('活', '雷', '峰');

$arr = ['活', '雷', '峰'];

###2

```
Class Model1 {
	function m1 {
		return $data;
	}
}
Class Model2 {
	function m2 {
		return $data;
	}
}
Class Controller1 {
	function c1() {
		new Model1->m1();
		new Model2->m2();
	}
}

```

添加 service层后

```
class Service1{
	function s1 {
		new Model1->m1();
		new Model2->m2();
	}
}
Class Controller1 {
	function c1() {
		new Service1->s1();
	}
}
```
###3

原：

```
echo "<script>alert('添加失败');location.href='/xx/add';</script>"
```

后：

```
public function alertLocation($msg, $destUrl) {
    echo "<script>alert('$msg');location.href='$destUrl';</script>";
}
```
###4

原：

```
echo 1;//表示成功
echo 0;//表示失败
```
后：

```
// 好处，现在有时候是java返回的json。如果换成其他平台。我们都可以转成自己的方法，自己的格式。
public function outJsonSuccess($message='', $content='') {
    $res = ['error'=>0, 'message'=>$message, 'content'=>$content];
    $val = json_encode($res);
    exit($val);
}
```

###8

原：

```
function getResult($name='小刘') {
	switch ($name) {
		case '小明'：
			$where['level'] = 3;
		break;
		case '小李'：
			$where['level'] = 5;
		break;
		default:
			$where['level'] = 4;
	}
}

function xiaoliu() {
	$this->getResult();
}
function xiaoli() {
	$this->getResult('小李');
}
```

后：

```
function getResult(Array $siftWhere) {
	$where += $siftWhere;
}

function xiaoliu() {
    $siftWhere['level'] = 4;
	$this->getResult($siftWhere);
}
function xiaoli() {
    $siftWhere['level'] = 3;
	$this->getResult($siftWhere);
}
```
###9

原：

```
function getResult() {
	// 1. 组装条件（各种判断）
	// 2. 根据条件，查询结果 （各种查询）
}
```

后：

```
function getResult() {
	// 1. 组装条件（各种判断）
}
function resultWithCondition($condition) {
	// 1. 根据条件，查询结果 （各种查询）
}
```
###11

原：

```
$res = [];
foreach ($result as $k=>$v) {
 	if (in_array($v['lev'], [1,2]) ) {
 		$res[] = $v['lev'];
 	}
}
```

后：

```
$res = array_getFieldVaulesWithScope($result, 'lev', 'lev', [1]);

function array_withScope(array $array, $scopeField, $scope) {
    $scopeStr = implode(',', $scope);
    $data = array_filter($array,create_function('$v', 'return in_array($v["' . $scopeField . '"],['.$scopeStr.']);'));
    return $data;
}


function array_getFieldVaulesWithScope(array $array, $field, $scopeField, $scope, $unique = true) {
    $result = array_column(array_withScope($array, $scopeField, $scope), $field);
    if ($unique) {
        $result = array_unique($result);
    }
    return $result;
}
```
12

原：

```
$arr = [
    ['name'=>'xiaoming', 'age'=>12],
    ['name'=>'xiaona', 'agdde'=>13],
    ['name'=>'xiaona', 'age'=>13, 'o'=> 20]
];

$newArr = [];

foreach($arr in $k=>$v) {
	$newArr += $v;
}
```

后：

```
array_unchunk($arr); // PHP手册是个好东西，没事多看看

function array_unchunk($array)
{
    return call_User_Func_Array('array_merge',$array);
}
 
```

原：

```
$v1 = $v2 = [];
foreach ($levArr as $k=>$v) {
   if (in_array($v, [1,2]))
    {
        $v1[] = $v;
    }
    else 
    {
        $v2[] = $uVal;
    }
}

```
后：

```
$virtual_user =  array_intersect($user_id_arr, $this->comment_model->virtual_user_list());// 交集
$shop_user = array_diff($user_id_arr, $this->comment_model->virtual_user_list()); //差集
```

###13

```
php判断字符串长度 isset()速度比strlen()更快
if (strlen($foo) < 5) { echo "Foo is too short"$$ }
if (!isset($foo{5})) { echo "Foo is too short"$$ }
```
```
$var = 'Hello ' . $world; //  比下面两个要快
$var = "Hello $world"; // or
$var = "Hello {$world}";
```

`[]`比array_push好些。

```
$res[]  = 4;

array_push($res, 4);
```

###14 

> 尽量使用逻辑运算符 `!`,`&&`,`||` 

原：

```
if ($button_id)
    $is_add = false;    //编辑
else
    $is_add = true;     //添加
```

优化后：

```
$is_add = !$button_id; 
```


