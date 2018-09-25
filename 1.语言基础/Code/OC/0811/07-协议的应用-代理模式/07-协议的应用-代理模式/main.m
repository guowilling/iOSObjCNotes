//
//  main.m
//  07-协议的应用-代理模式
//
//  Created by apple on 13-6-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Agent.h"
#import "NextAgent.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Person *p = [[[Person alloc] init] autorelease];
        NextAgent *a = [[[NextAgent alloc] init] autorelease];
        p.delegate = a;
        
        [p buyTicket];
    }
    return 0;
}

void test()
{
    // 人
    Person *p = [[Person alloc] init];
    // 代理
    Agent *a = [[Agent alloc] init];
    // 设置人的代理
    p.delegate = a;
    
    [p buyTicket];
    
    [a release];
    [p release];
}
