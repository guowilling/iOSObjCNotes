
#import "TMBooks.h"

@implementation TMBooks

// Specify default values for properties
//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)
+ (NSArray *)ignoredProperties
{
    return @[kBookImage];
}

+ (NSString *)primaryKey {
    
    return kBooksID;
}

- (UIImage *)bookImage {
    
    return [UIImage imageNamed:self.bookImageFileName];
}

#pragma mark -

- (void)updateBookName:(NSString *)bookName {
    
    if ([self.bookName isEqualToString:bookName]) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBooks *book = [TMBooks objectsWhere:@"booksID = %@",self.booksID].firstObject;
    [realm transactionWithBlock:^{
        book.bookName = bookName;
    }];
}

- (void)updateImageIndex:(NSNumber<RLMInt> *)imageIndex {
    
    if (self.imageIndex.intValue == imageIndex.intValue) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBooks *book = [TMBooks objectsWhere:@"booksID = %@",self.booksID].firstObject;
    [realm transactionWithBlock:^{
        book.imageIndex = imageIndex;
    }];
}

- (void)updateBookImageFileName:(NSString *)bookImageFileName {
    
    if ([self.bookImageFileName isEqualToString:bookImageFileName]) return;
    RLMRealm *realm = RLMRealm.defaultRealm;
    TMBooks *book = [TMBooks objectsWhere:@"booksID = %@",self.booksID].firstObject;
    [realm transactionWithBlock:^{
        book.bookImageFileName = bookImageFileName;
    }];
}

@end
