#include <stdio.h>

/*
 int ages[5];
 int *p;
 p = ages;
 1.数组访问方式
        数组名[下标]      ages[i]
        指针变量名[下标]   p[i]
                        *(p + i)
 
 2.指针变量+1，地址值加多少，取决于指针指向的类型
  int *     4
  char *    1
  double *  8
 */

void change(int array[]);

int main()
{
    int ages[5] = {10, 11, 19, 78, 67};
    
    change(ages);
    
    return 0;
}

// 使用指针接收数组，array指向数组的首元素
void change(int *array)
{
    printf("%d\n", array[2]);
    // printf("%d\n", *(array+2));
}

/*
void change(int array[])
{
    int s = sizeof(array);
    printf("%d\n", s);
}*/

void test()
{
    double d = 10.8;
    double *dp;
    dp = &d;
    
    printf("dp = %p\n", dp);
    printf("dp + 1 = %p\n", dp + 1);
    
    int ages[5] = {10, 9, 8, 67, 56};
    int *p;
    // p指向数组的首元素
    p = &ages[0];
    // 数组名就是数组的地址，也是数组首元素的地址
    // p = ages;
    
    /*
     p     ---> &ages[0]
     p + 1 ---> &ages[1]
     p + 2 ---> &ages[2]
     p + i ---> &ages[i]
     */
    
    // printf("%d\n",  *(p+2));
    
    printf("%d\n",  p[2]);
    
    /*
     for (int i = 0; i<5; i++) {
        printf("ages[%d] = %d\n", i, *(p+i));
     }
     */
    
    //    printf("%p\n", p);
    //    printf("%p\n", p + 1);
    //    printf("%p\n", p + 2);
}



