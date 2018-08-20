
#import <UIKit/UIKit.h>

@protocol OutlandCityViewControllerDelegate <NSObject>

- (void)outlandCityViewControllerDidSelectCity:(NSString *)city;

@end

@interface OutlandCityViewController : BaseViewController

@property (nonatomic, weak) id<OutlandCityViewControllerDelegate> delegate;

@end
