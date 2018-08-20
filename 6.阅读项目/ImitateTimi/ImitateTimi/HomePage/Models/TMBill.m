
#import "TMBill.h"
#import "TMCategory.h"
#import "TMBooks.h"

@implementation TMBill

// Specify default values for properties
//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)
+ (NSArray *)ignoredProperties
{
    return @[KBillCount, kBillSame, kBillPartSame, kBillEmpty];
}

+ (NSString *)primaryKey {
    
    return kBillPrimaryKey;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        TMCategory *category = [[TMCategory alloc] init];
        TMBooks *books = [TMBooks new];
        self.category = category;
        self.books = books;
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"billID= %@,date = %@,reMorks = %@,isIncome = %@,money = %@, category = %@, percent = %.2f, books = %@",
            self.billID,self.dateStr,self.reMarks,self.isIncome,self.money,self.category,self.category.percent,self.books];
}

+ (NSArray<NSString *> *)indexedProperties {
    
    return @[kBillDate];
}

- (void)updateDateStr:(NSString *)dateStr {
    
    if ([dateStr isEqualToString:self.dateStr]) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBill *bill = [TMBill objectsWhere:@"billID = %@",self.billID].firstObject;
    [realm transactionWithBlock:^{
        bill.dateStr = dateStr;
    }];
}

- (void)updateRemarks:(NSString *)remakrs {
    
    if ([remakrs isEqualToString:self.reMarks]) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBill *bill = [TMBill objectsWhere:@"billID = %@",self.billID].firstObject;
    [realm transactionWithBlock:^{
        bill.reMarks = remakrs;
    }];
}

- (void)updateRemarkPhoto:(NSData *)photoData {
    
    if ([photoData isEqual:self.remarkPhoto]) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBill *bill = [TMBill objectsWhere:@"billID = %@",self.billID].firstObject;
    [realm transactionWithBlock:^{
        bill.remarkPhoto = photoData;
    }];
}

- (void)updateIncome:(NSNumber<RLMBool> *)isIncome {
    
    if (isIncome.boolValue == self.isIncome.boolValue) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBill *bill = [TMBill objectsWhere:@"billID = %@",self.billID].firstObject;
    [realm transactionWithBlock:^{
        bill.isIncome = isIncome;
    }];
}

- (void)updateMoney:(NSNumber<RLMDouble> *)money {
    
    if (money.doubleValue == self.money.doubleValue) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBill *bill = [TMBill objectsWhere:@"billID = %@",self.billID].firstObject;
    [realm transactionWithBlock:^{
        bill.money = money;
    }];
}

- (void)updateCategory:(TMCategory *)category {
    
    if ([category.categoryID isEqualToString:self.category.categoryID]) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBill *bill = [TMBill objectsWhere:@"billID = %@",self.billID].firstObject;
    [realm transactionWithBlock:^{
        bill.category = category;
    }];
}

@end
