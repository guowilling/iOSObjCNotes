
#import <Foundation/Foundation.h>

// 类的声明
@interface Person : NSObject
// 成员变量
{
    @public
    int age;
    double height;
}

// 方法声明
- (void)walk;
- (void)eat;

@end


// 类的实现
@implementation Person

// 实现@interface中声明的方法
- (void)walk
{
    NSLog(@"%d岁的人在走路", age);
}

- (void)eat
{
    NSLog(@"%d岁的人在吃东西", age);
}

@end

int main()
{
    Person *p = [Person new];
    p->age = 20;
    p->height = 170;
    [p eat];
    [p walk];
    
    Person *p2 = [Person new];
    p2->age = 25;
    p2->height = 175;
    [p2 eat];
    [p2 walk];
    
    return 0;
}