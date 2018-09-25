//
//  Person.m
//  06-@property和@synthesize
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

// @synthesize自动生成属性age的setter和getter实现, 并且访问成员变量_age
@synthesize age = _age;

@synthesize height = _height;

@synthesize weight = _weight, name = _name;

@end
