
#import <Foundation/Foundation.h>

@class TMBill;

@interface NSArray (TMNSArray)

+ (NSArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending;
+ (NSArray *)accordingToDateStrSortArray:(NSArray *)array ascending:(BOOL)ascending;

@end
