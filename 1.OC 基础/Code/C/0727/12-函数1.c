
#include <stdio.h>

/*
 1.什么情况使用函数：添加一个新功能
 
 2.函数定义格式
 返回值类型  函数名(形式参数列表)
 {
    函数体
 }
 */

int printLine()
{
    printf("-------------\n");
    return 0;
}

int average(int num1, int num2)
{
    return (num1 + num2)/2;
}

int main()
{
    /*
    printLine();
    printLine();
    printLine();
     */
    
    int a = 10;
    int b = 9;
    int c = average(a, b);
    printf("c is %d\n", c);
    
    int a1 = 11;
    int b1 = 20;
    int d = average(a1, b1);
    printf("d is %d\n", d);
    
    return 0;
}