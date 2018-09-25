#include <stdio.h>

/*
 1.变量的定义
 变量类型 变量名;
 int score;
 
 2.变量的赋值
 score = 100;
 score = a;
 score = b = 100;
 
 3.变量的输出
 int a = 200;
 printf("%i", a);
 
 常用格式符：
 1> %d\%i 整数（int）
 2> %f    小数（float、double）
 3> %c    字符（char）
 */

int main()
{
    /*
    int score;
    // 赋值操作（初始化）
    score = 1000;
     
    score = 10000;
    
    char c;
    
    c = 'A';
    
    int a = 20;
    
    //int d,e,f;
    
    int b;
    
    b = a = 40;
    
    b = 30;
     */
    
    // 变量：不确定的数据，定义变量来保存
    int score = 205;
    
    int time = 75;
    
    int bestScore = 3161;
    // %d\%i格式符（占位符），输出整数
    printf("分数是%d\n", score);
    
    
    float height = 1.78f;
    // %f输出小数，默认6位小数
    printf("身高是%.2f\n", height);
    
    char scoreGrade = 'D';
    printf("积分等级是%c\n", scoreGrade);
    
    printf("分数是%d，身高是%f，等级是%c\n", score, height, 'C');
    
    return 0;
}