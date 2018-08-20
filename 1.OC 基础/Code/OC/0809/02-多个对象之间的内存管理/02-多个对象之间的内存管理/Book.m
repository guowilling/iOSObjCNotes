/*
 作者：MJ
 描述：
 时间：
 文件名：Book.m
 */

#import "Book.h"


@implementation Book

- (void)setPrice:(int)price
{
    _price = price;
}

- (int)price
{
    return _price;
}
- (void)dealloc
{
    NSLog(@"Book对象被回收");
    [super dealloc];
}
@end
