
#import <Foundation/Foundation.h>

@interface Person : NSObject
@end

@implementation Person
@end

@interface Car : NSObject
{
    // 成员变量\实例变量
    @public
    int wheels;
}

- (void)run;
- (void)fly;
@end

int main()
{
    Car *c = [Car new];
    c->wheels = 4;
    run();
    
    [c run];
    return 0;
}

@implementation Car

- (void) fly
{
    
}


void test()
{
    NSLog(@"调用了test函数");
}

- (void)run
{
    test();
    NSLog(@"%d个轮子的车跑起来了", wheels);
}
@end
