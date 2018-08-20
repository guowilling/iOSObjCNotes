//
//  Person+MJ.m
//  04-Category-分类
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person+MJ.h"

@implementation Person (MJ)
- (void)study
{
    NSLog(@"学习-----%d", _age);
}

- (void)test
{
    NSLog(@"Person (MJ)-test");
}
@end