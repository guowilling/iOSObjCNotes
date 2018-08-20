/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person


+ (id)person
{
    return [[[self alloc] init] autorelease];
}


+ (id)personWithAge:(int)age
{
    Person *p = [self person];
    p.age = age;
    return p;
}

- (void)dealloc
{
    NSLog(@"%d岁的人被销毁了", _age);
    
    [super dealloc];
}
@end
