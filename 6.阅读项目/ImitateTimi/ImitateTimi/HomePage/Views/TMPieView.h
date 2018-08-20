
#import <UIKit/UIKit.h>

@interface TMPieView : UIView

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *sectionColors;

@property (nonatomic, assign) CGFloat  spacing;
@property (nonatomic, assign) CGFloat  lineWidth;
@property (nonatomic, strong) UIColor *animationStrokeColor;

- (NSInteger)getLayerIndexWithPoint:(CGPoint)point;

- (void)reloadDataCompletion:(void (^)())completion;

- (void)dismissAnimationByTimeInterval:(NSTimeInterval)time;

@end
