#include <stdio.h>

/*
 a = 10
 b = 11
 交换之后
 a -> 11
 b -> 10
 
 1.利用第三方变量
 int temp = a;
 a = b;
 b = temp;
 
 2.不利用第三方变量
 a = b - a;
 b = b - a;
 a = b + a;
 */

int main()
{
    int a = 10;
    int b = 11;
    /*
    int temp = a;
    a = b;
    b = temp;
    */
    a = b - a; 
    b = b - a;
    a = b + a;
    
    printf("a=%d, b=%d\n", a, b);
    
    return 0;
}