
#import <Foundation/Foundation.h>

typedef void (^HttpSuccess)(NSDictionary *data);
typedef void (^HttpFailure)(NSError *error);
typedef void (^ArrayBlock)(NSMutableArray *array);

@interface HttpTools : NSObject

+ (void)GET:(NSString *)URLString params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;

+ (void)POST:(NSString *)URLString params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
