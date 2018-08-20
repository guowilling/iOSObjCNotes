
#import <UIKit/UIKit.h>

@protocol InlandCityViewControllerDelegate <NSObject>

- (void)inlandCityViewControllerDidSelectCity:(NSString *)city;

@end

@interface InlandCityViewController : BaseViewController

@property (nonatomic, weak) id<InlandCityViewControllerDelegate> delegate;

@end
