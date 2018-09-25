#include <stdio.h>
int main()
{
    int a = 10;
    
    int *p = &a;
    
    int **pp = &p;
    
    // a = 20;
    
    // *p = 20;
    
    /*
    (*pp) == p
    
    *(*pp) == *p = a
    
    **pp == *p = a
     */
    
    **pp = 20;
    
    printf("%d\n", a);
    
    // int ***ppp = &pp;
    
    /*
    char a2 = 'A';
    char *p2 = &a2;
     */
    
    return 0;
}