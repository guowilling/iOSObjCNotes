
#import <UIKit/UIKit.h>

@protocol RecommendHeadViewDelegate <NSObject>

- (void)recommendHeadViewTapAction;

@end

@interface RecommendHeadView : UIView

@property (nonatomic, copy) UILabel *currentCityLabel;

@property (nonatomic, weak) id<RecommendHeadViewDelegate> delegate;

@end
