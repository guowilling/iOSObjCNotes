
#include <stdio.h>
int main()
{
    return 0;
}

// 补齐算法
void test1()
{
    struct Student
    {
        int age; // 4个字节
        
        char a;
        
        // char *name; // 8个字节
    };
    
    struct Student stu;
    // stu.age = 20;
    // stu.name = "jack";
    // 补齐算法：结构体的存储空间必须是最大成员字节数的倍数
    
    int s = sizeof(stu);
    
    printf("%d\n", s);
}

// 结构体内存细节
void test()
{
    // 定义结构体类型(不会分配存储空间)
    struct Date
    {
        int year;
        int month;
        int day;
    };
    
    // 定义结构体变量（分配存储空间）
    struct Date d1 = {2011, 4, 10};
    
    struct Date d2 = {2012, 8, 9};
    
    // d1所有成员的值赋给d2所有成员
    d2 = d1;
    d2.year = 2010;
    
    printf("%d - %d - %d\n", d1.year, d1.month, d1.day);
    
    printf("%d - %d - %d\n", d2.year, d2.month, d2.day);
    
    /*
     printf("%p - %p - %p\n", &d1.year, &d1.month, &d1.day);
     
     int s = sizeof(d1);
     
     printf("%d\n", s);
     */
}