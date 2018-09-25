#include <stdio.h>

/*
 1.变量的作用域
 从定义变量开始，到所在的代码块结束
 
 2.代码块的作用
 及时回收不再使用的变量，提升性能
 */

int test()
{
    int v = 10;
    return 0;
}

int main()
{
    {
        double height = 1.55;
        
        height = height + 1;
        
        printf("height=%f\n", height);
    }
    
   /*
    {
        int a = 10;
    }
    printf("a=%d\n", a);
    */
    
    
    int score = 100;
    
    {
        int score = 200;
        
        {
            int score;
            score = 50;
        }
        printf("score=%d\n", score);
    }
    printf("score=%d\n", score);
    
    return 0;
}