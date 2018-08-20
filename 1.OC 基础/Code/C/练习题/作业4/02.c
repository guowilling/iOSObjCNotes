/*
 定义函数void strlink(char s[], char t[])，拼接字符串（利用数组）
 */

#include <stdio.h>

void strlink(char s[], char t[]);

int main()
{
    char s1[20] = "michael ";
    char s2[] = "jackson";
    
    strlink(s1, s2);
    
    printf("%s\n", s1);
    
    return 0;
}

void strlink(char s[], char t[])
{
    int i = 0;
    
    // 找到s字符串的尾部
    while ( s[i] != '\0' )
    {
        i++;
    }
    
    int j = 0;
    // 拷贝t内容到s尾部
    while ((s[i] = (t[j]) != '\0'))
    {
        i++;
        j++;
    }
}

/*
 更加精简的写法，参考
 void strlink2(char s[], char t[])
{
    int i = -1;
    while (s[++i]) ;
    
    int j = 0;
    while (s[i++] = t[j++]) ;
}*/
