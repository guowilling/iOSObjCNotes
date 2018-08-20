
#import "RatingModel.h"

@implementation RatingModel

- (id)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        if (dic[@"max"]) {
            self.max = [NSString stringWithFormat:@"%@", dic[@"max"]];
        }
        if (dic[@"average"]) {
            self.average = [NSString stringWithFormat:@"%@", dic[@"average"]];
        }
        if (dic[@"stars"]) {
            self.stars = [NSString stringWithFormat:@"%@", dic[@"stars"]];
        }
        if (dic[@"min"]) {
            self.min = [NSString stringWithFormat:@"%@", dic[@"min"]];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForKeyPath:(NSString *)keyPath {
    
    return nil;
}

@end
