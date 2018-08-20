//
//  Person.h
//  第一个OC项目
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _age;
}

- (void)setAge:(int)age;
- (int)age;

+ (void)test;

@end
