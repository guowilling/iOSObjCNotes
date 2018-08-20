//
//  SRRecommendUser.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRRecommendUser : NSObject

/** 推荐的id */
@property (nonatomic, strong) NSString *uid;
/** 推荐用户的关注量 */
@property (nonatomic, strong) NSString *fans_count;
/** 是否是我关注的用户 */
@property (nonatomic, assign) NSInteger is_follow;
/** 性别 */
@property (nonatomic, assign) NSInteger gender;
/** 推荐用户的昵称 */
@property (nonatomic, strong) NSString *screen_name;
/** 推荐用户的头像url */
@property (nonatomic, strong) NSString *header;
/** 用户描述 */
@property (nonatomic, strong) NSString *introduction;
/** 帖子数量 */
@property (nonatomic, assign) NSInteger *tize_count;

@end
