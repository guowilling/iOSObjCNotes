#include <stdio.h>

int main()
{
    /* int *p只能指向int类型的数据
    int *p;
    double d = 10.0;
    p = &d;
     */
    
    /* 指针变量只能存储地址
    int *p;
    p = 200;
     */
    
    /* 指针变量未初始化，不要访问其存储空间
    int *p;
    printf("%d\n", *p);
     */
    
    int a = 10;
    /*
    int a;
    a = 10;
     */
    
    /*
    int *p;
    p = &a;
     */
    
    // 这里的*：只是一个标识没有其他含义
    int *p = &a;
    
    // 这里的*：访问p指向的存储空间
    *p = 20;
    
    char c = 'A';
    
    char *cp = &c;
    
    *cp = 'D';
    
    printf("%c\n", c);
    
    return 0;
}