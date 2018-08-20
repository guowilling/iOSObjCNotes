
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SRHttpSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSError *error))failure;

@end
