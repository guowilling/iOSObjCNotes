
#import "RecommendHttpTool.h"
#import "RecommendModel.h"

@implementation RecommendHttpTool

+ (void)getRecommendList:(NSInteger)startNum loc:(NSString *)loc type:(NSString *)type arrayBlock:(ArrayBlock)arrayBlock {
    
    NSString *URLString = [NSString stringWithFormat:@"%@?start=%zd&loc=%@&count=12&type=%@", Recommend_URL, startNum, loc, type];
    NSLog(@"RecommendListURL: %@", URLString);
    [HttpTools GET:URLString params:nil success:^(id json) {
        NSLog(@"RecommendListURL json: %@", json);
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        if ([json[@"events"] isKindOfClass:[NSArray class]]) {
            NSArray *resultDictArray = json[@"events"];
            for (NSDictionary *dict in resultDictArray) {
                RecommendModel *model = [[RecommendModel alloc] initWithDictionary:dict];
                [resultArray addObject:model];
            }
        }
        if (arrayBlock) {
            arrayBlock(resultArray);
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager networkError];
    }];
}

+ (void)getActivityInfo:(NSString *)activityID activityBlock:(ActivityBlock)activityBlock{
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", ActivityInfo_URL, activityID];
    NSLog(@"getActivityInfoURL: %@", URLString);
    [HttpTools GET:URLString params:nil success:^(id json) {
        NSLog(@"getActivityInfoURL json: %@", json);
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resDic = json;
            RecommendModel *model = [[RecommendModel alloc] initWithDictionary:resDic];
            if (activityBlock) {
                activityBlock(model);
            }
        }
        if (activityBlock) {
            activityBlock([[RecommendModel alloc] init]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager networkError];
    }];
}

@end
