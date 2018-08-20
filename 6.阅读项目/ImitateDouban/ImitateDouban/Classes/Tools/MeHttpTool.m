
#import "MeHttpTool.h"
#import "UserInfos.h"
#import "UserAccount.h"
#import "UserAccountTool.h"

@implementation MeHttpTool

+ (void)userInfosSuccess:(UserInfosSuccess)success failure:(UserInfosFailure)failure {
    
    NSString *userID = [UserAccountTool currenAccount].douban_user_id;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", UserInfo_URL, userID];
    [HttpTools GET:urlString params:nil success:^(id json) {
        NSLog(@"json: %@",json);
        if ([json isKindOfClass:[NSDictionary class]]) {
            UserInfos *user = [UserInfos userInfosWithDictionary:json];
            [user saveUserInfosToLocal];
            if (success) {
                success(user);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            UserInfos *user = [UserInfos sharedUserInfo];
            failure(user, error);
        }
    }];
}

@end
