//
//  main.m
//  03-arc-循环引用
//
//  Created by apple on 13-8-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

/**
 循环引用解决方案:
 ARC: 1端用strong，另1端用weak
 MRC: 1端用retain，另1端用assign
 */

int main()
{
    Person *p = [[Person alloc] init];
    
    Dog *d = [[Dog alloc] init];
    p.dog = d;
    d.person = p;

    return 0;
}

