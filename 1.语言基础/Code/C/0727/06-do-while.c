/*
while (条件)
 {
    
 }

do {
 
} while(条件);
 
 while和do-while的区别
 while特点：如果一开始条件不成立，永远不会执行循环体
 do while特点：不管一开始条件是否成立，至少执行一次循环体
 
 最好使用while
*/

#include <stdio.h>

int main()
{
    int i = 0;
    
    /*
    while (i<0)
    {
        i++;
    }*/
    
    do {
        i++;
    } while (i<0);
    
    printf("i=%d\n", i);

    return 0;
}