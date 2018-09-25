/*
 1.预处理指令都是以#开头
 
 2.预处理指令分3种
    宏定义
    条件编译
    文件包含
 
 3.预处理指令在代码翻译成0、1之前执行
 
 4.预处理指令的位置不限
 
 5.预处理指令的作用域：从编写指令开始，到文件结尾，#undef可以取消宏定义
 
 6.宏名一般用大写或者k开头，变量名一般用小写
 */
#include <stdio.h>

// #define kCount 4

int main()
{
    char *name = "COUNT";
    
    printf("%s\n", name);
    
    #define COUNT 4
    
    int ages[COUNT] = {1, 2, 67, 89};
    
    for ( int i = 0; i<COUNT; i++) {
        printf("%d\n", ages[i]);
    }
    
#undef COUNT
    
    int a = COUNT;
    
    return 0;
}

void test()
{
    
}