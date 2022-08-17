#include <stdio.h>

void mystrcpy(char *dest, const char *src)
{
	while ((*dest++ = *src++) != '\0');
}

int main()
{
	char s1[32] = "hello";
	char s2[32] = "123456789";

	mystrcpy(s2, s1);

	printf("%s\n", s2);

	return 0;
}

void f()
{
	int num;

	const int *p1 = &num;   //const修饰*p1 即num
	//(*p1)++;
	p1++;

	int *const p2 = &num;  //const修饰p2
	//p2++;
	(*p2)++;

	const int *const p3 = &num;
}
