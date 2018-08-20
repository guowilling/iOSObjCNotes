/*
 输入一个正整数n，求出并输出其阶乘n! = 1*2*3*4*...n
 要求：递归方式
*/

#include <stdio.h>

int jieCheng(int n);

int main()
{
    int n = 0;
    while (n <= 0)
    {
        printf("输入一个正整数：\n");
        scanf("%d", &n);
    }
    
    int result = jieCheng(n);
    
    printf("%d! = %d\n", n, result);
    
    return 0;
}

int jieCheng(int n)
{
    if (n == 1) return 1;
    
    // jieCheng(n) = n! = 1*2*3*...*(n-1)*n
    // jieCheng(n-1) = (n-1)! = 1*2*3*...*(n-1)
    // jieCheng(n) = jieCheng(n-1) * n
    return jieCheng(n-1) * n;
}