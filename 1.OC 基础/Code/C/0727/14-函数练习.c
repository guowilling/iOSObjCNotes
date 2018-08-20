
/*
 	两个整数的差
 	打印1条横线
 	打印N条横线
 
 定义函数的步骤
    1> 确定函数的名称
    2> 确定函数的形参
    3> 确定函数的返回值
 */
#include <stdio.h>

void printLines(int n)
{
    for (int i = 0; i<n; i++)
    {
        printf("-------------------\n");
    }
}

void printLine()
{
    printf("-------------------\n");
}

int minus(int a, int b)
{
    return a - b;
}

int main()
{
    printLines(10);
    //printLine();
    //printf("%d\n", minus(100, 29));
    
    return 0;
}