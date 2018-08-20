
#import "UserAccountTool.h"
#import "UserAccount.h"

#define kAccountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

static UserAccount *_currenAccount;

@implementation UserAccountTool

+ (void)saveAccount:(UserAccount *)account {
    
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];
}

+ (UserAccount *)currenAccount {
    
    if (_currenAccount == nil) {
        _currenAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    }
    return _currenAccount;
}

+ (void)getAccessTokenWithcode:(NSString *)code success:(AccessTokenSuccess)success filure:(HttpFailure)failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = APIKey;
    params[@"client_secret"] = APISecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = Redirect_uri;
    [HttpTools POST:Access_TokenUrl params:params success:^(id jsonDic){
        NSLog(@"getAccessTokenWithcode success jsonDic : %@", jsonDic);
        UserAccount *account = [[UserAccount alloc] initWithDict:jsonDic];
        [UserAccountTool saveAccount:account];
        if (success) {
            success();
        }
    } failure:failure];
}

@end
