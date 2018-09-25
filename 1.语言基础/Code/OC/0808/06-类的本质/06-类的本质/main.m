//
//  main.m
//  06-类的本质
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import "GoodStudent.h"

int main()
{
    // [[GoodStudent alloc] init];
    
    return 0;
}

void test1()
{
    Person *p1 = [[Person alloc] init];
    
    Class c = [p1 class];
    [c test];
    
    Person *p2 = [[c new] init];
    
    NSLog(@"%@", p2);
}

void test()
{
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    
    // 类本身也是一个对象, Class类型的对象, 简称类对象
    
    // 利用Person类对象创建Person类型的对象
    Class c1 = [p1 class];
    Class c2 = [p2 class];
    
    // 利用Class创建Person类型的对象
    Class c3 = [Person class];
    NSLog(@"c=%p, c2=%p, c3=%p", c1, c2, c3);
 
}