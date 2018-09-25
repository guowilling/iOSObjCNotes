/*
 作者：MJ
 描述：
 时间：
 文件名：Card.m
 */

#import "Card.h"
#import "Person.h"

@implementation Card


- (void)dealloc
{
    NSLog(@"Car被销毁了");
    
    // [_person release];
    
    [super dealloc];
}

@end
