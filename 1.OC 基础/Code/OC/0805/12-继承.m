
/*
 重写：子类重新实现父类中的某个方法, 父类的该方法被屏蔽
 调用某个方法时, 先去当前类中找, 如果找不到再去父类中找, 一直到NSObject
 */

#import <Foundation/Foundation.h>
// Person
@interface Person : NSObject
{
    int _age;
}

- (void)setAge:(int)age;
- (int)age;

- (void)run;

+ (void)test;

@end

@implementation Person

+ (void)test
{
    NSLog(@"Person+test");
}

- (void)run
{
    NSLog(@"person---跑");
}

- (void)setAge:(int)age
{
    _age = age;
}
- (int)age
{
    return _age;
}
@end

// Student
@interface Student : Person
{
    int _no;
    
    // duplicate member
    // 不允许子类和父类有相同名称的成员变量
    // int _age;
}

+ (void)test2;

@end

@implementation Student
- (void)run
{
    NSLog(@"student---跑");
}

+ (void)test2
{
    [self test];
}
@end


int main()
{
    [Student test2];
    
//    Student *s = [Student new];
//    
//    [s run];
    
    return 0;
}