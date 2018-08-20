
#import <Foundation/Foundation.h>

@interface AvatarsModel : NSObject

@property (nonatomic, strong) NSString *small;
@property (nonatomic, strong) NSString *medium;
@property (nonatomic, strong) NSString *large;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
