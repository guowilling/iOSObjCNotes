
/*
 带参数的宏定义比函数效率高
 */

/*
int sum(int a, int b)
{
    return a + b;
}*/

#include <stdio.h>

#define sum(v1, v2) ((v1)+(v2))

#define pingfang(a) ((a)*(a))

int main()
{
    // pingfang(5+5) (10*10)
    
    // pingfang(5+5)/pingfang(2)
    int c1 = pingfang(5+5)/pingfang(2);
    
    printf("c1 is %d\n", c1);
    
    /*
    int c = sum(2, 3) * sum(6, 4);
    
    printf("c is %d\n", c);*/
    
 
    int a = 10;
    int b = 20;
    int c2 = sum(a, b);
    printf("c2 is %d\n", c2);
     
    int c3 = sum(a, b);
    printf("c3 is %d\n", c3);
    
    return 0;
}