//
//  SRUser.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SRUserVerifiedType) {
    SRUserVerifiedTypeNone       = -1,    // 没有认证
    SRUserVerifiedTypePersonal   = 0,     // 个人认证
    SRUserVerifiedTypeEnterprise = 2,     // 企业认证
    SRUserVerifiedTypeMedia      = 3,     // 媒体认证
    SRUserVerifiedTypeWebsite    = 5,     // 网站认证
    SRUserVerifiedTypeDaren      = 220    // 微博达人
};

@interface SRUser : NSObject

/**	用户UID*/
@property (nonatomic, copy) NSString *idstr;
/**	用户昵称 */
@property (nonatomic, copy) NSString *screen_name;
/**	用户头像地址(中图), 50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 会员(mbtype > 2) */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter = isVip) BOOL vip;

@property (nonatomic, assign) SRUserVerifiedType verified_type;

@end
