#include <stdio.h>

int main()
{
    // 都是正确写法
    //int ages[5] = {10 , 11, 12, 67, 56};
    //int ages[5] = {10, 11};
    //int ages[5] = {[3] = 10, [4] = 11};
    //int ages[] = {10, 11, 14};
    
    // 错误写法
    // int ages[];
    
    // 错误写法
    /* 只能定义数组的同时初始化
    int ages[5];
    ages = {10, 11, 12, 14};
     */
    
    // 正确写法
    // int ages['A'-50] = {10, 11, 12, 14, 16};
    // int size = sizeof(ages);
    // printf("%d\n", size);
    
    // 正确写法
    /*
    int count = 5;
    int ages[count];
    ages[0] = 10;
    ages[1] = 11;
    ages[2] = 18;
     */
    
    //printf();
    // 错误写法
    // 如果想定义数组的同时初始化，数组元素个数必须是常量，或者不写
    // int ages[count] = {10, 11, 12};
    
    
    int ages[] = {10, 11, 12, 78};
    
    // 数组元素的个数
    int count = sizeof(ages)/sizeof(int);
    
    for (int i = 0; i<count; i++)
    {
        printf("ages[%d]=%d\n", i, ages[i]);
    }
    
    return 0;
}

// 基本使用
void arrayUse()
{
    // 定义格式： 类型 数组名[元素个数];
    int ages[5] = {19, 29, 28, 27, 26};
    
    ages[1] = 29;
    
    /*
     ages[0] = 19;
     ages[1] = 19;
     ages[2] = 28;
     ages[3] = 27;
     ages[4] = 26;
     */
    
    // 遍历
    for (int i = 0; i<5; i++)
    {
        printf("ages[%d]=%d\n", i, ages[i]);
    }
}