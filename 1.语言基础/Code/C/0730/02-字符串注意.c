#include <stdio.h>

/*
 \0
 1.字符串结束标记
 2.printf("%s", name2); name2地址开始输出字符，遇到\0为止
 */

int main()
{
    char name1[] = "itc\0ast";
    
    char name2[] = {'o', 'k'};
    
    // printf("%s\n", name2);
    
    printf("%s\n", &name2[1]);
    
    return 0;
}