
#include <stdio.h>

/*
 if (条件)
 {
 
 }
 
 while (条件)
 {
    循环体
 }
 
 运行原理
 1.条件不成立，不会执行循环体
 2.如果条件成立，执行一次循环体，再次判断条件是否成立......
 
 break
 直接结束while循环
 continue
 结束当前循环过程，进入下一次循环过程
 */

int main()
{
    // 1.确定需要重复执行的操作
    // 2.确定约束条件
    int count = 0;
    /*
    while (count<50)
    {
        ++count;
        if (count%10 != 0)
        {
            printf("做第%d次俯卧撑\n", count);
        }
    }*/
    
    /*
    while (count<50)
    {
        ++count;
        if (count%10 == 0)
        {
            // 直接结束这一次循环，进入下一次循环
            continue;
        }
        printf("做第%d次俯卧撑\n", count);
    }*/
    
    while (count < 50)
    {
        ++count;
        printf("做第%d次俯卧撑\n", count);
        
        if (count == 20)
        {
            break;
        }
    }
    return 0;
}