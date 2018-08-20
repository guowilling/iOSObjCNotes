#include <stdio.h>


double haha(double d, char *s, int a)
{
    
}

/*
 定义指向函数的指针
    double (*p)(double, char *, int);
    p = haha;
    或者
    double (*p)(double, char *, int) = haha;
 
 间接调用函数
        p(10.7, "jack", 10);
        (*p)(10.7, "jack", 10);
 */

void test()
{
    printf("调用了test函数\n");
}

int sum(int a, int b)
{
    return a + b;
}

int main()
{
    // 定义指针变量指向sum函数
    // 左边的int：指针变量p指向的函数返回int类型的数据
    // 右边的(int, int)：指针变量p指向的函数有2个int类型的形参
    int (*p)(int, int);
    
    p = sum;
    
    // int c = p(10, 11);
    
    // int c = (*p)(10, 11);
    
    int c = sum(10, 9);
    
    printf("c is %d\n", c);
    
    return 0;
}


void test1()
{
    // (*p)代表指针变量p指向函数
    // 左边的void：指针变量p指向的函数没有返回值
    // 右边的()：指针变量p指向的函数没有形参
    void (*p)();
    
    // 指针变量p指向test函数
    p = test;
    
    // p();
    
    // (*p)(); // 间接调用函数
    
    // test(); // 直接调用函数
}