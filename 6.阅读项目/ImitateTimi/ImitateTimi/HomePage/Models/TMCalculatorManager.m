
#import <Realm/Realm.h>
#import "TMCalculatorManager.h"
#import "TMBill.h"
#import "TMDataBaseManager.h"
#import "TMBooks.h"

@implementation TMCalculatorManager

+ (float)queryAllIncomeOrExpendWithMoneyType:(MoneyType)type {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isIncome = %i", type];
    RLMResults *results = [TMBill objectsWithPredicate:predicate];
    NSNumber *moneyNumber = [results sumOfProperty:@"money"];
    return moneyNumber.floatValue;
}

+ (float)queryAllIncomeOrExpendOfBookID:(NSString *)bookID moneyType:(MoneyType)type {
    
    if (bookID.length <= 0) {
        return 0;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and isIncome = %i", bookID, type];
    RLMResults *results = [TMBill objectsWithPredicate:predicate];
    NSNumber *moneyNumber = [results sumOfProperty:@"money"];
    return moneyNumber.floatValue;
}

+ (float)queryBalanceOfAllBills {
    
    RLMResults *incomeResults = [TMBill objectsWhere:@"isIncome = 1"];
    RLMResults *expendResults = [TMBill objectsWhere:@"isIncome = 0"];
    NSNumber *incomeMoney = [incomeResults sumOfProperty:@"money"];
    NSNumber *expendMoney = [expendResults sumOfProperty:@"money"];
    return incomeMoney.floatValue - expendMoney.floatValue;
}

+ (float)queryBalanceOfAllBillsWithBookID:(NSString *)bookID {
    
    if (bookID.length <= 0) {
        return 0;
    }
    RLMResults *incomeResults = [TMBill objectsWhere:@"books.booksID = %@ and isIncome = 1", bookID];
    RLMResults *expendResults = [TMBill objectsWhere:@"books.booksID = %@ and isIncome = 0", bookID];
    NSNumber *incomeMoney = [incomeResults sumOfProperty:@"money"];
    NSNumber *expendMoney = [expendResults sumOfProperty:@"money"];
    return incomeMoney.floatValue - expendMoney.floatValue;
}

+ (float)queryDayAllExpendWithBookID:(NSString *)bookID dateString:(NSString *)dateStr {
    
    if (dateStr.length <= 0 || bookID.length <= 0) {
        return 0;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and dateStr = %@ and isIncome = 0", bookID, dateStr];
    RLMResults *results = [TMBill objectsWithPredicate:predicate];
    NSNumber *moneyNumber = [results sumOfProperty:@"money"];
    return moneyNumber.floatValue;
}

+ (float)queryMonthAllIncomeOrExpendOfBookID:(NSString *)bookID dateString:(NSString *)dateStr moneyType:(MoneyType)type {
    
    if (dateStr.length <= 0 || bookID.length <= 0) {
        return 0;
    }
    NSString *subDateStr = [dateStr substringToIndex:7];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and dateStr contains %@ and isIncome = %li", bookID, subDateStr, type];
    RLMResults *results = [TMBill objectsWithPredicate:predicate];
    return [results sumOfProperty:@"money"].floatValue;
}

+ (float)queryAllMoneyWithCategotyTitleOfBookID:(NSString *)bookID categoryTitle:(NSString *)categoryTitle dateStr:(NSString *)dateStr {
    
    if (categoryTitle.length <= 0 || dateStr.length <= 0 || bookID.length <= 0) {
        return 0;
    }
    if ([dateStr isEqualToString:@"ALL"]) {
        RLMResults *results = [TMBill objectsWhere:@"books.booksID = %@ and category.categoryTitle = %@", bookID, categoryTitle];
        return [results sumOfProperty:@"money"].floatValue;
    } else {        
        RLMResults *results = [TMBill objectsWhere:@"books.booksID = %@ and category.categoryTitle = %@ and dateStr BEGINSWITH %@", bookID, categoryTitle, [dateStr substringToIndex:7]];
        return [results sumOfProperty:@"money"].floatValue;
    }
}

+ (float)calculateCategoryPercentWithBookID:(NSString *)bookID categoryTitle:(NSString *)categoryTitle dateString:(NSString *)dateStr moneyType:(MoneyType)type {

    if (categoryTitle.length <= 0 || dateStr.length <= 0 || bookID.length <= 0) {
        return 0;
    }
    float categoryMoney = [[[TMDataBaseManager defaultManager] queryBillWithBookID:bookID
                                                                beginsWithContains:dateStr
                                                                     categoryTitle:categoryTitle] sumOfProperty:@"money"].floatValue;
    RLMResults *results = [[TMDataBaseManager defaultManager] queryBillWithBookID:bookID
                                                               beginsWithContains:dateStr
                                                                        moneyType:type];
    float allMoney = [results sumOfProperty:@"money"].floatValue;
    return categoryMoney / allMoney * 100;
}

@end
