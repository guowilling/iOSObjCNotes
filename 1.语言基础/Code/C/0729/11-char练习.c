#include <stdio.h>
/*
 1.说出下面程序的输出结构
 int i = 67 + '4';
 char c = 'c' - 10;
 
 printf("%d - %c\n", i, i);
 printf("%d - %c\n", c, c);
 
 
 2.定义函数，小写转为大写
 
 */

char upper(char c)
{
    /*
    if (c>='a' && c<='z') { // ['a', 'z']
        return c - ('a'-'A');
    } else {
        return c;
    }*/
    
    if (c>='a' && c<='z') { // ['a', 'z']
        return c - ('a'-'A');
    }
    return c;
}

int main()
{
    char cc = upper('f');
    
    printf("%c\n", cc);
    
    return 0;
}