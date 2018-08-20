//
//  Person.m
//  03-自定义构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init
{
    if ( self = [super init] )
    {
        _name = @"Jack";
    }
    return self;
}

- (id)initWithName:(NSString *)name
{

    if ( self = [super init] )
    {
        _name = name;
    }
    
    return self;
}

- (id)initWithAge:(int)age
{
    if ( self = [super init] )
    {
        _age = age;
    }
    return self;
}

- (id)initWithName:(NSString *)name andAge:(int)age
{
    if ( self = [super init] )
    {
        _name = name;
        _age = age;
    }
    return self;
}

@end
