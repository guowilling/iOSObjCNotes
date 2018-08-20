
#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)attrStrSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing;

+ (BOOL)isAvailable:(NSString *)aString;

@end
