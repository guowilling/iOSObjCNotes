//
//  SRAccount.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRAccount.h"
#import "MJExtension.h"

@implementation SRAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _access_token = dict[@"access_token"];
        _expires_in = dict[@"expires_in"];
        _uid = dict[@"uid"];
        _created_time = [NSDate date];
    }
    return self;
}

//MJCodingImplementation
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_created_time forKey:@"created_time"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in   = [aDecoder decodeObjectForKey:@"expires_in"];
        _uid          = [aDecoder decodeObjectForKey:@"uid"];
        _created_time = [aDecoder decodeObjectForKey:@"created_time"];
        _nickname     = [aDecoder decodeObjectForKey:@"nickname"];
    }
    return self;
}

@end

#define kAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation SRAccountManager

+ (void)saveAccount:(SRAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];
}

+ (SRAccount *)account {
    SRAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    {
        // 验证账号是否过期
        long long expires_in = [account.expires_in longLongValue];
        NSDate *expires_time = [account.created_time dateByAddingTimeInterval:expires_in];
        NSDate *now = [NSDate date];
        NSComparisonResult result = [expires_time compare:now];
        /**
         * result:
         * NSOrderedAscending = -1L, 升序，左边 < 右边
         * NSOrderedSame, 相等
         * NSOrderedDescending 降序, 左边 > 右边
         */
        if (result != NSOrderedDescending) { // expiresTime <= now 过期
            return nil;
        }
    }
    return account;
}

@end
