
/*
 输入一个正整数n，计算1+2+3+…+n
 */

#include <stdio.h>

int main()
{
    // 1.提示输入
    printf("请输入一个正整数：\n");
    // 2.接收输入
    int n;
    scanf("%d", &n);
    
    if (n<=0)
    {
        printf("非法输入\n");
        return 0;
    }
    
    // 3.计算
    // (1 + n) * n / 2;
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