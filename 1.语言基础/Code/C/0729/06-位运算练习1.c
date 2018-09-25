#include <stdio.h>

/*
 ^运算符交换两个变量的值
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
    
    /*
    a = b - a;
    b = b - a;
    a = b + a;
    */
    
    // a^b^a == b
    
    // a -->  10^11
    // b -->  10
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    
    printf("a=%d, b=%d\n", a, b);
    
    return 0;
}