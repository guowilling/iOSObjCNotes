//
//  SRBanner.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRBannerTarget;

@interface SRBanner : NSObject

@property (copy, nonatomic) NSString *image_url;
@property (copy, nonatomic) NSString *target_id;
@property (copy, nonatomic) NSString *target_url;
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) SRBannerTarget *target;

@end
