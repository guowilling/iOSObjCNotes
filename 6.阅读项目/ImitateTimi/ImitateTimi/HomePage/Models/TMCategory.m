
#import "TMCategory.h"

@implementation TMCategory

// Specify default values for properties
//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)
+ (NSArray *)ignoredProperties
{
    return @[kCTImage, kCTPercent];
}

+ (NSString *)primaryKey {
    
    return kCTID;
}

- (UIImage *)categoryImage {
    
    return [UIImage imageNamed:self.categoryImageFileNmae];
}

+ (instancetype)categoryWithDic:(NSDictionary *)dic {
    
    return  [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

#pragma mark -

+ (NSArray *)categoryList {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"category" ofType:@"plist"];
    NSArray *dics = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dic in dics) {
        TMCategory *category = [TMCategory categoryWithDic:dic];
        [arrayM addObject:category];
    }
    return arrayM;
}

- (void)modifyCategoryTitle:(NSString *)categoryTitle {
    
    if ([self.categoryTitle isEqualToString:categoryTitle])return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMCategory *category = [[TMCategory objectsWhere:@"categoryID == %@",self.categoryID] firstObject];
    [realm transactionWithBlock:^{
        category.categoryTitle = categoryTitle;
    }];
}

@end
