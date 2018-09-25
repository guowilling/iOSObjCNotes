/*
 作者：MJ
 描述：
 时间：
 文件名：Car.m
 */

#import "Car.h"

@implementation Car

- (void)setSpeed:(int)speed
{
    _speed = speed;
}
- (int)speed
{
    return _speed;
}

- (void)dealloc
{
    
    // _speed == self->_speed (直接访问成员变量)
    // self.speed == [self speed] : get方法

    NSLog(@"速度为%d的Car对象被回收了", _speed);
    
    [super dealloc];
}

@end
