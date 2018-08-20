
/*
 输入一个整数score代表分数，根据分数输出等级（A-E）(用两种方式)
 A：90~100
 B：80~89
 C：70~79
 D：60~69
 E：0~60
*/

#include <stdio.h>

int main()
{
    // 1.提示输入
    printf("请输入分数值:\n");
    // 2.接收输入
    int score;
    scanf("%d", &score);
    
    // 3.判断等级 （性能最高）
    if (score>=90 && score<=100) { // [90, 100]
        printf("A\n");
    } else if (score>=80) { // [80, 89]
        printf("B\n");
    } else if (score>=70) { // [70, 79]
        printf("C\n");
    } else if (score>=60) { // [60, 69]
        printf("D\n");
    } else { // (-∞, 59]
        printf("E\n");
    }
    
    /* 性能中等
    if (score>=90 && score<=100) { // [90, 100]
        printf("A\n");
    } else if (score>=80 && score<=89) { // [80, 89]
        printf("B\n");
    } else if (score>=70 && score<=79) { // [70, 79]
        printf("C\n");
    } else if (score>=60 && score<=69) { // [60, 69]
        printf("D\n");
    } else { // (-∞, 59]
        printf("E\n");
    }*/
    
    /* 性能最差
    if (score>=90 && score<=100) { // [90, 100]
        printf("A\n");
    }
     
    if (score>=80 && score<=89) { // [80, 89]
        printf("B\n");
    }
    
    if (score>=70 && score<=79) { // [70, 79]
        printf("C\n");
    }
    
    if (score>=60 && score<=69) { // [60, 69]
        printf("D\n");
    }
    
    if (score<=59) { // (-∞, 59]
        printf("E\n");
    }*/
    return 0;
}