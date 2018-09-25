/*
 题目：输入一个正整数n，输出下列图形
 *
 **
 ***
 ****
 *****
*/
#include <stdio.h>

int main()
{

    int n = 0;
    while (n <= 0) {
        printf("输入一个正整数：\n");
        scanf("%d", &n);
    }

    printf("-----------------\n");
    
    for (int row = 1; row<=n; row++) {
        for (int col = 1; col<=row; col++) {
            printf("*");
        }
        printf("\n");
    }
    return 0;
}