//
//  Person.m
//  第一个OC项目
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)test
{
    NSLog(@"test");
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
