#include <stdio.h>
/*
 定义函数 int string_len(char *s)，返回字符串s的长度 (不包括\0)
 */

int string_len(char *s);

int main()
{
    // char *name = "itcast";
    
    int size = string_len("tre777");
    
    printf("%d\n", size);
    
    return 0;
}

int string_len(char *s)
{

    char *p = s;
    
    /*
    while ( *s != '\0' )
    {
        s++;
    }*/
    
    while (*s++) ;
    
    return s - p - 1;
}

/*
int string_len(char *s)
{
    int count = 0;
    

    while (*s++)
    {
        count++;
        
        // 让指针指向下一个字符
        // s = s + 1;
        // s++;
    }
    return count;
}
 */

/*
int string_len(char *s)
{

    int count = 0;

    while ( *s != '\0')
    {

        count++;
        
        // 让指针指向下一个字符
        // s = s + 1;
        s++;
    }
    return count;
}
 */