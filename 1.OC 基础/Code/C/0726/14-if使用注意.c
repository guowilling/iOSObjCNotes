
#include <stdio.h>

int main()
{
    /*
    if (0)
    {
        printf("A\n");
    }
    else
    {
        printf("B\n");
    }*/
    
    /*
    int a = 10;
    比较时，常量放左边，变量放右边
    // if (a = 0)
    if (0 == a)
    {
        printf("a等于0\n");
    }
    else
    {
        printf("a不等于0\n");
    }*/
    
    /*
    int a = 10;
    // 注意赋值运算符，不要写成两个=
    a = 15;
    printf("%d\n", a);
     */
    
    /* if语句后面不要写;
    if ( 5>6 );
    {
        printf("A\n");
    }*/
    
    
    /*
    if (10 > 6)
    {
        int a = 5;
    }
    printf("%d\n", a);
     */
    
    // 下面的代码是错误的：作用域不明确
    if (10 > 6) int a = 5;
    // if后面的语句中定义新的变量，必须使用大括号{}
    // printf("%d\n", a);
    
    /*
    书写格式
    int a = 10;
    if (a>10) {
    
    } else if (a>5) {
    
    } else {
    
    }
    
    if ()
    {
    
    }
    else if ()
    {
    
    }
    else
    {
    
    }*/
    
    return 0;
}