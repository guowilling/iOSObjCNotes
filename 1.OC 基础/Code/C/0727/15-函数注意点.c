#include <stdio.h>
/*
 1.默认不允许函数的名称一样
 2.函数不能嵌套定义
 3.函数不能重复定义，但可以重复声明
 4.如果有函数的声明，没有函数的定义
    1> 编译不报错，因为编译只会检测语法合不合理
    2> 链接会报错，因为链接会检测函数是否定义了
 */

// 函数的声明
//void printLine();
//void printLine();
//void printLine();
//void printLine();
//void printLine();
//void printLine();

int main()
{
    void printLine();
    
    printLine();
    return 0;
}

// 函数的定义
void printLine()
{
    printf("--------\n");
}
