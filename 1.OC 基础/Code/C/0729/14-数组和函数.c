
#include <stdio.h>

// 数组作为函数参数，传递的是数组地址，形参数组元素修改，即实参数组修改

void change(int array[])
{
    //printf("array==%p\n", array);
    
    array[0] = 100;
}

void change2(int n)
{
    n = 100;
}

int main()
{
    int ages[6] = {10, 11, 10, 11, 10, 11};
    
    //printf("ages==%p\n", ages);
    
    change(ages);
    
    //change2(ages[0]);
    
    printf("%d\n", ages[0]);
    return 0;
}

