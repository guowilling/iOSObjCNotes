//
//  SRTopic.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRComment;

typedef NS_ENUM(NSInteger, SRTopicType) {
    SRTopicTypeAll = 1,
    SRTopicTypePicture = 10,
    SRTopicTypeText = 29,
    SRTopicTypeVoice = 31,
    SRTopicTypeVideo = 41,
};

@interface SRTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/**名称 */
@property (nonatomic, copy) NSString *name;
/**发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/**头像 */
@property (nonatomic, copy) NSString *profile_image;
/**正文 */
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign, getter = isSina_v) BOOL sina_v;
@property (nonatomic, assign) SRTopicType type;
@property (nonatomic, assign) NSInteger ding;
@property (nonatomic, assign) NSInteger cai;
@property (nonatomic, assign) NSInteger repost;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *middle_image;
@property (nonatomic, copy) NSString *large_image;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 评论模型 */
@property (nonatomic, strong) SRComment *top_cmt;

/** 图片显示大小 */
@property (nonatomic, assign,readonly) CGSize pictureSize;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

@end
