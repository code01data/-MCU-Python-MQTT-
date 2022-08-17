#include <stdio.h>
#include <stdlib.h>

int main()
{
	int *p = NULL;
	//*p = 100;    //段错误：访问了不能访问的内存

	//如何合法的使用内存
	//1、系统分配的内存
	int a;   
	int *p1 = &a;
	//2、用户申请内存（堆内存）
	char *str = (char *)malloc(32);
	free(str);     //释放内存  如果不释放，内存泄露
	str = NULL;

	return 0;
}
