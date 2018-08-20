
#include <stdio.h>

// 外部变量
// extern int a;
int a;
//int a; 这么多个a都是代表同一个a
//int a;
//int a;
//int a;
//int a;

// 内部变量
static int b;

void test()
{
    printf("b的值是%d\n", b);
    
    printf("a的值是%d\n", a);
    
    a = 20;

}