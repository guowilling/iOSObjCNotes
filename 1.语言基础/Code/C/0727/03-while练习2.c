
/*
 输入一个正整数n，计算1+2+3+…+n
 */

#include <stdio.h>

int main()
{
    // 必须初始化
    int n = 0;
    while (n <= 0)
    {
        // 1.提示输入
        printf("请输入一个正整数：\n");
        // 2.接收输入
        scanf("%d", &n);
    }
    
    // 3.计算
    int sum = 0;
    int number = 0;
    while (number < n)
    {
        number++;
        sum += number;
    }
    printf("%d\n", sum);
    
    return 0;
}