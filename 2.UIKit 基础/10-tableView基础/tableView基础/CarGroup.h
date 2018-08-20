//
//  CarGroup.h
//  tableView基础
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject

@property (nonatomic, strong) NSArray *cars;
@property (nonatomic, copy) NSString *title;

+ (NSArray *)carGroups;

+ (instancetype)carGroupWithDcit:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
