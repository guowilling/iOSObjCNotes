
//
//  SRComment.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRComment.h"

@implementation SRComment

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"avatar_url": @"user.avatar_url",
             @"nickname": @"user.nickname"};
}

@end
