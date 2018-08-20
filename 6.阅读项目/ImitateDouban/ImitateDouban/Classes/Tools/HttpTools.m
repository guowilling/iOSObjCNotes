
#import "HttpTools.h"
#import "AFNetworking.h"

@implementation HttpTools

+ (void)GET:(NSString *)URLString params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
