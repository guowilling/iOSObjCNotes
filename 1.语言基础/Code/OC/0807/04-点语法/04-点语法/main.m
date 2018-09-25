//
//  main.m
//  04-点语法
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{
    Person *p = [Person new];
    
    p.age = 10;
//    [p setAge:10];
    
    int a = p.age;
//    int a = [p age];
    
    p.name = @"Jack";
    NSString *s = p.name;
    
    NSLog(@"%d--%@", a, s);
    
    return 0;
}

