
#include <stdio.h>

// 内部函数
static void test2();

// 外部函数
/*
extern void test()
{
    printf("调用了test函数\n");
}*/

// 默认所有的函数都是外部函数
void test()
{
    printf("调用了test函数\n");
    
    test2();
}


// 内部函数
static void test2()
{
    printf("调用了test2函数\n");
}