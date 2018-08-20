
#import <Foundation/Foundation.h>

@interface RatingModel : NSObject

@property (nonatomic ,strong) NSString *max;
@property (nonatomic ,strong) NSString *min;
@property (nonatomic ,strong) NSString *average;
@property (nonatomic ,strong) NSString *stars;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
