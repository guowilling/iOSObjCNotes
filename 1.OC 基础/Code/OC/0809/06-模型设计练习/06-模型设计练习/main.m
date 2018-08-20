//
//  main.m
//  06-模型设计练习
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Status.h"

int main()
{
    // 新建2个用户
    User *u1 = [[User alloc] init];
    u1.name = @"2B";
    
    User *u2 = [[User alloc] init];
    u2.name = @"傻B";
    
    // 新建2条微博
    Status *s1 = [[Status alloc] init];
    s1.text = @"今天天气真好!";
	// 设置是谁发的
    s1.user = u1;
    
    Status *s2 = [[Status alloc] init];
    s2.text = @"今天天气真的很好!";
    s2.retweetStatus = s1;
    s2.user = u2;
    
    [u2 release];
    [u1 release];
    [s2 release];
    [s1 release];
    return 0;
}

