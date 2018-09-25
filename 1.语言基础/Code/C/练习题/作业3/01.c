/*
 题目：输入一个正整数n，计算并输出：1*2*3*…*n
 */
#include <stdio.h>

int main()
{
    int n = 0;
    while (n <= 0) {
        printf("输入一个正整数：\n");
        scanf("%d", &n);
    }
    

    int result = 1;
    int current = 1;
    while (current <= n) {
        result *= current;
        current++;
    }
    
    printf("%d! = %d\n", n, result);
    
    return 0;
}