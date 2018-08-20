//
//  Person.m
//  05-成员变量的作用域
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person
{
    int _aaa; // 默认 @private 
    
    @public
    int _bbb;
	
    // @implementation中不能定义和@interface中同名的成员变量
    // int _no;
}

- (void)test
{
    _age = 19;
    
    _height = 20;
    
    _weight = 50;
    
    _aaa = 10;
}

- (void)setHeight:(int)height
{
    _height = height;
}

- (int)height
{
    return _height;
}

@end
