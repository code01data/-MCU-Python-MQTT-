#include <stdio.h>

int less(int x, int y)
{
	return (x > y) ? 1 : 0;
}

int greater(int x, int y)
{
	return (x < y) ? 1 : 0;
}

//回调函数：把函数名作为另一个函数的参数
//作用：修改函数的功能
void sort(int *a, int len, int (*p)(int, int))
{
	int i, j;
	for (i = 0; i < len - 1; i++)
	{
		for (j = 0; j < len - i - 1; j++)
		{
			//if (a[j] < a[j + 1])
			if (p(a[j], a[j + 1]))    //通过函数指针调用函数
			{
				int num = a[j];
				a[j] = a[j + 1];
				a[j + 1] = num;
			}
		}
	}
}

int main()
{
	int a[10] = {0};

	int i;
	for (i = 0; i < 10; i++)
	{
		scanf("%d", &a[i]);
	}

	sort(a, 10, greater);

	for (i = 0; i < 10; i++)
	{
		printf("%d ", a[i]);
	}
	printf("\n");


	return 0;
}
