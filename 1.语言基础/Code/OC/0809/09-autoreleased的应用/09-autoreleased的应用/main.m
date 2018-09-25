//
//  main.m
//  09-autoreleased的应用
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "GoodPerson.h"

/*
 1.系统自带的方法名如果没有包含alloc、new、copy, 默认返回的对象都是autorelease的
 2.开发中经常会提供一些类方法，快速创建一个autorelease的对象
 */

int main()
{
    @autoreleasepool {
        Person *p1 = [Person personWithAge:100];

        GoodPerson *p2 = [GoodPerson personWithAge:10];
        p2.money = 100;
    }
    return 0;
}

void test()
{
    Person *p1 = [[Person alloc] init];
    p1.age = 200;
    [p1 release];
    
    @autoreleasepool
    {
        // Person *p2 = [Person person];
        // p2.age = 100;
        
        Person *p2 = [Person personWithAge:100];
        
        // Person *p2 = [[[Person alloc] init] autorelease];
        //
        // p2.age = 300;
        
        
        NSString *str1 = @"123123";
        
        NSString *str2 = [NSString stringWithFormat:@"age is %d", 10];
        
        NSNumber *num1 = [[NSNumber alloc] initWithInt:10];
        [num1 release];
        
        NSNumber *num2 = [NSNumber numberWithInt:100];
    }
}

