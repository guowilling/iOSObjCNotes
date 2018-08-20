//
//  main.m
//  04-@property参数
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Book.h"

int main()
{
    Book *b = [[Book alloc] init];
    Person *p = [[Person alloc] init];
    
    p.book = b;
    
    
    NSLog(@"%ld", [b retainCount]);
    
    
    [p release];
    [b release];
    return 0;
}

