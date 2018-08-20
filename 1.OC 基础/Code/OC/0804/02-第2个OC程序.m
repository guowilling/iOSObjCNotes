/*
 #import的用途：
 1.和#include一样拷贝文件的内容
 2.自动防止重复拷贝文件的内容
 
 #import <Foundation/NSObjCRuntime.h>: NSObjCRuntime.h中有NSLog函数的声明
 
 Foundation框架头文件的路径:Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.0.sdk/System/Library/Frameworks/Foundation.framework
 
 主头文件
 1.主头文件: 名字一般跟框架名称一样, 包含了框架中所有其他头文件
 2.Foundation框架的主头文件名称就是Foundation.h
 3.只需要包含Foundation框架主头文件, 就可以使用Foundation框架的所有东西
 
 运行过程
 1.编写OC源文件：.m 或 .c
 2.编译：cc -c xxx.m xxx.c
 3.链接：cc xxx.o xxx.o -framework Foundation
 4.运行：./a.out
 */

#import <Foundation/Foundation.h>

int main()
{
    NSLog(@"第2个OC程序!!!");
    
    return 0;
}