#include <stdio.h>

/*
 1.定义指向结构体的指针
    struct Student *p;
 
 2.利用指针访问结构体的成员
    (*p).成员名称
    p->成员名称
 */

int main()
{
    struct Student
    {
        int no;
        int age;
    };
    
    // 结构体变量
    struct Student stu = {1, 20};
    
    // 指针变量p指向struct Student类型的数据
    struct Student *p;
    
    p = &stu;
    
    p->age = 30;
    
    // 第一种方式
    printf("age=%d, no=%d\n", stu.age, stu.no);
    
    // 第二种方式
    printf("age=%d, no=%d\n", (*p).age, (*p).no);
    
    // 第三种方式
    printf("age=%d, no=%d\n", p->age, p->no);
    
    return 0;
}