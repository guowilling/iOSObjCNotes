
/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person
+ (void)test1
{
    NSLog(@"test-----");
}

- (void)test2
{
    // _cmd == @selector(test2)
    NSString *str = NSStringFromSelector(_cmd);
    
    // 会引发死循环
    // [self performSelector:_cmd];
    
    NSLog(@"调用了test2方法-----%@", str);
}

- (void)test3:(NSString *)abc
{
    NSLog(@"test3-----%@", abc);
}
@end
