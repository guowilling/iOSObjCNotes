
#import "TMLabel.h"

@implementation TMLabel

- (CGSize)intrinsicContentSize {
    
    CGSize size = [super intrinsicContentSize];
    size.width += 5;
    return size;
}

@end
