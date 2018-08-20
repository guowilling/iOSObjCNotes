//
//  Student.m
//  03-自定义构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithNo:(int)no
{
    if ( self = [super init] )
    {
        _no = no;
    }
    return self;
}

- (id)initWithName:(NSString *)name andAge:(int)age andNo:(int)no
{
    if ( self = [super initWithName:name andAge:age])
    {
        _no = no;
    }
    
    return self;
}

@end
