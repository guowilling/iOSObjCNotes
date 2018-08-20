//
//  SRHomeViewModel.m
//  SRWeibo
//
//  Created by 郭伟林 on 16/11/10.
//  Copyright © 2016年 郭伟林. All rights reserved.
//

#import "SRHomeViewModel.h"
#import "SRUser.h"
#import "SRAccount.h"
#import "SRStatus.h"
#import "SRStatusFrame.h"
#import "SRStatusCacheManager.h"
#import "AFNetworking.h"
#import "SRHttpSessionManager.h"
#import "MJExtension.h"

@implementation SRHomeViewModel

- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)updateUserAccountSuccess:(void (^)(NSString *newNickname))success failure:(FailureBlock)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SRAccount *account = [SRAccountManager account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [manager GET:@"https://api.weibo.com/2/users/show.json"
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             SRLog(@"updateUserAccountSuccess responseObject: %@", responseObject);
             SRUser *user = [SRUser objectWithKeyValues:responseObject];
             NSString *newNickname = user.screen_name;
             if (![newNickname isEqualToString:account.nickname]) {
                 account.nickname = newNickname;
                 [SRAccountManager saveAccount:account];
                 if (success) {
                     success(newNickname);
                 }
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             SRLog(@"updateUserAccountSuccess error: %@", error);
             if (failure) {
                 failure(error);
             }
         }];
}

- (void)loadCachedStatusSuccess:(void (^)(NSInteger newStatusCount))success failure:(FailureBlock)failure {
    SRAccount *account = [SRAccountManager account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    NSArray *dictArray = [SRStatusCacheManager statusesWithParams:params];
    if (dictArray && dictArray.count > 0) {
        NSArray *statuses = [SRStatus objectArrayWithKeyValuesArray:dictArray];
        NSArray *statusFrames = [self statusFramesWithStatus:statuses];
        NSRange range = NSMakeRange(0, statusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        if (success) {
            success(0);
        }
    } else {
        [self loadNewestStatusSuccess:success failure:failure];
    }
}

- (void)loadNewestStatusSuccess:(void (^)(NSInteger newStatusCount))success failure:(FailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SRAccount *account = [SRAccountManager account];
    params[@"access_token"] = account.access_token;
    SRStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    if (firstStatusFrame) {
        params[@"since_id"] = firstStatusFrame.status.idstr; // 若指定此参数则返回 ID 比 since_id 大的微博(即比 since_id 时间晚的微博)
    }
    [SRHttpSessionManager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json"
                   parameters:params
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [SRStatusCacheManager saveStatuses:responseObject[@"statuses"]];
                          NSArray *statuses = [SRStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
                          NSArray *statusFrames = [self statusFramesWithStatus:statuses];
                          NSRange range = NSMakeRange(0, statusFrames.count);
                          NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                          [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
                          if (success) {
                              success(statusFrames.count);
                          }
                      } failure:^(NSError *error) {
                          if (failure) {
                              failure(error);
                          }
                      }];
}

- (void)loadMoreStatusSuccess:(void (^)(void))success failure:(FailureBlock)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    SRAccount *account = [SRAccountManager account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    SRStatusFrame *bottomStatusFrame = [self.statusFrames lastObject];
    if (bottomStatusFrame) {
        long long maxId = [bottomStatusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(maxId); // 若指定此参数则返回ID小于或等于max_id的微博
    }
    void (^handleResult)(NSArray *) = ^(NSArray *dictArray) {
        NSArray *statuses = [SRStatus objectArrayWithKeyValuesArray:dictArray];
        NSArray *statusesFrames = [self statusFramesWithStatus:statuses];
        [self.statusFrames addObjectsFromArray:statusesFrames];
        if (success) {
            success();
        }
    };
    NSArray *dictArray = [SRStatusCacheManager statusesWithParams:params];
    if (dictArray.count && dictArray.count > 0) {
        handleResult(dictArray);
    } else {
        [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json"
          parameters:params
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [SRStatusCacheManager saveStatuses:responseObject[@"statuses"]];
                 handleResult(responseObject[@"statuses"]);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (failure) {
                     failure(error);
                 }
             }];
    }
}

- (void)updateUnreadCountSuccess:(void (^)(NSInteger unreadCount))success failure:(FailureBlock)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SRAccount *account = [SRAccountManager account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    NSString *URLString = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    [manager GET:URLString
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSInteger unreadCount = [responseObject[@"status"] integerValue];
             if (success) {
                 success(unreadCount);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error);
             }
         }];
}

- (NSArray *)statusFramesWithStatus:(NSArray *)statuses {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (SRStatus *status in statuses) {
        SRStatusFrame *statusFrame = [[SRStatusFrame alloc] init];
        statusFrame.status = status;
        [arrayM addObject:statusFrame];
    }
    return arrayM;
}

- (CGFloat)cellHeightOfRow:(NSInteger)row {
    SRStatusFrame *statusFrame = self.statusFrames[row];
    return statusFrame.cellHeight;
}

- (NSString *)currentUserNickname {
    return [SRAccountManager account].nickname;
}

@end
