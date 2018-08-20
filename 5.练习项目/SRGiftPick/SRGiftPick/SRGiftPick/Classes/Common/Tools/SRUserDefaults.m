//
//  TPCSaveTool.m
//  礼物说
//
//  Created by tripleCC on 15/1/8.
//  Copyright (c) 2014年 giftTalk All rights reserved.
//

#import "SRUserDefaults.h"

@implementation SRUserDefaults

+ (void)setObject:(id)obj forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
}

+ (id)objectForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
