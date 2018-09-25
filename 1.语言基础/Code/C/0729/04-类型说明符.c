#include <stdio.h>
/*
 int            4个字节    %d
 short          2个字节    %d
 long           8个字节    %ld
 long long      8个字节    %lld
 
 signed
 unsigned       %u
 */
int main()
{
    // 0000 0000 0000 0000 0000 0000 0000 0000
    // 2的31次方-1
    // 2的32次方-1
    int num;
    
    /*
    signed和unsigned区别：
    signed      最高位当做符号位
    unsigned    最高位不当做符号位
     */
    // signed == signed int
    // signed 有符号:正数、0、负数
    signed int a1 = 10;
    signed a2 = 10;
    
    // unsigned == unsigned int
    // unsigned 无符号:0、正数
    unsigned int b1 = 10;
    unsigned b2 = 10;
    
    long unsigned int c1 = 34343;
    long unsigned c2 = 423432;
    
    short unsigned int d1 = 4343;
    short unsigned d2 = 43243;
    
    short signed int e1 = 54354;
    short signed e2 = 434;
    
    return 0;
}

void longAndShort()
{
    // long == long int
    long int a = 100645654654645645l;
    long a2 = 100645654654645645l;
    
    // long long == long long int
    long long int c = 100645654654645645ll;
    long long c2 = 4535435435435ll;
    // printf("%lld\n", c);
    
    // short == short int
    short int d = 5454;
    short d2 = 43434;
    
    int s = sizeof(long long int);
    printf("%d\n", s);
}