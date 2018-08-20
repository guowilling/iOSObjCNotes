
#import "CastModel.h"
#import "AvatarsModel.h"

@implementation CastModel

- (id)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        if (dic[@"id"]) {
            self.ID = [NSString stringWithFormat:@"%@", dic[@"id"]];
        }
        if (dic[@"alt"]) {
            self.alt = [NSString stringWithFormat:@"%@", dic[@"alt"]];
        }
        if (dic[@"name"]) {
            self.name = [NSString stringWithFormat:@"%@", dic[@"name"]];
        }
        if (dic[@"avatars"] && ![dic[@"avatars"] isKindOfClass:[NSNull class]]) {
            self.avatars = [[AvatarsModel alloc] initWithDictionary:dic[@"avatars"]];
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
