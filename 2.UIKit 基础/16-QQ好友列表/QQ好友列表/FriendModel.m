//
//  FriendModel.m
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
