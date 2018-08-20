
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)narmalImage higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action;

@end
