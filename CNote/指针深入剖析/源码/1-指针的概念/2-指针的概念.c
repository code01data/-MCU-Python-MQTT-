#include <stdio.h>

int main()
{
	int num = 1;
	int *p = &num;
	*p = 100;             //等价于num = 100
	printf("num = %d\n", num);

	char ch = 'a';
	//int *q = &ch;       //类型不能兼容
	char *q = &ch;
	*q = 'x';
	printf("%c\n", ch);

	printf("%p\n", p);
	printf("%p\n", q);

	printf("%p\n", p + 1);//p指向的是整数，整数占4字节，所以p+1加4个字节   
	printf("%p\n", q + 1);//q指向的是字符，字符占1字节，所以q+1加1个字节

	return 0;
}
