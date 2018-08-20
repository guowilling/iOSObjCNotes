#include <stdio.h>
void swap(int *v1, int *v2);

int main()
{
    /*
    int a = 10;
    int b = 11;
    swap(&a, &b);
     */
    
    
    int a2 = 90;
    int b2 = 89;
    
    swap(&a2, &b2);
    
    printf("a2=%d, b2=%d\n", a2, b2);
    return 0;
}

/* 仅仅交换了内部指针的指向
void swap(int *v1, int *v2)
{
    int *temp;
    temp = v1;
    v1 = v2;
    v2 = temp;
}*/

// 正确
void swap(int *v1, int *v2)
{
    int temp = *v1;
    *v1 = *v2;
    *v2 = temp;
}

/* 仅仅交换了内部v1、v2的值
void swap(int v1, int v2)
{
    int temp = v1;
    v1 = v2;
    v2 = temp;
}*/

