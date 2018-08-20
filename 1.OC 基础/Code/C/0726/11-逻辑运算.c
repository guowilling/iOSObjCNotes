#include <stdio.h>

int main()
{
    // 逻辑与：条件1 && 条件2
    // int a  =  10>3 && 7<6;
    // int a = 0 && 10;
    // printf("a=%d\n", a);
    
    /*
    int a = 10;
    int b = 10;
    
    int c = (a>5) && (++b>=11);
    
    int c = (a<5) && (++b>=11);
    
    // a = 10
    // b = 10
    // c = 0
    printf("a=%d, b=%d, c=%d\n", a, b, c);*/
    
    
    // 逻辑或：条件1 || 条件2
    //int a = 0 || 11;
    
    /*
    int a = 10;
    int b = 10;
    int c = (a<5) || (b++ - 10);
    
    // a = 10
    // b = 11
    // c = 0
    printf("a=%d, b=%d, c=%d\n", a, b, c);*/
    
    // 逻辑非：!条件
    // 条件成立，返回0；条件不成立，返回1
    // int a = !(10>8);
    // int a = !-10;
    // int a = !10>8;
    
    /*
    int a = !!10;
    printf("a=%d\n", a);
    */
    return 0;
}