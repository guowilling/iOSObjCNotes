//
//  SingleTon2.m
//  单列模式
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//  饿汉式

#import "SingleTon2.h"

@implementation SingleTon2

static id _instance;

+ (void)load {
    
    if (!_instance) {
        _instance = [[self alloc] init];
    }
}

+ (instancetype)sharedSingleTon2 {
    
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!_instance) {
        _instance = [super allocWithZone:zone];
    }
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
