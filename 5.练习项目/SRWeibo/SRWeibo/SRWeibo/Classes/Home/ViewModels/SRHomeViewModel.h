//
//  SRHomeViewModel.h
//  SRWeibo
//
//  Created by 郭伟林 on 16/11/10.
//  Copyright © 2016年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FailureBlock)(NSError *error);

@interface SRHomeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *statusFrames;

- (void)updateUserAccountSuccess:(void (^)(NSString *newNickname))success failure:(FailureBlock)failure;

- (void)loadCachedStatusSuccess:(void (^)(NSInteger newStatusCount))success failure:(FailureBlock)failure;

- (void)loadNewestStatusSuccess:(void (^)(NSInteger newStatusCount))success failure:(FailureBlock)failure;

- (void)loadMoreStatusSuccess:(void (^)(void))success failure:(FailureBlock)failure;

- (void)updateUnreadCountSuccess:(void (^)(NSInteger unreadCount))success failure:(FailureBlock)failure;

- (CGFloat)cellHeightOfRow:(NSInteger)row;

- (NSString *)currentUserNickname;

@end
