#include <stdio.h>

void f1()
{
	printf("helloworld\n");
}

int add(int x, int y)
{
	return x + y;
}

typedef int (*T)(int, int);    //声明一个新的类型T T表示函数指针类型

int main()
{
	void (*p)();    //定义函数指针
	p = f1;
	p();            //通过函数指针调用函数 等价于 f1()

	//p = add;      //类型不兼容
	int (*q)(int, int) = add;
	printf("%d\n", q(1, 2));

	T q1 = add;   //等价于 int (*q1)(int, int);

	return 0;
}
