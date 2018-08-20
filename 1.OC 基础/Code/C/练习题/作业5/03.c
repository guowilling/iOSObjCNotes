/*
 输入5个学生的成绩(保证分数在0~100之间)，算出平均分、最高分、最低分，然后输出
 */
#include <stdio.h>

#define kStudentCount 5

int main()
{
    int scores[kStudentCount] = {-1, -1, -1, -1, -1};

    int sum = 0, max = 0, min = 100;
    
    for (int i = 0; i<kStudentCount; i++)
    {
        while (scores[i]<0 || scores[i]>100)
        {
 
            printf("请输入第%d个学生的成绩（0~100）：\n", i + 1);
            scanf("%d", &scores[i]);
        }
        
        sum += scores[i];
        
        if (scores[i] > max)
        {
            max = scores[i];
        }
        
        if (scores[i] < min)
        {
            min = scores[i];
        }
    }
    
    printf("平均分是%d，最高分是%d，最低分是%d\n", sum/kCount, max, min);
}