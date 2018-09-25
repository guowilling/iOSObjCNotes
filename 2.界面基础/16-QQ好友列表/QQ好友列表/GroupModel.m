//
//  GroupModel.m
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "GroupModel.h"
#import "FriendModel.h"

@implementation GroupModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        // 一层字典转模型
        [self setValuesForKeysWithDictionary:dict];
        // 二层字典转模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            FriendModel *friend = [FriendModel friendWithDict:dict];
            [arrayM addObject:friend];
        }
        self.friends = arrayM;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)groups {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"]];
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self groupWithDict:dict]];
    }
    return arrayM;
}

@end
