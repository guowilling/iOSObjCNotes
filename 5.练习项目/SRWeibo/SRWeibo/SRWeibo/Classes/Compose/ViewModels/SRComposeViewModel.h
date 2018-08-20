//
//  SRComposeViewModel.h
//  SRWeibo
//
//  Created by 郭伟林 on 16/11/14.
//  Copyright © 2016年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRComposeViewModel : NSObject

@property (nonatomic, copy) void (^success)(void);
@property (nonatomic, copy) void (^failure)(NSError *error);

- (NSString *)currentUserNickname;

- (void)sendStatusWithText:(NSString *)text
                     image:(UIImage *)image
                   success:(void (^)(void))success
                   failure:(void (^)(NSError *error))failure;

- (void)sendStatusWithText:(NSString *)text
                   success:(void (^)(void))success
                   failure:(void (^)(NSError *error))failure;

@end
