
#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

static NSString * const kCTID            = @"categoryID";
static NSString * const kCTTitle         = @"categoryTitle";
static NSString * const kCTImage         = @"categoryImage";
static NSString * const kCTImageFileName = @"categoryImageFileNmae";
static NSString * const kCTPercent       = @"percent";
static NSString * const kCTIncome        = @"isIncome";

@interface TMCategory : RLMObject

/** 主键 */
@property NSString *categoryID;

/** 类别图片名称 */
@property NSString *categoryImageFileNmae;

/** 类别标题 */
@property NSString *categoryTitle;

//@property NSNumber<RLMFloat> *percent;
/** 百分比, 此属性不保存到数据库 */
@property (nonatomic, assign) float percent;

/** 收入 or 支出 */
@property NSNumber<RLMBool> *isIncome;

/** 类别图片 */
@property (nonatomic,readonly) UIImage *categoryImage;

#pragma mark -

+ (NSArray *)categoryList;

- (void)modifyCategoryTitle:(NSString *)categoryTitle;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TMCategory>
RLM_ARRAY_TYPE(TMCategory)
