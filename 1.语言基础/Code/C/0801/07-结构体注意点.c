
#include <stdio.h>

/*
 1.定义结构体变量的3种方式
     先定义类型，再定义变量
     struct Student
     {
        int age;
     };
     struct Student stu;
 
     定义类型的同时定义变量
     struct Student
     {
        int age;
     } stu;
     struct Student stu2;
 
     定义类型的同时定义变量
     struct
     {
        int age;
     } stu;
 
 2.结构体类型的作用域
    定义在函数外面：全局有效（从定义类型开始，到文件结尾）
    定义在函数（代码块）内部：局部有效（从定义类型开始，到代码块结束）
 */

struct Date
{
    int year;
    int month;
    int day;
};

int a;

void test2()
{
    struct Date
    {
        int year;
    };
    struct Date d1 = {2011};
    
    
    struct Person
    {
        int age;
    };
    struct Person p;
    
    a  = 10;
}

int main()
{
    struct Date d1 = {2009, 8, 9};
    
    test2();
    
    return 0;
}

// 定义结构体变量
void test()
{
    // 定义结构体变量的第3种方式
    struct {
        int age;
        char *name;
    } stu;
    
    struct {
        int age;
        char *name;
    } stu2;
    
    // 定义变量的第2种方式：定义类型的同时定义变量
    /*
         struct Student
         {
         int age;
         double height;
         char *name;
         } stu;
         
         struct Student stu2;
     */
    
    // 定义变量的第1种方式：
    /*
         // 1.类型
         struct Student
         {
         int age;
         double height;
         char *name;
         };
         // 2.变量
         struct Student stu = {20, 1.78, "jack"};
     */
    
/* 结构体类型不能重复定义
     struct Student
     {
     int age;
     };
     
     struct Student
     {
     double height;
     };
     
     struct Student stu;
 */
    
/* 结构体类型重复定义
     struct Student
     {
     int age;
     double height;
     char *name;
     } stu;
     
     struct Student
     {
     int age;
     double height;
     char *name;
     } stu2;
 */
}