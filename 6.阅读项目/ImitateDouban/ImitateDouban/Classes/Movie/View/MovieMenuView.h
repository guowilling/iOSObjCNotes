
#import <UIKit/UIKit.h>

@protocol MovieMenuViewDelegate <NSObject>

- (void)movieMenuViewDidSelectIndex:(int)index;

@end

@interface MovieMenuView : UIView

@property (nonatomic, weak) id<MovieMenuViewDelegate> delegate;

- (void)bottomLineAnimationBtnIndex:(int)btnIndex;
    
@end
