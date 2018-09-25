
#import <Foundation/Foundation.h>

@interface Student : NSObject
{
    // 成员变量尽量不要用@public
    // @public
    int age;
}

// set方法
- (void)setAge:(int)newAge;

// get方法
- (int)age;

- (void)study;

@end


@implementation Student

- (void)setAge:(int)newAge
{
    if (newAge <= 0)
    {
        newAge = 1;
    }
    
    age = newAge;
}

- (int)age
{
    return age;
}

- (void)study
{
    NSLog(@"%d岁的学生在学习", age);
}

@end

int main()
{
    Student *stu = [Student new];
    //stu->age = -10;
    //stu->age = 10;
    
    [stu setAge:10];
    
    
    NSLog(@"学生的年龄是%d岁", [stu age]);
    
    // [stu study];
    
    return 0;
}