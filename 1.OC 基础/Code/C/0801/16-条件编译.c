#include <stdio.h>

// #if必须和#endif配对

// #define A 5

int main()
{
#ifndef A
// #ifdef A
// #if !defined(A)
    printf("哈哈\n");
#endif
    
    /*
    int a = 10;
    if (a == 10)
    {
        printf("a是10\n");
    }
    else if (a == 5)
    {
        printf("a是5\n");
    }
    else
    {
        printf("a其他值\n");
    }*/
    
    /*
    #if (A == 10)
        printf("a是10\n");
    #elif (A == 5)
        printf("a是5\n");
    #else
        printf("a其他值\n");
    #endif
     */
    
    return 0;
}