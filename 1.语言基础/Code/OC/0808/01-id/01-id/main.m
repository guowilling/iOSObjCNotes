//
//  main.m
//  01-id
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"


void test(id d)
{
    
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Person *person = [Person new];
        
        NSObject *object = [Person new];
        
        // id == NSObject *
        id p = [Person new];
        
        [p setAge:10];
        [p setObj:@"xx"];
        
        NSLog(@"%d", [p age]);
    }
    return 0;
}

