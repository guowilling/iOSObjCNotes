/*
 作者：MJ
 描述：
 时间：
 文件名：Person.h
 */
#import <Foundation/Foundation.h>
#import "Car.h"

@interface Person : NSObject
{
    Car *_car;
    int _age;
}

- (void)setAge:(int)age;
- (int)age;

- (void)setCar:(Car *)car;
- (Car *)car;

@end
