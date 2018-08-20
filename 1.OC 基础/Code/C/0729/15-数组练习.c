/*
 定义函数找出数组元素中的最大值
 */

#include <stdio.h>

int maxOfArray(int array[], int length)
{
    // int size = sizeof(array);
    // printf("array=%d\n", size);
    
    // sizeof(array);
    
    // 1.定义变量存储最大值(默认首元素)
    int max = array[0];
    
    // 2.遍历所有元素
    for (int i = 1; i<length; i++)
    {
        if (array[i] > max)
        {
            max = array[i];
        }
    }
    
    return max;
}

int main()
{
    int ages[] = {11, 90, 67, 150, 78, 60, 70, 89, 100};
    
    int ages2[] = {11, 90, 67, 150, 78, 60, 70, 89, 100};

    int max = maxOfArray(ages, sizeof(ages)/sizeof(int));
    
    printf("%d\n", max);
    return 0;
}