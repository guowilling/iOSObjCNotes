#include <stdio.h>

int main()
{
    int number;
    // scanf函数接受变量地址
    // scanf是阻塞式函数，等待用户输入
    // 用户输入的值赋值给number变量
    scanf("%d", &number);
    
    printf("用户输入的值是%d\n", number);
    
    return 0;
}