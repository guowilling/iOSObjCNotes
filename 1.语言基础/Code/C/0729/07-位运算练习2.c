#include <stdio.h>
/*
 &运算符判断变量的奇偶性
 */
int main()
{
    /*
     15: 1111
     9:  1001
     
     14: 1110
     10: 1010
     */
    
    int a = 15;
    a&1 == 1 // 奇数
    a&1 == 0 // 偶数
    
    /*
    if (a%2) {
        printf("奇数\n");
    } else {
        printf("偶数\n");
    }
     */
    
    //a%2==0?printf("偶数\n"):printf("奇数\n");
    
    //a%2?printf("奇数\n"):printf("偶数\n");
    
    return 0;
}