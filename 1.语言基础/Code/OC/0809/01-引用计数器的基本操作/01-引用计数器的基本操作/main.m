//
//  main.m
//  01-引用计数器的基本操作
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 相关方法
 1. retain: 计数器+1，返回对象本身
 2. release: 计数器-1，没有返回值
 3. retainCount: 获取计数器当前的值
 4. dealloc:
	* 当一个对象被回收的时候调用
	* 一定要调用[super dealloc], 并且放在最后面
 
 相关概念
 1. 僵尸对象: 内存已经被回收的对象, 僵尸对象不能再使用, 不能对僵尸对象发送任何消息
 2. 野指针: 指向僵尸对象（不可用内存）的指针, 给野指针发送消息会报错（EXC_BAD_ACCESS）
 3. 空指针: 没有指向任何东西的指针(存储的东西是nil、NULL、0), 给空指针发送消息不会报错
 */

#import <Foundation/Foundation.h>
#import "Person.h"

int main()
{
    // 1
    Person *p = [[Person alloc] init];
    
    //NSUInteger c = [p retainCount];
    //内存回收，运行时回收对象内存；main函数结束，程序退出时，自动回收。
    //NSLog(@"计数器：%ld", c);
    
    // 2 retain方法返回对象本身
    [p retain];
    
    // 1
    [p release];
    
    // 0 野指针
    [p release];
    
    // 不能复活
//    [p retain];
  
    // -[Person setAge:]: message sent to deallocated instance 0x100109a10
//    p.age = 10;
    
//    p = nil;
//    [p release];
//    [p release];
//    [nil release];
    
    return 0;
}

