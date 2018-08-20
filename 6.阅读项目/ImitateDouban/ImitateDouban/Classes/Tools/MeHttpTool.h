
#import <Foundation/Foundation.h>

@class UserInfos;

@interface MeHttpTool : NSObject

typedef void (^UserInfosSuccess)(UserInfos *user);
typedef void (^UserInfosFailure)(UserInfos *user, NSError *error);

+ (void)userInfosSuccess:(UserInfosSuccess)success failure:(UserInfosFailure)failure;

@end
