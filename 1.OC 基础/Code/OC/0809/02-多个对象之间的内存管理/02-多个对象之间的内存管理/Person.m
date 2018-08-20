/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person
- (void)setBook:(Book *)book
{
    _book = [book retain];
}

- (Book *)book
{
    return _book;
}

- (void)dealloc
{
    [_book release];
    NSLog(@"Person对象被回收");
    [super dealloc];
}
@end
