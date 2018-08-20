/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"
#import "Card.h"

@implementation Person

- (void)dealloc
{
    NSLog(@"Person被销毁了");
    
    [_card release];
    
    [super dealloc];
}

@end
