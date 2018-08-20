//
//  Person.h
//  04-点语法
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

- (void)setAge:(int)age;
- (int)age;


- (void)setName:(NSString *)name;
- (NSString *)name;

@end
