/**
  对象方法
  1.对象方法以 - 开头
  2.对象方法的声明必须写在@interface和@end之间
  3.对象方法的实现必须写在@implementation和@end之间
  4.对象方法只能由对象来调用
  5.对象方法归类\对象所有
 
  函数
  1.函数能写在文件中的任意位置(@interface和@end之间除外)，函数归文件所有
  2.函数调用不依赖于对象
  3.函数内部不能直接通过成员变量名访问某个对象的成员变量
 */

#import <Foundation/Foundation.h>

@interface Car : NSObject
{// 成员变量
    @public
    int wheels;
    int speed;
}

- (void)run;
@end

@implementation Car
- (void)run
{
    NSLog(@"%d个轮子, 速度为%dkm/h的车子跑起来了", wheels, speed);
}
@end


void test1(int w, int s)
{
    w = 20;
    s = 200;
}

void test2(Car *newC)
{
    newC->wheels = 5;
}

void test3(Car *newC)
{
    Car *c2 = [Car new];
    c2->wheels = 5;
    c2->speed = 300;
    
    newC = c2;
    newC->wheels = 6;
}

int main()
{
    Car *c = [Car new];
    c->wheels = 4;
    c->speed = 250;
    
    //test1(c->wheels, c->speed);
    //test2(c);
    test3(c);
    
    [c run];
    
    return 0;
}
