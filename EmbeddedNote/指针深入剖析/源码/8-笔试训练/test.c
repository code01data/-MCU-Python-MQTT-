#include <stdio.h>

int main()
{
	int a[5] = {1, 2, 3, 4, 5};

	int *p1 = (int*)(&a + 1);
	int *p2 = (int*)((int)a + 1);
	int *p3 = (int*)(a + 1);

	printf("%d\n", p1[0]);
	//printf("%d\n", p2[0]);
	printf("%d\n", p3[0]);

	return 0;
}

