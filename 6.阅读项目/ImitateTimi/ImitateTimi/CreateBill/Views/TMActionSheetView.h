
#import <UIKit/UIKit.h>

@interface TMActionSheetView : UIView

@property (nonatomic, copy) void (^cancelBtnBlock)();
@property (nonatomic, copy) void (^cameraBtnBlock)();
@property (nonatomic, copy) void (^albumBtnBlock)();

@end
