//
//  SRStatusFrame.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRStatus;

// 昵称字体
#define SRNameFont [UIFont systemFontOfSize:14]

// 时间字体
#define SRTimeFont [UIFont systemFontOfSize:11]

// 来源字体
#define SRSourceFont SRTimeFont

// 正文字体
#define SRContentFont [UIFont fontWithName:@"PingFangSC-Light" size:15 / 375.0 * SRScreenW] // [UIFont systemFontOfSize:13]

// 转发微博正文字体
#define SRRetweetContentFont SRContentFont

// 间距
#define SRSpacing 10

@interface SRStatusFrame : NSObject

@property (nonatomic, strong) SRStatus *status;

/** 原创微博 */
/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconImageViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nicknameLabelF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipImageViewF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLableF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLableF;
/** 配图 */
@property (nonatomic, assign) CGRect picturesViewF;

/** 转发微博 */
/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博昵称:正文 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发微博配图 */
@property (nonatomic, assign) CGRect retweetPicsViewF;

/** 工具条 */
@property (nonatomic, assign) CGRect toolBarViewF;
/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
