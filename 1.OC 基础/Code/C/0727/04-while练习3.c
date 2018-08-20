/*
 题目：计算1~100中3的倍数的个数
 */

#include <stdio.h>

int main()
{
    int count = 0;
    
    int number = 0;
    
    while (number < 100)
    {
        number++;
        if (number%3 == 0)
        {
            count++;
        }
    }
    
    printf("1~100内3的倍数的个数:%d\n", count);
}