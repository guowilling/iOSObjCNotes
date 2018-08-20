
#include <stdio.h>

/*
 break
 1.使用场合
    switch语句：退出整个switch语句
    循环结构：退出整个循环语句
    * while
    * do while
    * for
 2.注意点
 只对最近的循环结构有效
 
 continue
 1.使用场合
    循环结构：结束本次循环体，进入下一次循环过程
    * while
    * do while
    * for
 2.注意点
 只对最近的循环结构有效
 */

int main()
{
    /*
    for (int i = 0; i<5; i++)
    {
        printf("%d\n", i);
        
        if (i%2)
        {
            continue;
        }
    }
     */
    
    /*
    for (int i = 0; i<5; i++)
    {
        printf("哈哈哈\n");
        continue;
        printf("哈哈哈2\n");
    }*/
    
    for (int i = 0; i<3; i++)
    {
        for (int j = 0; j<2; j++)
        {
            if (j==1)
            {
                break;
            }
            printf("A\n");
        }
        break;
        printf("B\n");
    }
    return 0;
}