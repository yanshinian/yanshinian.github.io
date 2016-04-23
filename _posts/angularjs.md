
AngularJS有着诸多特性，最为核心的是：MVVM、模块化、自动化双向数据绑定、语义化标签、依赖注入等等。

###变量

```
 <div ng-app="myApp" ng-controller="vc">
	<p>{{ goods_name }}</p>
 </div>

<script>
	var app = angular.module('myApp', []);
	app.controller('vc', function($scope) {
	    $scope.goods_name = "诺基亚5320M"
	});
</script>
```

###表达式

```
<div ng-app="">
<p>我的第一个表达式: {{ 5 + 5 }}</p>
<p>我的第二个表达式: {{ 8 * 4 }}</p>
</div>
```
###循环

```
 <div ng-app="myApp" ng-controller="vc">
 	<ul ng-repeat="item in items">
 		<li>{{ item }}</li>
 	</ul>
 </div>

<script>
	var app = angular.module('myApp', []);
	app.controller('vc', function($scope) {
	    $scope.items = ['1', '2', '3']
	});
</script>

```

参考资料：

《百度百科-AngularJS》 <http://www.dwz.cn/39Ym21>