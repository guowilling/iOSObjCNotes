#include <stdio.h>

int main()
{
    /*
        算数运算符的基本使用
        int a = 10 + 1 + 2 - 3 + 5;
        
        int b = -10;
        
        int c = 10 * b;
        
        int d = 10 / 2;
        
        // 取余运算、模运算
        // %两边都是整数
        // %取余结果的正负性只跟%左边有关
        int e = 10 % -3;
        printf("%d\n", e);
    */
    
    /*
        // 自动类型转换(double->int)
        int a = 10.8;
        
        // 强制类型转换（double->int）
        int b = (int) 10.5;
        printf("%d\n", a);
     */
    
    // 自动类型提升(int->double)
    double c = 10.6 + 6;

    double d = 1 / 3;
    
    double e = (double)3/2;
    
    printf("e的值是%f\n", e);
    
    
    return 0;
}