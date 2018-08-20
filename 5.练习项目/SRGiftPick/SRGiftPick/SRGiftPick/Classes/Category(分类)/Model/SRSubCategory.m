//
//  SRSubCategory.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSubCategory.h"

@implementation SRSubCategory

- (void)setIcon_url:(NSString *)icon_url {
    
    NSMutableString *tempIcon_url = [NSMutableString stringWithString:icon_url];
    NSRange range = [tempIcon_url rangeOfString:@"-pw144"];
    [tempIcon_url deleteCharactersInRange:range];
    _icon_url = tempIcon_url;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"ID": @"id"};
}

@end
