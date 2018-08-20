
#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController {
   
    id next = [self nextResponder];
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            NSLog(@"%@", next);
            return next;
        }
        next = [next nextResponder];
    }
    return nil;
}

@end
