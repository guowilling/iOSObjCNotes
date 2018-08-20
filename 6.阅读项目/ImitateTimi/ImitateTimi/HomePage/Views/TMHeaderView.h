
#import <UIKit/UIKit.h>

@protocol TMHeaderViewDelegate <NSObject>

@optional
- (void)didClickPieInCreateBtn;

@end

@interface TMHeaderView : UIView

@property (nonatomic, weak) id<TMHeaderViewDelegate> headerViewDelegate;

- (void)calculateMoney;

- (void)loadPieViewWithSection:(NSArray *)sections colors:(NSArray *)colors;

- (void)animationWithCreateBtnDuration:(NSTimeInterval)time angle:(CGFloat)angle;

@end
