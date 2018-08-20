
#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@interface TMAddCategory : RLMObject

@property NSString *categoryID;

@property NSString *categoryImageFileName;

@property NSNumber<RLMBool> *isIncome;

@property (nonatomic, readonly) UIImage *image;

+ (NSArray *)addCategorysList;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TMAddCategory>
RLM_ARRAY_TYPE(TMAddCategory)
