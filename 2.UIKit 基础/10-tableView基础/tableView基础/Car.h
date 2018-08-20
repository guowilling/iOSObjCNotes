//
//  Car.h
//  tableView基础
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

+ (NSArray *)carsWithArray:(NSArray *)array;

+ (instancetype)carWithDcit:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
