
#import <Foundation/Foundation.h>

@class TMCategory;

typedef NS_ENUM(NSInteger, MoneyType) {
    MoneyTypeExpend,
    MoneyTypeIncome,
    MoneyTypeAll
};

@interface TMCalculatorManager : NSObject

/**
 查询所有账本的, 所有账单的, 支出或者收入.
 */
+ (float)queryAllIncomeOrExpendWithMoneyType:(MoneyType)type;

/**
 查询指定账本的, 所有账单的, 支出或者收入.
 */
+ (float)queryAllIncomeOrExpendOfBookID:(NSString *)bookID moneyType:(MoneyType)type;

+ (float)queryBalanceOfAllBills;
+ (float)queryBalanceOfAllBillsWithBookID:(NSString *)bookID;

/**
 查询指定账本的某日总支出金额.

 @param bookID  账本ID
 @param dateStr 时间 eg: @"2016-05-18"
 @return 金额
 */
+ (float)queryDayAllExpendWithBookID:(NSString *)bookID dateString:(NSString *)dateStr;

/**
 查询指定账本的, 某月的, 支出或者收入.

 @param bookID  账本ID
 @param dateStr 时间 eg: @"2016-05-18"
 @param type    MoneyType
 @return 金额
 */
+ (float)queryMonthAllIncomeOrExpendOfBookID:(NSString *)bookID dateString:(NSString *)dateStr moneyType:(MoneyType)type;

/**
 查询指定账本的, 某类别的, 某时间点的总金额.

 @param bookID        账本ID
 @param categoryTitle 类别
 @param dateString    时间 eg: @"2016-05-18" / @"ALL"
 @return 金额
 */
+ (float)queryAllMoneyWithCategotyTitleOfBookID:(NSString *)bookID categoryTitle:(NSString *)categoryTitle dateStr:(NSString *)dateStr;

/**
 计算指定账本的, 某类别的, 某时间点的金额占总金额的百分比.

 @param bookID        账本ID
 @param categoryTitle 类别
 @param dateStr       时间 eg: @"2016-05-18" / @"ALL"
 @param type          MoneyType
 @return 百分比
 */
+ (float)calculateCategoryPercentWithBookID:(NSString *)bookID categoryTitle:(NSString *)categoryTitle dateString:(NSString *)dateStr moneyType:(MoneyType)type;

@end
