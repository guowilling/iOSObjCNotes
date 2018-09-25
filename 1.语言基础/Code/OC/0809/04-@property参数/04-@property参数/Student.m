/*
 作者：MJ
 描述：
 时间：
 文件名：Student.m
 */

#import "Student.h"

@implementation Student


- (void)dealloc
{
    [_book release];
    [_name release];
    
    [super dealloc];
}

@end
