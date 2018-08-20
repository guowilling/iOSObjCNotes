//
//  main.m
//  08-autorelease
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main()
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    Person *pp = [[[Person alloc] init] autorelease];
    
    [pool release]; // [pool drain];
    
    @autoreleasepool
    {
    
        // 1
        Person *p = [[[[Person alloc] init] autorelease] autorelease];
        
        // 0
        // [p release]; // 野指针错误
    }
    
    return 0;
}


void test()
{
    @autoreleasepool
    { // { 代表创建了释放池
        
        // autorelease方法会返回对象本身, 并且对象的计数器不变
        // autorelease将对象放到一个自动释放池中, 当自动释放池销毁时, 对池子里面的所有对象做一次release操作
        Person *p = [[[Person alloc] init] autorelease];
        p.age = 10;
    
        @autoreleasepool
        {
            // 1
            Person *p2 = [[[Person alloc] init] autorelease];  // 放在池子2
            p2.age = 10;
    
        } // 0 
        
        Person *p3 = [[[Person alloc] init] autorelease];  // 放在池子1
        
    } // } 代表销毁释放池
}

