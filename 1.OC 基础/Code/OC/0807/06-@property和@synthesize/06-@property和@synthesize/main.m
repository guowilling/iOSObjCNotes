//
//  main.m
//  06-@property和@synthesize
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Cat.h"
#import "Dog.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
//        Dog *d = [Dog new];
//        
//        d.age = 5;
        
//        NSLog(@"%d", d.age);
        
        Cat *c = [Cat new];
        c.age =5;
    }
    return 0;
}

