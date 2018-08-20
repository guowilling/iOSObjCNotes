/*
 定义函数void strlink(char *s, char *t)，拼接字符串（利用指针）
 */

#include <stdio.h>

void strlink(char *s, char *t);

int main()
{
    char s1[20] = "michael ";
    char s2[] = "jackson";
    
    strlink2(s1, s2);
    
    printf("%s\n", s1);
    
    return 0;
}

void strlink(char *s, char *t)
{
    // 找到s字符串尾部
    while ( *s != '\0' )
    {
        s++;
    }
    
    // 拷贝t内容到s尾部
    while ( (*s = *t) != '\0' )
    {
        s++;
        t++;
    }
}



/*
 更加精简的写法，参考
 void strlink2(char *s, char *t)
 {
     while (*s++);
     s--;
     
     while ( *s++ = *t++ ) ;
 }*/
