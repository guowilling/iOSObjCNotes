//
//  main.m
//  第一个OC项目
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main()
{    
    Student *stu = [Student new];
    
    [stu setAge:10];
    
    int c = [stu age];
    NSLog(@"c is %d", c);
    return 0;
}

