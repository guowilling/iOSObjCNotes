
#import <Foundation/Foundation.h>

@interface AppTools : NSObject

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSString *)formatCount:(NSString *)count;

+ (NSString *)formatRating:(NSString *)rating;

+ (NSString *)formatCountstr:(NSString *)countStr;

+ (NSMutableAttributedString *)setLineSpacingWith:(NSString *)contentText lineSpacing:(CGFloat)lineSpacing;

@end
