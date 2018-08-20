/*
 include
    作用：拷贝右边文件的所有内容到 #include所在位置
    注意：自定义文件用""，系统自带文件用<>
 */

// #include <stdio.h> 目的：拷贝printf函数的声明
#include <stdio.h>

int main()
{
    printf("哈哈哈\n");
    
 #include "haha/abc.txt"
//#include "全路径"
    return 0;
}