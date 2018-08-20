
#import <Foundation/Foundation.h>

@interface UserAccount : NSObject

/** 授权后的access token */
@property (nonatomic, copy) NSString *access_token;

/** access token 的生命周期 单位秒 */
@property (nonatomic, copy) NSString *expires_in;

@property (nonatomic, strong) NSString *refresh_token;

/** 授权用户的UID */
@property (nonatomic, copy) NSString *douban_user_id;

- (id)initWithDict:(NSDictionary *)dic;

@end
