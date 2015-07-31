



create table episodes (
	id integer primary key,
	season int,
	name text
);

create table foods (
	id integer primary key,
	type_id integer,
	name text
);
create table food_types (
	id integer primary key,
	name text
);
create table foods_episodes (
	food_id integer,
	episode_id integer
);

## 主要的是 foods 表中 没一行都 对应 一种 不同的食物，名字存储在name字段中。type_id 引用food_types表，用来存储各种食物的分类（例如：烘烤食物、饮料、垃圾食品）。最后，foods_episodes 表讲foods 和 episodes 表的 episodes 连接起来。


#导入sql文件，安装sql语句

foods.db < foods.sql


#为了使数据内容更具可读性，可以在文件的开始 加上以上的 命令

.echo on

.mode colum

.headers on

.nullvalue nullvalue

# 这些命令使得命令行程序：
#1）在屏幕上打印执行的Sql语句
#2）以列模式显示结果
#3）包含列名称
#4）将nulls 打印成NULL。另一个用来设置的选项.width选项，该选项设置输出结果中各个列的宽度，这些设置因例子各异。


# 语法

-- select id from

#sql的易用性来源于它是（绝大部分）声明式语言，而不是命令式语言。声明式语言式是你可以描述想要什么，而命令式语言式那种您需要指定如何做的语言。例如，以处理干酪汉堡订单的过程为例，你作为客户，使用声明式语言说出你的订单，既对前台人员说：
#给我一份含双份肉的，外加墨西哥胡椒和奶酪的干酪汉堡包，陌上蛋黄酱

#订单传递给厨师，他使用命令语言编写的程序填写订单----食谱。根据您的声明式细则，遵照一系列已经定义好的必须执行的步骤，创建干酪汉堡包的具体订单：

1. 从左边的第三个冰箱取出碎牛肉。
2. 做小肉饼
3. 烹3分钟
4. 反转
5. 烹 3分钟




























