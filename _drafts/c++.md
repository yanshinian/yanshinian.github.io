

C++的标准输入输出库 #include <iostream>

* cin : istream类型的对象，标准输入，功能类似于C语言的scanf函数，从标准输入设备上（比如键盘）接收用户的输入
* cout : ostream类型的对象，标准输出，功能类似于C语言的printf函数，输出信息到标准输出设备上（比如屏幕）

* 另外还有cerr和clog两个ostream类型的对象


std::cout << “Hello, World!\n”;

* std::说明cout是定义在命名空间std中的

* std::cout中使用了::作用域操作符，表示使用的是定义在命名空间std中的cout


命名空间

如果程序很大，又是团队开发，出现同名变量的情况可能会很多，C++通过命名空间来解决这一问题

```
namespace ZhangSan {
    int x;
}
namespace LiSi {
    int x;
}
int main(int argc, const char * argv[])
{
    ZhangSan::x = 9;
    LiSi::x = 8;
    int x = 10;
    std::cout << "main x:" << x << ", Zhangsan x:" << ZhangSan::x << ", Lisi x:" << LiSi::x << "\n";
    return 0;
}
```

命名空间 using 关键字

使用using关键字可以开放指定的命名空间，简化代码的编写

```
using namespace std;
namespace ZhangSan {
    int x;
}
namespace LiSi {
    int x;
}
int main(int argc, const char * argv[])
{
    ZhangSan::x = 9;
    LiSi::x = 8;
    int x = 10;
    cout << "main x:" << x << ", Zhangsan x:" << ZhangSan::x << ", Lisi x:" << LiSi::x << "\n";
    return 0;
}
```

\n & std::endl的区别

* endl除了具备\n的换行功能之外，还会调用输出流的flush函数，刷新缓冲区，让数据直接写入文件或者屏幕

* 如果需要立即显示结果，可以使用endl
* 而如果兼顾到效率，可以使用\n，因为\n不会刷新输出缓冲区，效率更高，速度更快
* 此外，由于\n没有调用输出流的flush函数刷新缓冲区，有可能在输出时数据会被保存在缓冲区中，不会立即写入设备


```
cout << "main x:" << x << "\n";
cout << "Zhangsan x:" << ZhangSan::x << "\n";
cout << "Lisi x:" << LiSi::x << endl;
```
C++的数据类型

```
cout << "bool \t" << sizeof(bool) << endl;
cout << "char \t" << sizeof(char) << endl;
cout << "short \t" << sizeof(short) << endl;
cout << "int \t" << sizeof(int) << endl;
cout << "long \t" << sizeof(long) << endl;
cout << "long long \t" << sizeof(long long) << endl;
cout << "float \t" << sizeof(float) << endl;
cout << "double \t" << sizeof(double) << endl;
cout << "long double \t" << sizeof(long double) << endl;

提示：bool型的数值是 true 和 false，非零即真
```
字符串的输入

```
C语言
char name[8];
printf("name:");
scanf("%s", name);
gets(name);
fgets(name, 8, stdin);
scanf("%[^{8}\n]", name);

printf("%s\n", name);

C语言中几种输入方式的对比

由于gets()无法知道字符串的大小，必须遇到换行字符或文件尾才会结束输入，因此容易造成缓存溢出的安全性问题

```

```
C++
char name[8];

cout << "name:";
cin >> name;
cin.get(name, 8);

cout << name << endl;


C++中的字符串输入方式
```






















