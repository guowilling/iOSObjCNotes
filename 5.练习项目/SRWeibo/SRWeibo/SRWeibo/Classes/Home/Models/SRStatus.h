//
//  SRStatus.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRUser, SRStatus;

@interface SRStatus : NSObject

/** 微博ID */
@property (nonatomic, copy) NSString *idstr;

/**	微博正文内容 */
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;

/**	微博作者的用户信息 */
@property (nonatomic, strong) SRUser *user;

/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

/** 微博来源 */
@property (nonatomic, copy) NSString *source;

/** 微博配图地址数组 */
@property (nonatomic, strong) NSArray *pic_urls;

/** 转发的微博 */
@property (nonatomic, strong) SRStatus *retweeted_status;
@property (nonatomic, copy) NSAttributedString *retweetedAttributedText;

/**	int	转发数 */
@property (nonatomic, assign) int reposts_count;
/**	int	评论数 */
@property (nonatomic, assign) int comments_count;
/**	int	表态数 */
@property (nonatomic, assign) int attitudes_count;

@end
