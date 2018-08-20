
#include <stdio.h>

void change(int *n);

int main()
{
    int a = 90;
    
    change(&a);
    
    printf("%d\n", a);
    
    return 0;
}

void change(int *n)
{
    *n = 10;
}