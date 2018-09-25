// 全局变量：a、b、c
// 局部变量：v1、v2、e、f

#include <stdio.h>

int a = 10;
int b , c = 20;

int sum(int v1, int v2)
{
    return v1 + v2;
}

void test()
{
    b++;
    
    int i = 0;
    i++;
    
    printf("b=%d, i=%d\n", b, i);
}

int main()
{
    test();
    test();
    test();
    
    int e = 10;
    
    {
        {
            int f = 30;
        }
    }
    
    return 0;
}