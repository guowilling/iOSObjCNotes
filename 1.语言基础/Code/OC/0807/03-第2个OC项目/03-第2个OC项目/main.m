//
//  main.m
//  03-第2个OC项目
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{
    Person *p = [Person new];
    //[p];
    
    [p setAge:10];
    
    int a = [p age];
    
    NSLog(@"年龄是%d", a);
    
    return 0;
}