/*
 定义函数char_contains(char str[],char c)，
 如果字符串str中包含字符c返回1，否则返回0
*/

#include <string.h>
#include <stdio.h>

// 可读性 -> 性能 -> 重构

int char_contains(char str[], char c);

int main()
{
    // int result = char_contains("itc8ast", '8');
    
    char name[] = "itcast";
    
    int result = char_contains(name, 'o');
    
    printf("%d\n", result);
    
    return 0;
}

// "itc"  '7'
int char_contains(char str[], char c)
{
    int i = -1;
    
    
    // 遍历整符串
    while ( str[++i] != c && str[i] != '\0' ) ;
    
    // return str[i] == '\0' ? 0 : 1;
    return str[i] != '\0';
}

/*
int char_contains(char str[], char c)
{
    int i = -1;
    
    // 遍历字符串
    while ( str[++i] )
    {
        if (str[i] == c)
        {
            return 1;
        }
    }
    return 0;
}*/

/*
int char_contains(char str[], char c)
{
    int i = 0;
    
    // 遍历字符串
    while ( str[i] != '\0' )
    {
        if (str[i] == c)
        {
            return 1;
        }
        i++;
    }
    return 0;
}*/

/*
int char_contains(char str[], char c)
{
    // 遍历字符串
    for (int i = 0; i<strlen(str); i++)
    {
        if ( str[i] == c )
        {
            return 1;
        }
    }
    return 0;
}
 */