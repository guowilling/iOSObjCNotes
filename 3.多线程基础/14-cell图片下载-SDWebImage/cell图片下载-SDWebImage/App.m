//
//  App.m
//  cell图片下载-SDWebImage
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "App.h"

@implementation App

+ (NSArray *)apps {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self appWithDict:dict]];
    }
    return arrayM;
}

+ (instancetype)appWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

@end
