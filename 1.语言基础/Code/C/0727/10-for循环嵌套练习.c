/*
 提示用户输入一个正整数n，如果n=5，就输出下列图形，其他类推
 *****
 ****
 ***
 **
 *
 */

#include <stdio.h>

int main()
{
    int n = 0;
    while (n <= 0)
    {
        // 提示用户输入正整数
        printf("请输入一个正整数:\n");
        // 接收输入的数据
        scanf("%d", &n);
    }
    
    // 输出图形
    for (int i = 0; i<n; i++)// 多少行
    {
        for (int j = 0; j<n-i; j++)
        {
            // 每行个数
            printf("*");
        }
        printf("\n");
    }
    return 0;
}