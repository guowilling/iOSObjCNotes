#include <stdio.h>

int main()
{
    /* 1.输入字符
    char myc;
    
    scanf("%c", &myc);
    
    printf("输入的字符是%c\n", myc);
     */
    
    /* 2.一次性输入多个数值，并且以某些符号隔开
    int num1, num2;
     
    scanf("%d#%d", &num1, &num2);
    
    printf("num1=%d, num2=%d\n", num1, num2);
    */
    
    /*
    3.如果scanf参数中以空格隔开，实际输入可以以空格、tab、回车作为分隔符
    int num1, num2;
    scanf("%d %d", &num1, &num2);
    printf("num1=%d, num2=%d\n", num1, num2);
     */
    
    /*
    4.scanf中不能写\n
    int a;
    scanf("%d\n", &a); // 错误写法
    printf("a的值是%d\n", a);
     */
    
    return 0;
}