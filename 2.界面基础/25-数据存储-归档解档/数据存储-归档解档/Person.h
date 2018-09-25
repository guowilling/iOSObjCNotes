//
//  Person.h
//  数据存储-归档解档
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 如果对象是 NSString、NSDictionary、NSArray、NSData、NSNumber 等类型可以直接进行归档和解档.
 * 其它对象需要遵守了 NSCoding 协议, 实现相应代理方法才可以.
 */

@interface Person : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
