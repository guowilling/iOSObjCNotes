//
//  main.m
//  07-description方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main()
{
    // 行号
    NSLog(@"%d", __LINE__);
    
     NSLog(@"%s", __FILE__);
    
    printf("%s", __FILE__);
	
    NSLog(@"%s\n", __func__);
    
    Person *p = [[Person alloc] init];
    NSLog(@"%p", &p);
    NSLog(@"%p", p);
    
    return 0;
}

void test2()
{
    Class c = [Person class];
    
    // 调用类的+description方法
    NSLog(@"%@", c);
}

void test1()
{
    Person *p = [[Person alloc] init];
    p.age = 20;
    p.name = @"Jack";

	// NSLog输出过程:调用对象的 -description方法, 默认返回“<类名+内存地址>”;
    
    Person *p2 = [[Person alloc] init];
    p2.age = 25;
    p2.name = @"Jake";
    NSLog(@"%@", p2);
}