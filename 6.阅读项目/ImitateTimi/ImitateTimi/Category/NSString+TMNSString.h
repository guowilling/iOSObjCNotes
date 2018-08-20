
#import <Foundation/Foundation.h>

@interface NSString (TMNSString)

+ (NSString *)currentDateStr;

+ (NSString *)conversionYearMonthWithDateStr:(NSString *)dateStr;

+ (NSString *)readUserDefaultOfSelectedBookID;

@end
