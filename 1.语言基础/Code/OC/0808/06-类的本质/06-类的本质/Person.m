/*
 作者：MJ
 描述：
 时间：
 文件名：Person.m
 */

#import "Person.h"

@implementation Person

+ (void)test
{
    NSLog(@"调用了test方法");
}


// 程序启动会加载项目中所有的类, 会调用+load方法, 一个类只调用一次
+ (void)load
{
    NSLog(@"Person---load");
}

// 第一次使用类的时候, 会调用+initialize方法, 一个类只调用一次
+ (void)initialize
{
    NSLog(@"Person-initialize");
}

@end
