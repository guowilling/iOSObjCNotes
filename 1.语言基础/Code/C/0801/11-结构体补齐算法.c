#include <stdio.h>

int main()
{
    char c = 'A';
    
    int a = 10;
    
    printf("a=%p\n", &a);
    printf("c=%p\n", &c);
    
    struct Student
    {
        int age;    // 4
        int score;  // 4
        
        char *name; //8
    };
    struct Student stus[3];
     
    printf("%ld\n", sizeof(stus));
    
    return 0;
}