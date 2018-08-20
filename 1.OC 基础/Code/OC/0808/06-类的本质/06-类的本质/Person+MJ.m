//
//  Person+MJ.m
//  06-类的本质
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person+MJ.h"

@implementation Person (MJ)
+ (void)load
{
    NSLog(@"Person(MJ)---load");
}
+ (void)initialize
{
    NSLog(@"Person(MJ)-initialize");
}
@end
