#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *init()           //指针函数
{
	//char str[32] = {0};
	char *str = (char *)malloc(128);

	return str;
}

int main()
{
	char *s = init();

	strcpy(s, "hello");

	free(s);

	return 0;
}
