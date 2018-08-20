
#import <UIKit/UIKit.h>

@protocol PickCityViewControllerDelegate <NSObject>

- (void)PickCityViewControllerDidSelectCity:(NSString *)city;

@end

@interface PickCityViewController : BaseViewController

@property (nonatomic, weak) id<PickCityViewControllerDelegate> delegate;

@end
