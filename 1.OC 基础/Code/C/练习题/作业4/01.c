/*
 定义函数判断某个字符串是否为回文，比如"abcba"
 */

#include <string.h>
#include <stdio.h>
int isHuiwen(char *str);

int main()
{
    printf("%d\n", isHuiwen("a"));
    return 0;
}

/*
 返回1代表是回文
 返回0代表不是回文
 */
int isHuiwen(char *str)
{
    // 1.指针变量left指向字符串首字符
    char *left = str;
    // 2.指针变量right指向字符串末字符
    char *right = str + strlen(str) - 1;
    
    while (left < right)
    {
        if (*left++ != *right--)
        {
            return 0;
        }
    }
    return 1;
}