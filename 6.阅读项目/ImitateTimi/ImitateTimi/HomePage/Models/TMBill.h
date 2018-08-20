
#import <Realm/Realm.h>

@class TMCategory, TMBooks;

static NSString * const kBillPrimaryKey  = @"billID";
static NSString * const kBillDate        = @"dateStr";
static NSString * const kBillReMarks     = @"reMarks";
static NSString * const kBillIncome      = @"iSIncome";
static NSString * const kBillMoney       = @"money";
static NSString * const kBillRemarkPhoto = @"remarkPhoto";
static NSString * const KBillCount       = @"count";
static NSString * const kBillSame        = @"same";
static NSString * const kBillPartSame    = @"partSame";
static NSString * const kBillEmpty       = @"empty";

@interface TMBill : RLMObject

/** 主键 */
@property NSString *billID;

/** 时间 */
@property NSString *dateStr;

/** 备注文字 */
@property NSString *reMarks;

/** 备注图片 */
@property NSData *remarkPhoto;

/** 收入 or 支出 */
@property NSNumber<RLMBool> *isIncome;

/** 金额 */
@property NSNumber<RLMDouble> *money;

/** 外健 */
@property TMCategory *category;

/** 外健 */
@property TMBooks *books;

/** 是否完全相同(年月日), 此属性不保存到数据库 */
@property (nonatomic, assign,getter=isSame) BOOL same;

/** 是否部分相同(年月), 此属性不保存到数据库 */
@property (nonatomic, assign,getter=isPartSame) BOOL partSame;

/** 数据是否为空, 为空时显示`新账本`, 此属性不保存到数据库 */
@property (nonatomic, assign,getter=isEmpty) BOOL empty;

/** 笔数, 此属性不保存到数据库 */
@property (nonatomic, assign) NSInteger count;

#pragma mark -

/** 修改时间 */
- (void)updateDateStr:(NSString *)dateStr;

/** 修改备注文字 */
- (void)updateRemarks:(NSString *)remakrs;

/** 修改备注图片 */
- (void)updateRemarkPhoto:(NSData *)photoData;

/** 修改类型 */
- (void)updateIncome:(NSNumber<RLMBool> *)isIncome;

/** 修改金额 */
- (void)updateMoney:(NSNumber<RLMDouble> *)money;

/** 修改外健 */
- (void)updateCategory:(TMCategory *)category;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TMBill>
RLM_ARRAY_TYPE(TMBill)
