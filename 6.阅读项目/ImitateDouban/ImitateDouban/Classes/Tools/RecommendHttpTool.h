
#import <Foundation/Foundation.h>

@class RecommendModel;

typedef void (^ActivityBlock)(RecommendModel *activityModel);

@interface RecommendHttpTool : NSObject

+ (void)getRecommendList:(NSInteger)startNum loc:(NSString *)loc type:(NSString *)type arrayBlock:(ArrayBlock)arrayBlock;

+ (void)getActivityInfo:(NSString *)activityID activityBlock:(ActivityBlock)activityBlock;

@end
