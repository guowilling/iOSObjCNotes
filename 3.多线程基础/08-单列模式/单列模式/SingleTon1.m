//
//  SingleTon1.m
//  单列模式
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//  懒汉式

#import "SingleTon1.h"

@implementation SingleTon1

static id _instance;

+ (instancetype)sharedSingleTon1 {
    
    if (!_instance) {
        @synchronized(self) {
            if (!_instance) {
                _instance = [[self alloc] init];
            }
        }
    }
    return _instance;
}

// alloc 方法内部调用此方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!_instance) { // 防止频繁加锁
        @synchronized(self) {
            if (!_instance) { // 防止创建多次
                _instance = [super allocWithZone:zone];
            }
        }
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

// copy 方法内部调用此方法
- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}

// MRC 环境
//- (id)retain {
//    return self;
//}

//- (NSUInteger)retainCount {
//    return 1;
//}

//- (oneway void)release {
//}

//- (id)autorelease {
//    return self;
//}

@end
