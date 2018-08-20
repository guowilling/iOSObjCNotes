
#import "TMPresentedTransition.h"
#import "ConstDefine.h"

@implementation TMPresentedTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.33;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;

    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toView.frame = CGRectOffset(finalFrame, 0, -SCREEN_SIZE.height);
 
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
