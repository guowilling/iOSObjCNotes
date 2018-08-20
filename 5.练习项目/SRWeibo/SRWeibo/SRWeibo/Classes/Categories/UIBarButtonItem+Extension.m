
#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action norImage:(NSString *)image highImage:(NSString *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = CGSizeMake(btn.currentBackgroundImage.size.width * 1.0, btn.currentBackgroundImage.size.height * 1.0);
//    btn.backgroundColor = SRRandomColor;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
