
#import "TMSideLeftButton.h"
#import "ConstDefine.h"

#define kImageWidth 52/2

@implementation TMSideLeftButton

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textColor = LineColor;
        [self setTitleColor:LineColor forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat x = (contentRect.size.width - kImageWidth)/2;
    return CGRectMake(x, 0, kImageWidth, kImageWidth);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHeight = contentRect.size.height-kImageWidth;
    return CGRectMake(0, kImageWidth + 3, titleWidth, titleHeight);
}

@end
