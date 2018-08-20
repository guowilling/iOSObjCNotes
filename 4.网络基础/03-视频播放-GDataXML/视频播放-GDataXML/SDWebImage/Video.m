//
//  Video.m
//  视频播放-JSON
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "Video.h"

@implementation Video

+ (instancetype)videoWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
