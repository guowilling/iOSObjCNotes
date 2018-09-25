#include <stdio.h>
/*
 输入一个时间的秒数，比如500秒然后输出对应的分钟和秒，比如500s就是8分钟20秒
 */
int main()
{
    /*
    // c的范围0-9
    int a = 96546546;
    int c = a % 10;
    */
    
    // 1.提示用户输入时间
    printf("请输入一个时间值（秒）：\n");
    // 2.接收用户输入的时间
    int time;
    scanf("%d", &time);
    
    // 3.转换成对应的分钟和秒
    int minute = time / 60; // 分钟
    int second = time % 60; // 秒
    
    printf("%d秒 = %d分钟%d秒\n", time, minute, second);
    
    return 0;
}