/*
 类名：Car
 属性：轮胎个数、时速
 行为：跑
 */

#import <Foundation/Foundation.h>

// 1.类的声明
@interface Car : NSObject
{
    @public
    int wheels;
    int speed;
}

- (void)run;

@end

// 2.类的实现
@implementation Car
- (void)run
{
    NSLog(@"车子跑起来了");
}

@end

int main()
{
    
    Car *p1 = [Car new];
    Car *p2 = [Car new];
    p2->wheels = 5;
    p2->speed = 300;
    [p2 run];
    
    p1->wheels = 4;
    p1->speed = 250;
    // 给p1指向的对象发送一条run消息
    [p1 run];
    
    NSLog(@"p1车子有%d个轮子, p2车子时速为: %dkm/h", p1->wheels, p2->speed);
    
    return 0;
}