
#include <stdio.h>
int sumAndMinus(int n1, int n2, int *n3);

int main()
{
    int a = 10;
    int b = 7;
    
    // 存储和
    int he;
    // 存储差
    int cha;
    
    he = sumAndMinus(a, b, &cha);
    
    printf("和是%d, 差是%d\n", he, cha);
    
    return 0;
}

int sumAndMinus(int n1, int n2, int *n3)
{
    *n3 = n1 - n2;
    
    return n1 + n2;
}