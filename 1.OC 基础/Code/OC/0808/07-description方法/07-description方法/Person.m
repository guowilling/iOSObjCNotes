/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person

// 决定实例对象（对象）的输出结果
- (NSString *)description
{
    return [NSString stringWithFormat:@"age=%d, name=%@", _age, _name];
}

// 决定类对象（类）的输出结果
+ (NSString *)description
{
    return @"Abc";
}

@end