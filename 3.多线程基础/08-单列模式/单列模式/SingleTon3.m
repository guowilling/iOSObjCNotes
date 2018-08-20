//
//  SingleTon3.m
//  单列模式
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//  GCD

#import "SingleTon3.h"

@implementation SingleTon3

static id _instance;

+ (instancetype)sharedSingleTon3 {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"setup");
        });
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}

@end
