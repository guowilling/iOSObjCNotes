//
//  Person.h
//  03-自定义构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property NSString *name;
@property int age;


// 自定义构造方法命名规范:
// 1.必须是对象方法 - 减号开头
// 2.方法名以initWith开头

- (id)initWithName:(NSString *)name;

- (id)initWithAge:(int)age;

- (id)initWithName:(NSString *)name andAge:(int)age;

@end
