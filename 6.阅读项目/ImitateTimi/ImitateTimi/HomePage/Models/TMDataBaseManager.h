
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "TMCalculatorManager.h"

@class TMBill, TMCategory, TMAddCategory, TMBooks;

// 如果模型存在主键, 直接通过 transactionWithBlock 更新数据即可.

@interface TMDataBaseManager : NSObject

+ (instancetype)defaultManager;

#pragma mark - TMBill

/**
 查询指定账本的总账单数量.
 */
- (NSInteger)numberOfAllBillCountWithBookID:(NSString *)bookID;

- (RLMResults *)queryAllBillsWithBookID:(NSString *)bookID;
- (RLMResults *)queryAllBillsWithBookID:(NSString *)bookID moneyType:(MoneyType)type;
- (RLMResults *)queryBillWithBookID:(NSString *)bookID beginsWithContains:(NSString *)dateStr moneyType:(MoneyType)type;
- (RLMResults *)queryBillWithBookID:(NSString *)bookID beginsWithContains:(NSString *)dateStr categoryTitle:(NSString *)categotyTitle;

- (void)insertWithBill:(TMBill *)bill;
- (void)deleteWithBill:(TMBill *)bill;

/**
 查询指定账本的所有账单并合并相同时间的账单.
 */
- (NSDictionary *)queryAllBillsNoneRepeatWithBookID:(NSString *)bookID;

- (NSString *)queryCategoryImageWithCategotyTitle:(NSString *)categoryTitle;

- (NSDictionary *)queryPieDataWithBookID:(NSString *)bookID dateSting:(NSString *)dateString moneyType:(MoneyType)type;

#pragma mark - TMCategory

- (NSInteger)numberOfAllCategoryCount;
- (NSInteger)numberOfCategoryCountWithMoneyType:(MoneyType)type;
- (NSInteger)numberOfCategoryCountWithBookID:(NSString *)bookID categoryTitle:(NSString *)categoryTitle dateStr:(NSString *)dateStr;

- (RLMResults *)queryAllCategorys;
- (RLMResults *)queryCategorysWithPaymentType:(MoneyType)type;

- (void)insertCategory:(TMCategory *)category;

#pragma mark - TMAddCategory

- (NSInteger)numberOfAddCategoryCountWithMoneyType:(MoneyType)type;

- (RLMResults *)queryAddCategorysWithMoneyType:(MoneyType)type;

- (void)deleteWithAddCategory:(TMAddCategory *)addCategory;

#pragma mark - TMBooks

- (RLMResults *)queryAllBooks;

- (TMBooks *)queryBooksWithBookID:(NSString *)bookID;

- (NSInteger)numberOfAllBooksCount;

- (NSInteger)bookIndexWithBookID:(NSString *)bookID;

- (void)insertBooks:(TMBooks *)book;
- (void)deleteBookWithBookID:(NSString *)bookID;

@end
