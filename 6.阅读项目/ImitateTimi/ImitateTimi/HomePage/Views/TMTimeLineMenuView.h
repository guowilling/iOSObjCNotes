
#import <UIKit/UIKit.h>

@class TMTimeLineCell;

@protocol TMTimeLineMenuViewDelegate <NSObject>

@required
- (void)hiddenCellLabelWithBool:(BOOL)hidden;
- (void)clickDeleteBtn;
- (void)clickUpdateBtn;

@end

@interface TMTimeLineMenuView : UIView

@property (nonatomic, weak) id<TMTimeLineMenuViewDelegate> timeLineMenuDelegate;

@property (nonatomic, strong) UIImage *currentImage;

- (void)showTimeLineMenuViewWithRect:(CGRect)receiveRect;

- (void)dismiss;

@end
