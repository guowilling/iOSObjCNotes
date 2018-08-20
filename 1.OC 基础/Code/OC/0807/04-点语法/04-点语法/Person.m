//
//  Person.m
//  04-点语法
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)setAge:(int)age
{
    NSLog(@"setAge:");
    
    _age = age;
    
    // 会引发死循环
    // self.age = age; // [self setAge:age];
}

- (int)age
{
    NSLog(@"age");
    
    return _age;
    
    // 会引发死循环
    // return self.age; // [self age];
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (NSString *)name
{
    return _name;
}

@end
