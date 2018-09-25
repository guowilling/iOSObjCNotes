#include <stdio.h>

void change(int);

int main()
{
    /*
    int a = 90;
    change(&a);
    printf("a=%d\n", a);
     */

    // 格式：变量类型 *变量名;
    // 指针变量只能存储地址
    // 指针作用：根据地址值，访问对应的存储空间
    // 指针变量p前面的int：指针变量p只能指向int类型的数据
    
    int *p;
    int a = 90;
    p = &a;
    
    *p = 10;
    
    a = 20;
    
    printf("%d\n", *p);
    
    // printf("%d\n", a);
    
    return 0;
}

void change(int n)
{
    n = 10;
}