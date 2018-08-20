//
//  SRTagRecommend.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTagRecommend.h"

@implementation SRTagRecommend

- (void)setSub_number:(NSString *)sub_number {
    NSInteger sub_number_temp = [sub_number integerValue];
    _sub_number = sub_number_temp > 10000 ? [NSString stringWithFormat:@"%.1f万人订阅", sub_number_temp /10000.0] : [NSString stringWithFormat:@"%zd人订阅", sub_number_temp];
}

@end
