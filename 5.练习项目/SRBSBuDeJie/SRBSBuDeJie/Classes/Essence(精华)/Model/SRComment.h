//
//  SRComment.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRUser;

@interface SRComment : NSObject

@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户模型 */
@property (nonatomic, strong) SRUser *user;

@end
