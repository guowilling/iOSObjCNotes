//
//  SRComposeViewModel.m
//  SRWeibo
//
//  Created by 郭伟林 on 16/11/14.
//  Copyright © 2016年 郭伟林. All rights reserved.
//

#import "SRComposeViewModel.h"
#import "AFNetworking.h"
#import "SRAccount.h"

@implementation SRComposeViewModel

- (void)sendStatusWithText:(NSString *)text
                     image:(UIImage *)image
                   success:(void (^)(void))success
                   failure:(void (^)(NSError *error))failure
{
//    self.success = success; // 这样子写才会造成 Block 的循环引用, 需要在调用此 Block 的地方使用 __weak.
//    self.failure = failure;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SRAccountManager account].access_token;
    params[@"status"] = text;
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"xx.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)sendStatusWithText:(NSString *)text
                   success:(void (^)(void))success
                   failure:(void (^)(NSError *error))failure
{    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SRAccountManager account].access_token;
    params[@"status"] = text;
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSString *)currentUserNickname {
    return [SRAccountManager account].nickname;
}

@end
