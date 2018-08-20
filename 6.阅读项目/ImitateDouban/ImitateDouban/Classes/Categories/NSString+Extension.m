
#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

- (CGSize)attrStrSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSDictionary *dict = @{NSFontAttributeName: font,
                           NSParagraphStyleAttributeName: paragraphStyle};
    CGSize sizeToFit = [self boundingRectWithSize:maxSize
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:dict
                                          context:nil].size;
    return sizeToFit;
}

+ (BOOL)isAvailable:(NSString *)aString {
    
    if ([aString isEqualToString:@""] || aString == nil || [aString isEqual:[NSNull null]] || [aString isKindOfClass:[NSNull class]]) {
        return YES;
    } else {
        return NO;
    }
}

@end
