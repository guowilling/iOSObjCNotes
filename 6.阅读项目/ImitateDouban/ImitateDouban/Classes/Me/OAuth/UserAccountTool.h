
#import <Foundation/Foundation.h>

@class UserAccount;

typedef void (^AccessTokenSuccess)();

@interface UserAccountTool : NSObject

+ (UserAccount *)currenAccount;

+ (void)getAccessTokenWithcode:(NSString *)code success:(AccessTokenSuccess)success filure:(HttpFailure)failure;

+ (void)saveAccount:(UserAccount *)account;

@end
