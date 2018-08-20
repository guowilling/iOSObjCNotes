
#import "UIView+i7Rotate360.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (i7Rotate360)

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode {
    
	CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
	theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,1,0)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,1,0)], nil];
	theAnimation.cumulative = YES;
	theAnimation.duration = aDuration;
	theAnimation.repeatCount = aRepeatCount;
	theAnimation.removedOnCompletion = YES;
	
	if (aMode == i7Rotate360TimingModeEaseInEaseOut) {
		theAnimation.timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];
	}
	[self.layer addAnimation:theAnimation forKey:@"transform"];
}

- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode {
    
	[self rotate360WithDuration:aDuration repeatCount:1 timingMode:aMode];
}

- (void)rotate360WithDuration:(CGFloat)aDuration {
    
	[self rotate360WithDuration:aDuration repeatCount:1 timingMode:i7Rotate360TimingModeEaseInEaseOut];
}

@end
