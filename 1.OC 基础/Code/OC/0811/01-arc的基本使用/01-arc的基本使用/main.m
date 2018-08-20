//
//  main.m
//  01-arc的基本使用
//
//  Created by apple on 13-8-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"


/*
 ARC原则：只要没有强指针指向对象, 就会释放对象
 
 ARC特点
 1. 不允许调用release、retain、retainCount
 2. 允许重写dealloc, 但是不允许调用[super dealloc]
 
 3. @property的参数
    * strong : 成员变量是强指针（OC对象类型）
    * weak   : 成员变量是弱指针（OC对象类型）
    * assign : 非OC对象类型
 4. retain改为strong, 其他不变
 
 指针分2种：
 1. 强指针：默认所有的指针都是强指针 __strong
 2. 弱指针：__weak
 
 */

int main()
{
    Dog *d = [[Dog alloc] init];
    
    Person *p = [[Person alloc] init];
    p.dog = d;
    
    d = nil;
    
    NSLog(@"%@", p.dog);
    
    return 0;
}
