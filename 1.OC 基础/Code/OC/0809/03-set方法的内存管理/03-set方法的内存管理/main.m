//
//  main.m
//  03-set方法的内存管理
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "Person.h"
#import "Student.h"
#import "Dog.h"
/**
 set方法的代码规范:
 1. 基本数据类型: 直接赋值
 - (void)setAge:(int)age
 { 
    _age = age;
 }
 
 2. OC对象类型
 - (void)setCar:(Car *)car
 {
    // 1.如果传递进来的是新对象
    if ( car != _car )
    {
        // 2.对旧对象做一次release
        [_car release];
 
        // 3.对新对象做一次retain
        _car = [car retain];
    }
 }
 
 dealloc方法的代码规范:
 1. 一定要调用[super dealloc], 一定要放到最后面
 2. 对所拥有的其他对象做一次release
 - (void)dealloc
 {
    [_car release];
    [super dealloc];
 }
 */

int main()
{
    // stu - 1
    Student *stu = [[Student alloc] init];
    
    // Car - 2
    // stu.car = [[Car alloc] init]; // 内存泄露有alloc没有release
    
    // stu - 0
    // Car - 1
    [stu release];
    
    // [[Car alloc] init].speed = 100; // 内存泄露对象没有释放
    
    return 0;
}


void test3()
{
    Student *stu = [[Student alloc] init];
    
    Car *c = [[Car alloc] init];
    stu.car = c;
    
    Dog *d = [[Dog alloc] init];
    stu.dog = d;
    
    NSString *s = @"Jack";
    stu.name = s;
	
    // [s release]; // 没有alloc就不要release!!!
	
    [d release];
    [c release];
    [stu release];
}

void test2()
{
    Person *p1 = [[Person alloc] init];
    p1.age = 20;
    
    // c1 - 1
    Car *c1 = [[Car alloc] init];
    c1.speed = 100;
    // c1 - 2
    p1.car = c1;
    // c1 - 1
    [c1 release];
    
    // c2-1
    Car *c2 = [[Car alloc] init];
    c2.speed = 200;
    // c1 - 0
    // c2 - 2
    p1.car = c2;
    
    // c2 -1
    [c2 release];

    [p1 release];
}

void test1()
{
    // p-1
    Person *p = [[Person alloc] init];
    p.age = 20;
    
    // c1-1
    Car *c1 = [[Car alloc] init];
    c1.speed = 250;
    
    // c1-2
    p.car = c1;
    
    // c1-1
    [c1 release];
    
    p.car = c1;
    p.car = c1;
    p.car = c1;
    p.car = c1;
    p.car = c1;
    p.car = c1;
    p.car = c1;
    
    [p release];
}

void test()
{
    // p-1
    Person *p = [[Person alloc] init];
    p.age = 20;
    
    // c1-1
    Car *c1 = [[Car alloc] init];
    c1.speed = 250;
    
    // p想拥有c1
    // c1-2
    p.car = c1;
    
    // c2-1
    Car *c2 = [[Car alloc] init];
    c2.speed = 300;
    
    // p将车换成了c2
    // c1-1
    // c2-2
    p.car = c2;
    
    // c2-1
    [c2 release];
    // c1-0
    [c1 release];
    // p-0 c2-0
    [p release];
}