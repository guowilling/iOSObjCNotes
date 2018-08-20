//
//  SRAccount.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRAccount : NSObject <NSCoding>

/** access_token */
@property (nonatomic, copy) NSString *access_token;

/** access_token 的过期时间 */
@property (nonatomic, copy) NSString *expires_in;

/** 当前授权用户的 UID */
@property (nonatomic, copy) NSString *uid;

/** access_token 的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

/** 用户昵称 */
@property (nonatomic, strong) NSString *nickname;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface SRAccountManager : NSObject

+ (SRAccount *)account;
+ (void)saveAccount:(SRAccount *)account;

@end
