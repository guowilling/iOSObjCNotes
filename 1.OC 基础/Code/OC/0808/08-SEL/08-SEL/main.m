//
//  main.m
//  08-SEL
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/*
 SEL是将方法包装成一个SEL类型的数据, 调用方法其实是找方法的地址, 找到地址就可以调用方法
 
 消息就是SEL
 */

#import <Foundation/Foundation.h>
#import "Person.h"

int main()
{
    Person *p = [[Person alloc] init];
    
    NSString *name = @"test2";
    
    SEL s = NSSelectorFromString(name);
    
    [p performSelector:s];
    
    
    [p performSelector:@selector(test2)];
    
    
    
    [p performSelector:@selector(test3:) withObject:@"gwl"];
//    SEL s = @selector(test3:);
//    [p performSelector:s withObject:@"gwl"];
    
    // [p test2];
    // 过程:
    // 1.把test2方法名包装成SEL类型的数据
    // 2.根据SEL类型的数据找到方法的地址
    // 3.根据地址调用方法
    return 0;
}

