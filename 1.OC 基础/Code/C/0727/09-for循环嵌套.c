/*
 好友列表1
    好友1
    好友2
 好友列表2
    好友1
    好友2
 好友列表3
    好友1
    好友2
 */

#include <stdio.h>
int main()
{
    
    for (int i = 1; i<=4; i++)
    {
        printf("好友列表%d\n", i);
        
        /*
        printf("    好友1\n");
        printf("    好友2\n");
        printf("    好友3\n");
        printf("    好友4\n");
        printf("    好友5\n");
         */
        
        for (int j = 1; j<=7; j++)
        {
            printf("    好友%d\n", j);
        }
    }
    
    return 0;
}