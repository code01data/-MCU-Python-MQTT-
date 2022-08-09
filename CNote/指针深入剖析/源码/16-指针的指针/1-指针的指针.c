#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void init(char **s)
{
	*s = (char *)malloc(sizeof(char) * 128);
}

int main()
{
	char *str = NULL;

	init(&str);    //如果要修改实参的值 必须传地址

	strcpy(str, "hello");

	return 0;
}
