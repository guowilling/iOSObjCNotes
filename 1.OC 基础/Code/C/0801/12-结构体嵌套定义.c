
#include <stdio.h>

int main()
{
    struct Date
    {
        int year;
        int month;
        int day;
    };
    
    

    struct Student
    {
        int no;
        
        struct Date birthday;
        
        struct Date ruxueDate;
        
        // struct Student stu; // 错误写法
    };
    
    
    struct Student stu = {1, {2000, 9, 10}, {2012, 9, 10}};
    
    printf("year=%d,month=%d,day=%d\n", stu.birthday.year, stu.birthday.month, stu.birthday.day);
    
    return 0;
}