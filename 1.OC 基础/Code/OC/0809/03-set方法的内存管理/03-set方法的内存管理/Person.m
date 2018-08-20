/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person
- (void)setCar:(Car *)car
{
    if (car != _car)
    {
        // 对正在使用的车（旧车）做一次release
        [_car release];
        
        // 对新车做一次retain
        _car = [car retain];
    }
}
- (Car *)car
{
    return _car;
}

- (void)setAge:(int)age
{
    _age = age;
}
- (int)age
{
    return _age;
}

- (void)dealloc
{
    // 当人不在了, 代表车不用了, 对车做一次release
    [_car release];
    
    NSLog(@"%d岁的Person对象被回收了", _age);
    
    [super dealloc];
}

@end
