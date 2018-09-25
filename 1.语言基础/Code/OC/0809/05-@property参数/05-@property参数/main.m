//
//  main.m
//  05-@property参数
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main()
{
    Person *p = [[Person alloc] init];
    
    p.rich = YES;
    
    BOOL b = p.isRich;
    
    return 0;
}

