//
//  GroupModel.h
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger online;

@property (nonatomic, assign, getter = isOpen) BOOL open;

+ (NSArray *)groups;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;

@end
