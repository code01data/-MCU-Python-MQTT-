#include <stdio.h>
#include <stdlib.h>

void delete_space(char *s)
{
	while (*s != '\0')
	{
		*s = *(s + 1);
		s++;
	}
}

int main()
{
	char *str = (char *)malloc(128);

	//scanf("%[^\n]", str);   //遇到'\n'结束  遇到空格不结束

	//gets(str);

	char ch;
	int i = 0;
	while ((ch = getchar()) != '\n')
	{
		*(str + i++) = ch;
	}
	
	char *begin = str;

	while (*str != '\0')
	{
		if (*str == ' ')
		{
			delete_space(str);
		}
		else 
		{
			str++;
		}
	}

	printf("%s\n", begin);
	
	return 0;
}
