
#import "TMAddCategory.h"

@implementation TMAddCategory

// Specify default values for properties
//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)
+ (NSArray *)ignoredProperties
{
    return @[@"image"];
}

+ (NSString *)primaryKey {
    
    return @"categoryID";
}

- (UIImage *)image {
    
    return [UIImage imageNamed:self.categoryImageFileName];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)addCateogryWithDic:(NSDictionary *)dic {
    
    return  [[self alloc] initWithDic:dic];
}

+ (NSArray *)addCategorysList {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"addCategory" ofType:@"plist"];
    NSArray *dics = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dic in dics) {
        TMAddCategory *category = [TMAddCategory addCateogryWithDic:dic];
        [arrayM addObject:category];
    }
    return arrayM;
}

@end
