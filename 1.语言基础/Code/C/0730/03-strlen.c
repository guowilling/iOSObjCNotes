/*
 strlen函数：计算字符串长度
    1.计算的是字符数，不是字数（一个汉字算3个字符）
    2.计算的字符不包括\0
    3.从某个地址开始，遇到\0为止
 */

// string.h 包含 strlen函数的声明
#include <string.h>
#include <stdio.h>

int main()
{
    // int size = strlen("哈haha");

    // printf("%d\n", size);
    /*
    char name1[] = "itcast";
    char name2[] = {'0', '\0', '6'};
    
    int size = strlen(name2);
    
    printf("%d\n", size);
     */
    
    char name[] = "itcast";
    
    // printf("%s\n", name);
    
    printf("%c\n", name[3]);
    
    return 0;
}