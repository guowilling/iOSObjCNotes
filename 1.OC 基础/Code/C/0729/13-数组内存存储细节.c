#include <stdio.h>

/*
 输入5个学生的成绩，算出平均分并输出
 */

int main()
{
    int scores[5];

    int sum = 0;
    for (int i = 0; i<5; i++) {
        // 提示输入某个学生的成绩
        printf("请输入第%d个学生的成绩:\n", i + 1);
        // 存储当前学生的成绩
        scanf("%d", &scores[i]);
        // 累加
        sum += scores[i];
    }
    
    // 计算平均分并输出
    printf("平均分是%f\n", sum/5.0);
    return 0;
}

void test2()
{
    // 1.定义一个数组存储成绩
    int scores[5];
    
    // 2.提示输入成绩
    printf("请输入第1个学生的成绩:\n");
    scanf("%d", &scores[0]);
    
    printf("请输入第2个学生的成绩:\n");
    scanf("%d", &scores[1]);
    
    printf("请输入第3个学生的成绩:\n");
    scanf("%d", &scores[2]);
    
    printf("请输入第4个学生的成绩:\n");
    scanf("%d", &scores[3]);
    
    printf("请输入第5个学生的成绩:\n");
    scanf("%d", &scores[4]);
    
    // 计算平均分并输出
    int sum = 0;
    for (int i = 0 ; i<5; i++) {
        sum += scores[i];
    }
    printf("平均分是%f\n", sum/5.0);
}

void test1()
{
    /*
     char cs[5]= {'a', 'A', 'D', 'e', 'f'};
     
     printf("%p\n", cs);
     
     for (int i = 0; i<5; i++) {
        printf("cs[%d]的地址是:%p\n", i, &cs[i]);
     }
     */
    
    int ages[3]= {10 , 19, 18};
    
    printf("%p\n", ages);
    
    for (int i = 0; i<3; i++) {
        printf("ages[%d]的地址是:%p\n", i, &ages[i]);
    }
}