
/*
 1.作用：给已经存在的类型起一个新名称
 
 2.使用场合：
    基本数据类型
    指针
    结构体
    枚举
    指向函数的指针
 */

#include <stdio.h>

typedef int MyInt;
typedef MyInt MyInt2;

typedef char * String;

/*
struct Student
{
    int age;
};
typedef struct Student MyStu;
 */

/*
typedef  struct Student
{
    int age;
} MyStu;
 */
typedef struct
{
    int age;
} MyStu;

/*
enum Sex {
    Man,
    Woman
 };
typedef enum Sex MySex;
 */
typedef enum {
    Man,
    Woman
} MySex;


typedef int (*MyPoint)(int, int);

int minus(int a, int b)
{
    return a - b;
}

int sum(int a, int b)
{
    return a + b;
}
/*
struct Person
{
    int age;
};

typedef struct Person * PersonPoint;
 */
typedef struct Person
{
    int age;
} * PersonPoint;


int main()
{
    // 定义结构体变量
    struct Person p = {20};
    
    PersonPoint p2 = &p;
    // struct Person *p2 = &p;
    
    // MyPoint p = sum;
    // MyPoint p2 = minus;
    
    // int (*p)(int, int) = sum;
    // int (*p2)(int, int) = minus;
    
    // p(10, 11);
    
    // MySex s = Man;
    // enum Sex s = Man;
    // enum Sex s2 = Woman;
    
    // struct Student stu3;
    // MyStu stu = {20};
    // MyStu stu2= {21};
    
    return 0;
}

void test2()
{
    String name = "jack";
    
    printf("%s\n", name);
}

void test()
{
    int a;
    MyInt i = 10;
    MyInt2 c = 20;
    
    MyInt b1, b2;

    printf("c is %d\n", c);
}