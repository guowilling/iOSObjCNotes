/*
 全局变量：
 extern int a;
 外部全局变量：能被本文件和其他文件访问
 默认所有的全局变量都是外部变量
 不同文件中的同名外部变量，代表同一个变量
 
 static int b;
 内部全局变量：只能被本文件访问，不能被其他文件访问
 不同文件中的同名内部变量，互不影响
 
 static作用于变量：定义一个内部变量
 extern作用于变量：声明一个外部变量
 */

#include <stdio.h>

void test();

// 内部全局变量
static int b;

int main()
{
    b = 10;
    printf("b的值是%d\n", b);

    extern int a; // 引用其他文件定义的全局外部变量a(不是重新定义)
    a = 10;
    
    test();
    
    printf("a的值是%d\n", a);

    return 0;
}