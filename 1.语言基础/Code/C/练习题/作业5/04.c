/*
 定义函数：颠倒数组元素，比如1,3,4,2，逆序：2，4，3，1
 */

#include <stdio.h>

void reverse(int array[], int len);

int main()
{
    int ages[4] = {1, 3, 4, 2};
    
    reverse(ages, 4);
    
    for (int i = 0; i<4; i++)
    {
        printf("%d\n", ages[i]);
    }
    
    return 0;
}

void reverse(int array[], int len)
{
    // array[0] array[1] array[2] array[3] array[4] array[5]
    // 交换array[0]和array[5]的值
    // 交换array[1]和array[4]的值
    // 交换array[2]和array[3]的值
    
    // 左边元素的下标(默认是最左边)
    int left = 0;
    // 右边元素的下标(默认是最右边)
    int right = len - 1;
    
    // 左边元素的下标 < 右边元素的下标
    while (left < right)
    {
        // 交换两个元素的值
        int temp = array[left];
        array[left] = array[right];
        array[right] = temp;
        
        left++;
        right--;
    }
}