//
//  main.m
//  05-protoco
//
//  Created by apple on 13-8-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//


/*
 

 协议可定义在单独的.h文件中, 也可定义在某个类的.h文件中
 1. 如果这个协议只用在某个类中，应该把协议定义在该类中
 2. 如果这个协议会用在很多类中，应该把协议定义在单独文件中
 
 分类可定义在单独的.h和.m文件中, 也可定义在原来类中(一般都是定义在单独文件, 定义在原来类中的分类只要求能看懂语法)
 */

#import <Foundation/Foundation.h>
#import "MyProtocol1.h"
#import "MyProtocol3.h"
#import "Person.h"
#import "Dog.h"
#import "Hashiqi.h"

int main()
{
    Person *p = [[Person alloc] init];
    p.obj = [[Hashiqi alloc] init];
    
    return 0;
}

void test()
{
    //NSObject *obj = [[NSObject alloc] init];

    //NSObject *obj2 = @"123";
    
    // obj3保存的对象必须遵守MyProtocol协议
    NSObject<MyProtocol1> *obj3 = [[Person alloc] init];
    obj3 = nil;

    id<MyProtocol1> obj4 = [[Person alloc] init];  
    obj4 = nil;
    
    Person<MyProtocol3> *obj5 = [[Person alloc] init];
    obj5 = nil;
}