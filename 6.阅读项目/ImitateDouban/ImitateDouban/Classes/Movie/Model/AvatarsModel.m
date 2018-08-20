
#import "AvatarsModel.h"

@implementation AvatarsModel

- (id)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForKeyPath:(NSString *)keyPath {
    
    return nil;
}

@end
