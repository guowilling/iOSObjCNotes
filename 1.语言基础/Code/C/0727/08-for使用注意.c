#include <stdio.h>
int main()
{
    /* 不要随便在for()后面写分号
    for (int i=0; i<5; i++);
    {
        printf("哈哈\n");
    }
     */
    
    /* 
    错误:变量a的作用域不明确
    如果要在循环体中定义新的变量，必须使用大括号{}
    for (int i=0; i<5; i++)
        int a = 10;
     */
    
    /* 错误
    for (int i = 0; i<10; i++, a++)
    {
        // a只能用在循环体{}中
        int a = 10;
    }
     */
    
    /*
    int a = 10;
    for (int i=0, a= 9; i<5; i++)
    {
     // int i = 10;
     
        int a = 11;
        printf("a=%d\n", a);
    }*/
    
    // for循环实现死循环
    // for(;;);
    
    return 0;
}