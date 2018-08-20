#include <stdio.h>
int main()
{
    double d = 10.5;
    double d2 = 10.5;
    
    double *p;
    
    p = &d;
    *p = 10.9;
    
    p = &d2;
    *p = 10.9;
    
    printf("d=%f, d2=%f\n", d, d2);
    
    
    // 清空
    // p = NULL;
    p = 0;
    // *p = 100.7; // 错误，清空指针之后不能这样写

    return 0;
}