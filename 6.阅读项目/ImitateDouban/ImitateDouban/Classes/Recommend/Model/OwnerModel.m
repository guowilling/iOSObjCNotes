
#import "OwnerModel.h"

@implementation OwnerModel

- (id)initWithDictionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        if (dic[@"id"]) {
            self.ID = [NSString stringWithFormat:@"%@", dic[@"id"]];
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
