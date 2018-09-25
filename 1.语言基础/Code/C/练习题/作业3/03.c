/*
 题目：输入一个小于10的正整数n，如果n是5，输出下列图形，其他n值以此类推
 1
 22
 333
 4444
 55555
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
    
    
    for (int row = 1; row<=n; row++) {
        for (int col = 1; col<=row; col++) {
            printf("%d", row); 
        }
        printf("\n");
    }
    return 0;
}