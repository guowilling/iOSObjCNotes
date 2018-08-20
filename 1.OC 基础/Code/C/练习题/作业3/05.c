/*
 定义函数int pieAdd(int n)，计算1!+2!+3!+……+n!的值（n>=1）
 pieAdd(3) = 1! + 2! + 3! = 1 + 1*2 + 1*2*3 = 9
 */
#include <stdio.h>

int pieAdd(int n);

int main()
{
    int result = pieAdd(3);
    printf("%d\n", result);
    return 0;
}

int pieAdd(int n)
{
    if (n<1) return 0;

    int sum = 0;
    
    for (int i = 1; i<=n; i++) {
        int multi = 1;
        for (int j=1; j<=i; j++) {
            multi *= j;
        }
        sum += multi;
    }
    
    return sum;
}