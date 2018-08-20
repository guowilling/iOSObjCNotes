
#import "TMCategoryButton.h"
#import "ConstDefine.h"

@implementation TMCategoryButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat x = (contentRect.size.width - kTimeLineBtnWidth)/2;
    CGFloat y = (contentRect.size.height - kTimeLineBtnWidth)/2;
    return CGRectMake(x, y, kTimeLineBtnWidth, kTimeLineBtnWidth);
}

@end
