//
//  CountryModel.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)countryWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)countrys {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"]];
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self countryWithDict:dict]];
    }
    return arrayM;
}

@end
