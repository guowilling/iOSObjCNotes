

/*
 数组：只能由相同类型的数据构成
 
 结构体：可以由不同类型的数据构成
 */
#include <stdio.h>

int main()
{
    //int ages[3] = {[2] = 10, 11, 27};
    
    //int ages[3] = {10, 11, 29};
    
    // 定义结构体类型
    struct Person
    {
        int age;
        double height;
        char *name;
    };
    
    // 根据结构体类型，定义结构体变量
    struct Person p = {20, 1.55, "jack"};

    p.age = 30;
    
    p.name = "rose";
    
    printf("age=%d, name=%s, height=%f\n", p.age, p.name, p.height);
    
    /* 错误写法
    struct Person p2;
    p2 = {30, 1.67, "jake"};
     */
    
    struct Person p2 = {.height = 1.78, .name="jim", .age=30};
    
    return 0;
}