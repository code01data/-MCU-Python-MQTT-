#include <stdio.h>

void swap(int *x, int *y)
{
	int t = *x;
	*x = *y;
	*y = t;
}

int main()
{
	int a = 1, b = 2;

	swap(&a, &b);     //如果要交换实参的值，必须要传地址

	printf("a = %d b = %d\n", a, b);

	return 0;
}

