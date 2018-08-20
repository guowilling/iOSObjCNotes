/*
 作者：MJ
 描述：
 时间：
 文件名：User.m
 */

#import "User.h"

@implementation User
- (void)dealloc
{
    [_name release];
    [_account release];
    [_icon release];
    [_password release];
    [_phone release];
    
    [super dealloc];
}
@end
