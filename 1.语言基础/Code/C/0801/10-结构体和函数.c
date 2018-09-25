#include <stdio.h>
struct Student
{
    int age;
    int no;
};

// 结构体作为函数参数，只是将实参结构体所有成员的值赋值给了形参结构体所有成员
// 不会影响外面的实参结构体
void test1(struct Student s)
{
    s.age = 30;
    s.no = 2;
}

// 会影响外面的实参结构体
void test2(struct Student *p)
{
    p->age = 15;
    p->no = 2;

}

void test3(struct Student *p)
{
    struct Student stu2 = {15, 2};
    p = &stu2;
    p->age = 16;
    p->no = 3;
}

int main()
{
    struct Student stu = {28, 1};
    
    // test1(stu);
    // test2(&stu);
    test3(&stu);
    
    printf("age=%d, no=%d\n", stu.age, stu.no);
    
    return 0;
}