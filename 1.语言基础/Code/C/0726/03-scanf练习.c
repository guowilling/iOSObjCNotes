/*
 提示用户输入两个整数，计算并输出两个整数的和
 */

#include <stdio.h>

int main()
{
    // 定义2个变量，保存用户输入的整数
    int num1, num2;
    
    // 提示用户输入第1个整数
    printf("请输入第1个整数：\n");
    // 接收用户输入的第1个整数
    scanf("%d", &num1);
    
    // 提示用户输入第2个整数
    printf("请输入第2个整数：\n");
    // 接收用户输入的第2个整数
    scanf("%d", &num2);
    
    // 计算和，并输出
    int sum = num1 + num2;
    printf("%d+%d=%d\n", num1, num2, sum);
    
    //printf("num1=%d, num2=%d\n", num1, num2);
    return 0;
}