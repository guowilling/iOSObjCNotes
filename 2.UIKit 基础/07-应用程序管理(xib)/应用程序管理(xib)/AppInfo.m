//
//  AppInfo.m
//  应用程序管理(代码)
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

@synthesize image = _image;

- (UIImage *)image {
    if (_image == nil) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

+ (NSArray *)appInfos {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self appInfoWithDict:dict]];
    }
    return arrayM;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
