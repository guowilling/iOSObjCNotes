#include <stdio.h>

/*
 1.内存寻址由大到小，优先分配内存地址比较大的字节给变量
 
 2.变量越先定义，内存地址就越大
 
 3.取得变量的地址：&变量名
 
 4.输出地址：%p
 
 5.变量必须初始化才能使用
 */

int main()
{
    // 内存寻址由大到小
    int a = 10;
    
    int b = 20;
    
    int c;
    
    // &是一个地址运算符，取得变量的地址
    
    // %p用来输出地址
    
    // 0x7fff56f09bc8
    printf("a的地址是：%p\n", &a);
    // 0x7fff56f09bc4
    printf("b的地址是：%p\n", &b);
    // 0x7fff56f09bc0
    printf("c的地址是：%p\n", &c);
    
    //变量c没有初始化，直接使用不对
    //int d = c  + 1;
    printf("c的值是%d\n", c);
    
    return 0;
}