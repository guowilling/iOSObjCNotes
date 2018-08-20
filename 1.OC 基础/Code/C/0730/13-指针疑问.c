
/*
 %d     int
 %f     float\double
 %ld    long
 %lld   long long
 %c     char
 %s     字符串
 %zd    unsigned long
 */

#include <stdio.h>

/*
 0000 0001
 0000 0010
 0000 0000
 0000 0000
 
 0000 0000 0000 0000 0000 0010 0000 0001
 */

int main()
{
    // 0000 0000 0000 0000 0000 0000 0000 0010
    int i = 2;
    // 0000 0001
    char c = 1;
    
    char *p;
    
    p = &c;
    
    // *p = 10;
    
    printf("c的值是%d\n", *p);
    
    return 0;
}

void test()
{
    char c;     // 1
    int a;      // 4
    long b;     // 8
    
    // 指针都是占8个字节的存储空间
    char *cp;
    int *ap;
    long *bp;
    
    printf("cp=%zd, ap=%zd, bp=%zd\n",sizeof(cp),sizeof(ap),sizeof(bp));
}