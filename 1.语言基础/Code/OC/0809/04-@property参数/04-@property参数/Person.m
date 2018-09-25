/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person

//- (void)setBook:(Book *)book
//{
//    if (_book != book)
//    {
//        [_book release];
//        
//        _book = [book retain];
//    }
//}

- (void)dealloc
{
    [_book release];
    [_name release];
    [super dealloc];
}

@end
