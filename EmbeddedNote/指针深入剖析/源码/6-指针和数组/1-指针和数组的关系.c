#include <stdio.h>

int main()
{
	int a[5] = {1, 2, 3, 4, 5};
	int *p = a;

	int i;
	for (i = 0; i < 5; i++)
	{
		//printf("%d ", a[i]);
		printf("%d ", *(p + i));   //通过指针的形式访问数组 a[i]等价于*(a+i)
	}
	printf("\n");

	char *str = "helloworld";
	printf("%c\n", *str);
	//通过数组的形式访问指针
	for (i = 0; i < 10; i++)
	{
		printf("%c", str[i]);
	}


	return 0;
}
