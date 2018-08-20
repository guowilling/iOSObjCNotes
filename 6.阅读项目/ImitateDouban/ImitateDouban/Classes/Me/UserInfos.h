
#import <Foundation/Foundation.h>

typedef enum {
    LoginType = 0,
    LoginOutType
}LoginStatusType;

@interface UserInfos : NSObject

+ (UserInfos *)sharedUserInfo;

+ (instancetype)userInfosWithDictionary:(NSDictionary *)dictionary;

- (void)saveUserInfosToLocal;

@property (nonatomic ,strong) NSString *logType;

@property (nonatomic ,strong) NSString *alt;

@property (nonatomic ,strong) NSString *avatar;

@property (nonatomic ,strong) NSString *created;

@property (nonatomic ,strong) NSString *desc;

@property (nonatomic ,strong) NSString *is_banned;

@property (nonatomic ,strong) NSString *is_suicide;

@property (nonatomic ,strong) NSString *large_avatar;

@property (nonatomic ,strong) NSString *loc_id;

@property (nonatomic ,strong) NSString *loc_name;

@property (nonatomic ,strong) NSString *name;

@property (nonatomic ,strong) NSString *signature;

@property (nonatomic ,strong) NSString *type;

@property (nonatomic ,strong) NSString *uid;

@end
