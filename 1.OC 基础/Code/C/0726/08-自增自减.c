
#include <stdio.h>

int main()
{
    /*
    int a = 10;
    
    a = a + 1;  // 11
    
    a += 1;     // 12
    
    a++;        // 13
    
    ++a;        // 14
    
    a--; == a -= 1; == a = a - 1;  
    */
    // printf("a的值是%d\n", a);
    
    int b;
    int a = 10;
    // b = 10 + 12;
    // b = (a++) + (++a);
    
    // b = 11 + 11;
    b = (++a) + (a++);
    // a -> 11
    
    // a : 12
    printf("b=%d, a=%d\n", b, a);
    
    return 0;
}