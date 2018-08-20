//
//  Person.m
//  02-构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@implementation Person


- (id)init
{  
    if ( self = [super init] )
    {
        _age = 10;
    }
    return self;
}

@end
