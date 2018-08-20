//
//  Car.m
//  06-@property和@synthesize
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Car.h"

@implementation Car

// 自动生成属性的setter和getter实现, 访问成员变量_speed如果没有则自动生成
@synthesize speed = _speed;

@synthesize wheels = _wheels;

- (void)test
{
    NSLog(@"速度=%d", _speed);
}

@end
