/*
 题目：计算两个数的加法或减法
 */
#include <stdio.h>

int main()
{

    printf("请输入相应数字选择需要执行的运算：\n");
    printf("1 加法\n");
    printf("2 减法\n");

    int type = 0;
    scanf("%d", &type);
    
    if (type!=1 && type!=2)
    {
        printf("非法选择\n");
        return 0;
    }

    printf("请连续输入两个需要进行运算的整数，并且以空格隔开\n");
    
    int num1, num2;
    scanf("%d %d", &num1, &num2);
    
    int result;
    if (type == 1) {
        result = num1 + num2;
        printf("%d + %d = %d\n", num1, num2, result);
    } else if (type == 2) {
        result = num1 - num2;
        printf("%d - %d = %d\n", num1, num2, result);
    }
    return 0;
}