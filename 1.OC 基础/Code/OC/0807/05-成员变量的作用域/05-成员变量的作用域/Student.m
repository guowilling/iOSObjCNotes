//
//  Student.m
//  05-成员变量的作用域
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)study
{
    
    // _height = 10;
    [self setHeight:10];
    
    int h = [self height];
    
    _no = 2011;
    _weight = 100;
}
@end
