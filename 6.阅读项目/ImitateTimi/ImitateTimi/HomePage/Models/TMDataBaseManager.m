
#import "TMDataBaseManager.h"
#import "TMBill.h"
#import "TMCategory.h"
#import "ConstDefine.h"
#import "TMAddCategory.h"
#import "TMBooks.h"

@interface TMDataBaseManager ()

@property (nonatomic, strong) NSArray *readCategorys;
@property (nonatomic, strong) NSArray *readAddCategorys;

@end

@implementation TMDataBaseManager

#pragma mark - Read plist

- (NSArray *)readCategorys {
    
    if (!_readCategorys) {
        _readCategorys = [TMCategory categoryList];
    }
    return _readCategorys;
}

- (NSArray *)readAddCategorys {
    
    if (!_readAddCategorys) {
        _readAddCategorys = [TMAddCategory addCategorysList];
    }
    return _readAddCategorys;
}

#pragma mark - Singleton

+ (instancetype)defaultManager {
    
    static TMDataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TMDataBaseManager alloc] init];
        [manager readCategoryFromPlistSaveToDB];
        [manager readAddCategoryFromPlistSaveToDB];
        [manager setupDefaultBooks];
    });
    return manager;
}

#pragma mark - Private Methods

// 随机生成64位字符串作为主键
- (NSString *)ret64bitString {
    
    char data[64];
    for (int x = 0; x < 64; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:64 encoding:NSUTF8StringEncoding];
}

#pragma mark - TMBill

- (NSInteger)numberOfAllBillCountWithBookID:(NSString *)bookID {
    
    if (bookID.length <= 0) {
        return 0;
    }
    return [TMBill objectsWhere:@"books.booksID = %@",bookID].count;
}

- (void)insertWithBill:(TMBill *)bill {
    
    if (bill.money.doubleValue <= 0.0) {
        return;
    }
    WEAKSELF
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        STRONGSELF
        bill.billID = [strongSelf ret64bitString];
        [TMBill createInDefaultRealmWithValue:bill];
    }];
}

- (void)deleteWithBill:(TMBill *)bill {
    
    if (bill.billID.length <= 0) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [realm deleteObject:bill];
    }];
}

- (RLMResults *)queryAllBillsWithBookID:(NSString *)bookID {
    
    if (bookID.length <=0 ) {
        return nil;
    }
    return [TMBill objectsWhere:@"books.booksID = %@", bookID];
}

- (RLMResults *)queryAllBillsWithBookID:(NSString *)bookID moneyType:(MoneyType)type {
    
    if (bookID.length <= 0) {
        return nil;
    }
    return [TMBill objectsWhere:@"books.booksID = %@ and isIncome = %li", bookID, type];
}

- (RLMResults *)queryBillWithBookID:(NSString *)bookID beginsWithContains:(NSString *)dateStr categoryTitle:(NSString *)categotyTitle {
    
    if (dateStr.length <= 0 || categotyTitle.length <= 0 || bookID.length <= 0) {
        return nil;
    }
    RLMResults *results = nil;
    if ([dateStr isEqualToString:@"ALL"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and category.categoryTitle = %@", bookID, categotyTitle];
        results = [TMBill objectsWithPredicate:predicate];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and dateStr BEGINSWITH %@ and category.categoryTitle = %@", bookID, [dateStr substringToIndex:7], categotyTitle];
        results = [TMBill objectsWithPredicate:predicate];
    }
    return results;
}

- (RLMResults *)queryBillWithBookID:(NSString *)bookID beginsWithContains:(NSString *)dateStr moneyType:(MoneyType)type {
    
    if (dateStr.length <=0 || bookID.length <=0 ) {
        return nil;
    }
    if (type == MoneyTypeAll) {
        return [self queryAllBillsWithBookID:bookID];
    }
    NSPredicate *predicate = nil;
    if ([dateStr isEqualToString:@"ALL"]) {
        predicate= [NSPredicate predicateWithFormat:@"books.booksID = %@ and isIncome = %li", bookID, type];
    } else {
        predicate= [NSPredicate predicateWithFormat:@"books.booksID = %@ and dateStr BEGINSWITH %@ and isIncome = %li", bookID, [dateStr substringToIndex:7],type];
    }
    RLMResults *results = [TMBill objectsWithPredicate:predicate];
    return results;
}

- (NSDictionary *)queryAllBillsNoneRepeatWithBookID:(NSString *)bookID {
    
    if (bookID.length <= 0) {
        return @{};
    }
    RLMResults *results = [self queryAllBillsWithBookID:bookID];
    NSMutableArray *dateStrs1M = [NSMutableArray array];
    for (TMBill *bill in results) {
        [dateStrs1M addObject:bill.dateStr];
    }
    NSMutableArray *dateStrs2M = [NSMutableArray array];
    for (NSInteger i=0; i<dateStrs1M.count; i++) {
        if (![dateStrs2M containsObject:dateStrs1M[i]]) {
            [dateStrs2M addObject:dateStrs1M[i]];
        }
    }
    NSMutableDictionary *resultsDic = [NSMutableDictionary dictionary];
    for (NSString *dateStr in dateStrs2M) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateStr == %@", dateStr];
        RLMResults *cellResults = [results objectsWithPredicate:predicate];
        [resultsDic setObject:cellResults forKey:[(TMBill *)cellResults[0] dateStr]];
    }
    return resultsDic;
}

- (NSDictionary *)queryPieDataWithBookID:(NSString *)bookID dateSting:(NSString *)dateString moneyType:(MoneyType)type {
    
    if (dateString.length <= 0 || bookID.length <= 0) {
        return @{};
    }
    NSMutableSet *mutableSet = [NSMutableSet set];
    if ([dateString isEqualToString:@"ALL"]) {
        if (type == MoneyTypeAll) {
            RLMResults *results = [self queryAllBillsWithBookID:bookID];
            for (TMBill *bill in results) {
                [mutableSet addObject:bill.category.categoryTitle];
            }
        } else {
            RLMResults *results = [self queryAllBillsWithBookID:bookID moneyType:type];
            for (TMBill *bill in results) {
                [mutableSet addObject:bill.category.categoryTitle];
            }
        }
    } else {
        RLMResults *results = [self queryBillWithBookID:bookID beginsWithContains:[dateString substringToIndex:7] moneyType:type];
        for (TMBill *bill in results) {
            [mutableSet addObject:bill.category.categoryTitle];
        }
    }
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    for (NSString *categotyTitle in mutableSet) {
        TMBill *bill = [TMBill new];
        NSUInteger count = [self numberOfCategoryCountWithBookID:bookID categoryTitle:categotyTitle dateStr:dateString];
        float money = [TMCalculatorManager queryAllMoneyWithCategotyTitleOfBookID:bookID categoryTitle:categotyTitle dateStr:dateString];
        float percent = [TMCalculatorManager calculateCategoryPercentWithBookID:bookID categoryTitle:categotyTitle dateString:dateString moneyType:type];
        NSString *imageFileName = [self queryCategoryImageWithCategotyTitle:categotyTitle];
        bill.count = count;
        bill.money = @(money);
        bill.category.percent = percent;
        bill.category.categoryTitle = categotyTitle;
        bill.category.categoryImageFileNmae = imageFileName;
        dicM[categotyTitle] = bill;
    }
    return dicM;
}

#pragma mark - TMCategory

- (RLMResults *)queryAllCategorys {
    
    return [TMCategory allObjects];
}

- (RLMResults *)queryCategorysWithPaymentType:(MoneyType)type {
    
    return [TMCategory objectsWhere:@"isIncome = %i",type];
}

- (NSInteger)numberOfAllCategoryCount {
    
    return [[TMCategory allObjects] count];
}

- (NSInteger)numberOfCategoryCountWithMoneyType:(MoneyType)type {
    
    return [TMCategory objectsWhere:@"isIncome = %i",type].count;
}

- (NSInteger)numberOfCategoryCountWithBookID:(NSString *)bookID categoryTitle:(NSString *)categoryTitle dateStr:(NSString *)dateStr {
    
    if (categoryTitle.length <= 0 || dateStr.length <= 0 || bookID.length <= 0) {
        return 0;
    }
    if ([dateStr isEqualToString:@"ALL"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and category.categoryTitle = %@", bookID, categoryTitle];
        return [TMBill objectsWithPredicate:predicate].count;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"books.booksID = %@ and category.categoryTitle = %@ and dateStr BEGINSWITH %@", bookID, categoryTitle, [dateStr substringToIndex:7]];
        return [TMBill objectsWithPredicate:predicate].count;
    }
}

- (void)insertCategory:(TMCategory *)category {
    
    if (category.categoryTitle.length <= 0) {
        return;
    }
    WEAKSELF
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        category.categoryID = [weakSelf ret64bitString];
        [TMCategory createInDefaultRealmWithValue:category];
    }];
}

- (void)deleteWithCategory:(TMCategory *)category {
    
    if (category.categoryTitle.length == 0) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [realm deleteObject:category];
    }];
}

- (NSString *)queryCategoryImageWithCategotyTitle:(NSString *)categoryTitle {
    
    if (categoryTitle.length==0) {
        return nil;
    }
    RLMResults *results = [TMCategory objectsWhere:@"categoryTitle = %@", categoryTitle];
    TMCategory *category = results[0];
    return category.categoryImageFileNmae;
}

- (void)readCategoryFromPlistSaveToDB {
    
    if ([self numberOfAllCategoryCount] ==0 ) {
        for (TMCategory *category in self.readCategorys) {
            [self insertCategory:category];
        }
    }
}

#pragma mark - TMAddCategory

- (NSInteger)numberOfAddCategoryCountWithMoneyType:(MoneyType)type {
    
    if (type == MoneyTypeAll) {
        return [TMAddCategory allObjects].count;
    }
    return [TMAddCategory objectsWhere:@"isIncome = %i", type].count;
}

- (RLMResults *)queryAddCategorysWithMoneyType:(MoneyType)type {
    
    return [TMAddCategory objectsWhere:@"isIncome = %i", type];
}

- (void)insertAddCategory:(TMAddCategory *)addCategory {
    
    WEAKSELF
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        addCategory.categoryID = [weakSelf ret64bitString];
        [TMAddCategory createInDefaultRealmWithValue:addCategory];
    }];
}

- (void)deleteWithAddCategory:(TMAddCategory *)addCategory {
    
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [realm deleteObject:addCategory];
    }];
}

- (void)readAddCategoryFromPlistSaveToDB {
    
    if ([self numberOfAddCategoryCountWithMoneyType:MoneyTypeAll] == 0 ) {
        for (TMAddCategory *addCategory in self.readAddCategorys) {
            [self insertAddCategory:addCategory];
        }
    }
}

#pragma mark - TMBooks

- (RLMResults *)queryAllBooks {
    
    return [TMBooks allObjects];
}

- (TMBooks *)queryBooksWithBookID:(NSString *)bookID {
    
    if (bookID.length <= 0) {
        return nil;
    }
    return [TMBooks objectsWhere:@"booksID = %@", bookID].firstObject;
}

- (NSInteger)numberOfAllBooksCount {
    
    return [TMBooks allObjects].count;
}

- (void)insertBooks:(TMBooks *)book {
    
    WEAKSELF
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        book.booksID = [weakSelf ret64bitString];
        [TMBooks createInDefaultRealmWithValue:book];
    }];
}

- (void)deleteBookWithBookID:(NSString *)bookID {
    
    if (bookID.length <= 0) {
        return;
    }
    RLMResults *results = [self queryAllBillsWithBookID:bookID];
    TMBooks *book = [self queryBooksWithBookID:bookID];
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [realm deleteObjects:results];
        [realm deleteObject:book];
    }];
}

- (NSInteger)bookIndexWithBookID:(NSString *)bookID {
    
    if (bookID.length <= 0) {
        return -1;
    }
    for (NSInteger i = 0; i < [TMBooks allObjects].count; i++) {
        TMBooks *theBook = [TMBooks allObjects][i];
        if ([theBook.booksID isEqualToString:bookID]) {
            return i;
        }
    }
    return -1;
}

- (void)setupDefaultBooks {
    
    if ([self numberOfAllBooksCount] !=0 ) {
        return;
    }
    TMBooks *book = [TMBooks new];
    book.bookName = @"日常账本";
    book.bookImageFileName = @"book_cover_0";
    book.imageIndex = @0;
    [self insertBooks:book];
    [self setupUserDefaults];
}

- (void)setupUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    TMBooks *book = [TMBooks allObjects].firstObject;
    [defaults setObject:book.booksID forKey:@"selectBookID"];
    [defaults synchronize];
}

@end
