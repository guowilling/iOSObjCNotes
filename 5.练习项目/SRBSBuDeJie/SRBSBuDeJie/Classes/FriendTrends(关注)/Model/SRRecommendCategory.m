//
//  SRRecommendCategory.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRRecommendCategory.h"

@implementation SRRecommendCategory

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users {
    
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
