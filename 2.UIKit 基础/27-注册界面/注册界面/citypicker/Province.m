//
//  Province.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "Province.h"

@implementation Province

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)provinceWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)provinces {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self provinceWithDict:dict]];
    }
    return arrayM;
}

@end
