#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _age;
}

- (void)setAge:(int)age;
- (int)age;

- (void)test;

@end

@implementation Person
- (void)setAge:(int)age
{
    // _age = age;
    self->_age = age;
}
- (int)age
{
    return self->_age;
}

- (void)test
{
    int _age = 20;
    NSLog(@"Person的年龄是%d岁", self->_age);
}

@end

int main()
{
    Person *p = [Person new];
    
    [p setAge:10];
    
    [p test];
    
    return 0;
}