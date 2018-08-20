
#include <stdio.h>

/*
 if (条件)
 {
 
 }
 
 switch (数值)
 {
    case 数值1:
            语句1;
            break;
 
    case 数值2:
            语句2;
            break;
 
    default :
            语句3;
            break;
 }
 */

int main()
{
    // int a = 10;
    // break:退出整个switch语句
    // 如果case后面没有break，就会执行后面所有case中的语句，直到遇到break为止
    /*
    int b = 10;
    
    switch (a)
    {
        case 10:
            printf("A\n");
            b++;
        case 5:
            printf("B\n");
            b++;
        case 0:
            printf("C\n");
            b++;
            break;
        default:
            printf("D\n");
            break;
    }
    printf("b的值是%d\n", b);*/
    
    char c = '+';
    int a = 10;
    int b = 20;
    // 如果要在case后面定义新的变量，必须使用大括号{}
    switch (c) {
        case '+':
        {
            int sum = a + b;
            printf("和是%d\n", sum);
            break;
        }
            
        case '-':
        {
            int minus = a - b;
            printf("差是%d\n", minus);
            break;
        }
    }
    
    return 0;
}