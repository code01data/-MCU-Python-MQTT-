#include <stdio.h>

int main()
{
	char str[32] = "helloworld";
	char *p = "helloworld";

	//str++;    //数组名是常指针（地址常量） 不能修改
	p++;        //指向下一个元素 e

	//char *const q = "helloworld";
	//q++;

	str[0] = 'x';
	//p[0] = 'x';    //字符串常量 不能修改

	printf("%lu\n", sizeof(str));   //数组的长度 32
	printf("%lu\n", sizeof(p));     //指针的长度 8

	return 0;
}
