//
//  main.m
//  03-自定义构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Student *p = [[Student alloc] initWithName:@"Jim" andAge:29 andNo:10];
        NSLog(@"%@", p);
    }
    return 0;
}