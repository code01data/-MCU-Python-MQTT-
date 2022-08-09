#include <stdio.h>

void f(int a[])
{
	//数组名作为参数传过来后，变成指针
	printf("%lu\n", sizeof(a) / sizeof(a[0]));	
}

int main()
{
	int a[10] = {0};

	printf("%lu\n", sizeof(a) / sizeof(a[0]));

	f(a);

	return 0;
}

