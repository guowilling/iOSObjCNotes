
#include <stdio.h>

int main()
{
    int a = 10;
    // a = a + 5;
    
    // 复合赋值运算符
    a += 5; // a = a + 5;
    a *= 5; // a = a * 5;
    a += 5 + 6 + 4; // a = a + (5 + 6 + 4);
    
    a = 5 + 6 * 5 + 8;
    
    printf("a的值是%d\n", a);
    
    
    return 0;
}