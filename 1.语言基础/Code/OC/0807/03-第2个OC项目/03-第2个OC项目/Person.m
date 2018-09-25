//
//  Person.m
//  03-第2个OC项目
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark - 年龄的seter和getter实现
- (void)setAge:(int)age
{
    _age = age;
}
- (int)age
{
    return _age;
}


#pragma mark - 姓名的seter和getter实现
- (void)setName:(NSString *)name
{
    _name = name;
}
- (NSString *)name
{
    return _name;
}

#pragma mark - 其他方法
- (void)test1
{

}
- (void)test2
{

}
@end