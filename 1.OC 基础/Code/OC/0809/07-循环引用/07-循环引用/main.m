//
//  main.m
//  07-循环引用
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 1.@class的作用: 告诉编译器某个名称是一个类
 2.开发中, 在.h文件中用@class, 在.m文件中用#import
 优势: 提高效率, 解决循环引用问题
 
 3.循环引用解决方案: 一端用retain, 一端用assign
 */

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Person.h"

int main()
{
    // p - 1
    Person *p = [[Person alloc] init];
    // c - 1
    Card *c = [[Card alloc] init];
    
    // c - 2
    p.card = c;
    
    // p - 1
    c.person = p;
    
    // c - 1
    [c release];
    
    // p - 0  c - 0
    [p release];
    
    return 0;
}

