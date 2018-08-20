/*
 作者：MJ
 描述：
 时间：
 文件名：Status.m
 */

#import "Status.h"

@implementation Status
- (void)dealloc
{
    [_text release];
    [_user release];
    [_retweetStatus release];
    [_icon release];
    [super dealloc];
}
@end
