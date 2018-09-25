#include <stdio.h>

/*
 %d\%i  十进制形式输出整数
 %o     八进制形式输出整数
 %x     十六进制形式输出整数
 %c     输出字符
 %p     输出地址
 %f     输出小数
 */

int main()
{
    // 默认十进制
    int number1 = 12;
    
    // 二进制(0b或者0B开头)
    int number2 = 0B1100;
    
    // 八进制（0开头）
    int number3 = 014;
    
    // 十六进制（0x或者0X开头）
    int number4 = 0xc;
    printf("%x\n", number);
    
    return 0;
}