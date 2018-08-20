//
//  promotion.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRPromotion : NSObject

/** 16进制颜色标识 */
@property (copy, nonatomic) NSString *color;
/** 图标 */
@property (copy, nonatomic) NSString *icon_url;
/** id */
@property (copy, nonatomic) NSString *ID;
/** 目标链接 */
@property (copy, nonatomic) NSString *target_url;
/** 名称 */
@property (copy, nonatomic) NSString *title;

@end
