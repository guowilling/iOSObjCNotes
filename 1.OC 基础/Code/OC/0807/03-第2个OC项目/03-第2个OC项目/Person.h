//
//  Person.h
//  03-第2个OC项目
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _age;
    NSString *_name;
}

// 年龄的seter和getter声明
- (void)setAge:(int)age;
- (int)age;

// 姓名的seter和getter声明
- (void)setName:(NSString *)name;
- (NSString *)name;

@end
