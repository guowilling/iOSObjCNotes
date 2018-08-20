#include <stdio.h>

int main()
{
    //int size = sizeof(10);
    //int size = sizeof 10.9;
    
    int a = 10;
    
    //int size = sizeof(a);
    //int size = sizeof a;
    
    int size = sizeof(char);
    // int size = sizeof char; // 错误写法
    
    printf("size=%d\n", size);
    
    return 0;
}