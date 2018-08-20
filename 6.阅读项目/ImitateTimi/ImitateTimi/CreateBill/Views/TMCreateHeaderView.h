
#import <UIKit/UIKit.h>

@interface TMCreateHeaderView : UIView

@property (nonatomic, copy) void(^clickCategoryName)();

- (void)categoryImageWithFileName:(NSString *)imageFileName andCategoryName:(NSString *)categoryName;

- (void)updateMoney:(NSString *)money;

- (void)animationWithBgColor:(UIColor *)color;

@end
