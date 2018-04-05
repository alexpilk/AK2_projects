#include <stdio.h>

extern unsigned long long int as_print(int selector);

void main()
{
	unsigned long long int a = as_print(1);
    printf("%llu\n", a);
}