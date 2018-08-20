//
//  Student.m
//  02-构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)init
{
    if ( self = [super init] )
    {
        _no = 1;
    }
    return self;
}

@end
