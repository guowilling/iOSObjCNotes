
#import "SRHttpSessionManager.h"

@implementation SRHttpSessionManager

+ (instancetype)sharedManager {
    static SRHttpSessionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SRHttpSessionManager alloc] initWithBaseURL:nil];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return self;
}

+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSError *error))failure
{
    SRLog(@"URL: %@", URLString);
    SRLog(@"Parameters: %@", parameters);
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[self sharedManager] GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        SRLog(@"%@ responseObject: %@", URLString, responseObject);
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"%@ error: %@", URLString, error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    SRLog(@"URL: %@", URLString);
    SRLog(@"Parameters: %@", parameters);
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[self sharedManager] POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        SRLog(@"%@ responseObject: %@", URLString, responseObject);
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"%@ error: %@", URLString, error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
