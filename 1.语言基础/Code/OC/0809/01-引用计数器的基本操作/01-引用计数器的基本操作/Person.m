/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person

- (void)dealloc
{
    NSLog(@"释放Person对象");
    
    [super dealloc];
}

@end
