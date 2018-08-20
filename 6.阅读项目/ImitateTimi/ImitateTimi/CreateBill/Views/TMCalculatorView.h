
#import <UIKit/UIKit.h>

@interface TMCalculatorView : UIView

@property (nonatomic, copy) void (^passValuesBlock)(NSString *string);

@property (nonatomic, copy) void (^didClickDateBtnBlock)();
@property (nonatomic, copy) void (^didClickSaveBtnBlock)();
@property (nonatomic, copy) void (^didClickRemarkBtnBlock)();

- (void)setTimeWithTimeString:(NSString *)timeString;

@end
