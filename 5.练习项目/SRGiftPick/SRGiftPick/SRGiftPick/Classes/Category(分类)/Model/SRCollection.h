//
//  GPRaiderCollection.h
//  礼物说
//
//  Created by heew on 15/1/23.
//  Copyright (c) 2014年 giftTalk All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRCollection : NSObject

/** banner地址 */
@property (nonatomic, copy) NSString *banner_image_url;
/** ID */
@property (nonatomic, assign) NSInteger ID;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 发布数量 */
@property (nonatomic, copy) NSString *posts_count;

@end
