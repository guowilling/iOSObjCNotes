//
//  main.m
//  02-多个对象之间的内存管理
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/*
 1.想使用（占用）某个对象，就应该让对象的计数器+1（让对象做一次retain操作）
 2.不想再使用（占用）某个对象，就应该让对象的计数器-1（让对象做一次release）
 
 3.谁retain, 谁release
 4.谁alloc, 谁release
 */

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Book.h"

int main()
{
    // b = 1
    Book *b = [[Book alloc] init];
    // p = 1
    Person *p = [[Person alloc] init];
    
    // p想占用b这本书
    // b = 2
    [p setBook:b];
    
    // p = 0
    // b = 1
    [p release];
    
    // b = 0
    [b release];
    
    return 0;
}

