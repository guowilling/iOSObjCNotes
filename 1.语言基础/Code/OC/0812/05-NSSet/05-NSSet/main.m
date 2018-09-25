//
//  main.m
//  05-NSSet
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 NSSet和NSArray对比
 相同点
 * 都是集合
 * 只能存放OC对象类型, 不能存放非OC对象类型(int, char, float, 结构体, 枚举等)
 
 不同点
 * NSArray里面的元素有顺序, NSSet里面的元素没有顺序
 */

#import <Foundation/Foundation.h>

int main()
{
    NSMutableSet *s = [NSMutableSet set];
    
    [s addObject:@"jack"];
    [s removeObject:@"jack"];
    
    NSLog(@"%@", s);
    return 0;
}

void test()
{
    // 空set
    NSSet *s1 = [NSSet set];
    
    NSSet *s2 = [NSSet setWithObjects:@"jack1", @"rose", @"jack2", @"rose2",nil];
    
    NSString *str =  [s2 anyObject];
    
    NSLog(@"%@", str);
    
    NSLog(@"%ld", s2.count);
}