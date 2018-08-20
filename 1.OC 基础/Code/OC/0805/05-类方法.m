
#import <Foundation/Foundation.h>
/*
 对象方法
 1. - 减号开头
 2.只能由对象调用
 3.对象方法中能访问当前对象的成员变量
 
 类方法
 1.+ 加号开头
 2.只能由类调用
 3.类方法中不能访问成员变量
 
 允许类方法和对象方法同名
 */


@interface Person : NSObject
{
    int age;
}

+ (void)printClassName;

- (void)test;
+ (void)test;

@end

@implementation Person

+ (void)printClassName
{
    
}

- (void)test
{
    NSLog(@"%d", age);
}

+ (void)test
{
    NSLog(@"不能访问age");
}

@end

int main()
{
    [Person printClassName];
    
    [Person test];
    
    Person *p = [Person new];
    [p test];
    
    return 0;
}