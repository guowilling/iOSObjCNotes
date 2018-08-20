/*
 定义函数输出一个整数在内存中的二进制形式
 */

#include <stdio.h>
void printBinary(int number);

int main()
{
    /*
     0000 0000 0000 0000 0000 0000 0000 0000
     0000 0000 0000 0000 0000 0000 0000 1111
     
     9   : 0000 0000 0000 0000 0000 0000 0000 1001
     -10 : 1111 1111 1111 1111 1111 1111 1111 0110
     */
    //printf("%d\n", ~9);
    
    printBinary(-10);
    return 0;
}

void printBinary(int number)
{
    
    // 记录挪到第几位
    int temp = (sizeof(number)<<3) - 1;
    
    while (temp >= 0)
    {
        // 先挪位，再&1
        int value = (number>>temp) & 1;
        printf("%d", value);
        
        temp--;
        
        // 每输出4位，输出一个空格
        if ((temp + 1) % 4 == 0)
        {
            printf(" ");
        }
    }
    printf("\n");
}