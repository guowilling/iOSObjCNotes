/*
 张三
 编写main函数
 
 链接：整合项目中所有相关联的.o目标文件、C语言函数库合并在一起，生成可执行文件
*/

#include <stdio.h>
#include "李四.h"

int main()
{
    int score1 = 100;
    int score2 = 70;
    
    int c = average(score1, score2);
    int d = sum(score1, score2);
    
    printf("平均分是%d\n", c);
    printf("总分是%d\n", d);
    
    // \n   转义字符
    // \t   tab键
    // \"   一个双引号
    
    // 1个汉字占3个字符
    int e = printf("哈h\"\ta\n");
    
    printf("e=%d\n", e);
    
    return 0;
}

/*
1.函数的定义放.c文件，函数的声明放.h文件
 
2.如果要使用某个.c文件中定义的函数，只需要#include这个.c文件对应的.h文件

cc xx.o xxx.o 链接多个目标文件
cc xx.c xxx.c 编译、链接多个源文件
*/