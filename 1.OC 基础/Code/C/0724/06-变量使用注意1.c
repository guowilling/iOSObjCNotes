#include <stdio.h>

/*
 作用域：从定义变量开始，到函数结束
 */

int test()
{
    int score = 200;
    return 0;
}


int main()
{
    int score;
    
    test();
    
    score = 100;
    
    
    printf("score=%d\n", score);
    
    /*
     错误写法
    int b;
    b = a;
    */
    
    int c = 20;
    
    int a = 10;
    
    return 0; // 退出函数
}