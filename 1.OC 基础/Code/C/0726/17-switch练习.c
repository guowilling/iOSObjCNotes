 /*
 输入一个整数score代表分数，根据分数输出等级（A-E）(用两种方式)
 A：90~100 score/10 == 9、10
 B：80~89  score/10 == 8
 C：70~79  score/10 == 7
 D：60~69  score/10 == 6
 E：0~60   
 */

#include <stdio.h>

int main()
{
    int score = 100;
    
    switch (score/10) {
        case 10:    // 100
        case 9:     // 90+
            printf("A\n");
            break;
        case 8:     // 80+
            printf("B\n");
            break;
        case 7:     // 70+
            printf("C\n");
            break;
        case 6:     // 60+
            printf("D\n");
            break;
        default:
            printf("E\n");
            break;
    }
    

    /*
     if和switch
     if语句能完成的功能，switch并不一定能完成
     int a = 10;
     if (a>100)
     {
     
     }
     */
    
    return 0;
}