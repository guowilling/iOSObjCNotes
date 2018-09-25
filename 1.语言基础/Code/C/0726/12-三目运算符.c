
// 三目运算符：条件 ? 数值1 : 数值2

//int a = !100 ? 9 : 89;
//printf("a=%d\n", a);

#include <stdio.h>

int main()
{
    /* 2个整数之间的最大值
    int a = 10;
    int b = 99;
    int c = a>b ? a : b;
    printf("c is %d\n", c);
    */
    
    // 3个整数之间的最大值
    int a = 10;
    int b = 999999;
    int c = 1000;

    int abMax = (a > b) ? a : b;
    int d = (abMax > c) ? abMax : c;
    //int d = (((a > b) ? a : b) > c) ? ((a > b) ? a : b) : c;
    
    printf("d is %d\n", d);
    
    return 0;
}