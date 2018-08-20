/*
 定义函数计算b的n次方
 
 递归的条件：
 1.函数自己调用自己
 2.必须终止条件
 */

#include <stdio.h>
int pow2(int b, int n);

int main()
{
    int c = pow2(3, 2);
    
    printf("%d\n", c);
    
    return 0;
}

/*
 pow2(b, 0) == 1
 pow2(b, 1) == b == pow2(b, 0) * b
 pow2(b, 2) == b*b == pow2(b, 1) * b
 pow2(b, 3) == b*b*b == pow2(b, 2) * b
 
 n=0，结果是1
 n>0，pow2(b, n) == pow2(b, n-1) * b
 */

int pow2(int b, int n)
{
    if (n = 0) return 1;
    return pow2(b, n-1) * b;
}

/*
int pow2(int b, int n)
{
    // 用来保存计算结果
    int result = 1;
 
    //result *= b;
    //result *= b;
    //result *= b;
    //result *= b;
    //....

    for (int i = 0; i<n; i++)
    {
        result *= b;
    }
    return result;
}*/