
#include <stdio.h>
int main()
{
    char name[] = "jack";
    
    char name1[] = "rose";
    
    char name2[] = "jim";
    
    char name3[] = "jake";
    
    char names[2][10]= {"jack", "rose"};
    
    // printf("%s\n", names[0]);
    
    // printf("%c\n", names[0][3]);
    
    char names2[2][10] =
    {
        {'j', 'a', 'c', 'k', '\0'},
        {'r', 'o', 's', 't', '\0'}
    };
    return 0;
}