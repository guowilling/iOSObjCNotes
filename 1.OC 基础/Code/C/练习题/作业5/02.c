/*
 输入一个正整数n，求出并输出下列结果：1! + 2! + 3! + 4! + ... + n!
 要求： 
    1.非递归
    2.递归
 */

#include <stdio.h>

int pieAdd(int n);

int main()
{

    int n = 0;
    while (n <= 0)
    {
        printf("输入一个正整数：\n");
        scanf("%d", &n);
    }
    
    int result = pieAdd(n);
    
    printf("结果是%d\n", result);
    
    return 0;
}

// ------------------非递归方式----------------
int pieAdd(int n)
{

    int sum = 0;

    for (int i = 1; i<=n; i++)
    {
        // 计算阶乘i!
        int multi = 1;
        for (int j = 1; j<=i; j++)
        {
            multi *= j;
        }
        sum += multi;
    }
    return sum;
}

/*
// ------------------递归方式----------------
int jieCheng(int n)
{
    if (n == 1) return 1;
    
    // jieCheng(n) = n! = 1*2*3*...*(n-1)*n
    // jieCheng(n-1) = (n-1)! = 1*2*3*...*(n-1)
    // jieCheng(n) = jieCheng(n-1) * n
    return jieCheng(n-1) * n;
}

int pieAdd(int n)
{
    if (n == 1) return 1;
    
    // pieAdd(n) = 1! + 2! + ... + (n-1)!+ n! 
    // pieAdd(n-1) = 1! + 2! + ... + (n-1)!
    // pidAdd(n) = pieAdd(n-1) + n!
    return pieAdd(n - 1) + jieCheng(n);
}
 */