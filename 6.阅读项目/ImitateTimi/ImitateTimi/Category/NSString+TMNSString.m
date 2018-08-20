
#import "NSString+TMNSString.h"

@implementation NSString (TMNSString)

+ (NSString *)currentDateStr {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)conversionYearMonthWithDateStr:(NSString *)dateStr {
    
    NSMutableString *mutableStr = [dateStr mutableCopy];
    NSRange yearRange = NSMakeRange(4, 1);
    [mutableStr replaceCharactersInRange:yearRange withString:@"年"];
    NSRange monthRange = NSMakeRange(7, 3);
    [mutableStr replaceCharactersInRange:monthRange withString:@"月"];
    return mutableStr;
}

+ (NSString *)readUserDefaultOfSelectedBookID {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"selectBookID"];
}

@end
