/*
 题目：输入一个小于10的正整数n，如果n是5，输出下列图形，其他n值以此类推
 54321
 5432
 543
 54
 5
*/
#include <stdio.h>

int main()
{
    int n = 0;
    while (n <= 0 || n>=10) {
        printf("输入一个1~9的正整数：\n");
        scanf("%d", &n);
    }
    
    printf("-----------------\n");
    
    for (int row = 1; row <= n; row++) {
        for (int col = n; col >= row; col--) { 
            printf("%d", col);
        }
        printf("\n");
    }
    return 0;
}