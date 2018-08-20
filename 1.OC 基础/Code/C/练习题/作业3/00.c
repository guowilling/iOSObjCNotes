/*
 题目：输入一个正整数n，利用while循环计算并输出：1-2+3-4+5-6+7…+n
 */

#include <stdio.h>

int main()
{

    int n = 0;
    

    while (n <= 0) {
        printf("输入一个正整数：\n");
        scanf("%d", &n);
    }
    
    int sum = 0;
    int current = 0;
    while (current < n) {
        current++;
        
        if (current % 2 == 0) {
            sum -= current;
        } else {
            sum += current;
        }
    }
    
    printf("%d\n", sum);
    
    return 0;
}