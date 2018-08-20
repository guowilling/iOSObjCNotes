
#import "NSArray+TMNSArray.h"

@implementation NSArray (TMNSArray)

+ (NSArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending {
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSRange string1Range = NSMakeRange(0, [obj2 length]);
        if (ascending) {
            return [obj1 compare:obj2 options:comparisonOptions range:string1Range locale:currentLocale];
        } else {
            return [obj2 compare:obj1 options:comparisonOptions range:string1Range locale:currentLocale];
        }
    }];
    return sortedArray;
}

+ (NSArray *)accordingToDateStrSortArray:(NSArray *)array ascending:(BOOL)ascending {
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dateStr" ascending:ascending];
    NSArray *descriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
    return sortedArray;
}

@end
