//
//  SRTopic.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTopic.h"

@implementation SRTopic

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"ID": @"id",
             @"small_image": @"image0",
             @"large_image": @"image1",
             @"middle_image": @"image2"};
}

- (CGSize)pictureSize {
    
    if (self.type == SRTopicTypeText) {
        return CGSizeZero;
    }

    CGFloat pictureW = SRScreenW - 2 * 10;
    CGFloat pictureH = pictureW * (self.height / self.width);
    if (pictureH >= 500) {
        pictureH = 250;
        self.bigPicture = YES;
    }
    return CGSizeMake(pictureW, pictureH);
}

@end
