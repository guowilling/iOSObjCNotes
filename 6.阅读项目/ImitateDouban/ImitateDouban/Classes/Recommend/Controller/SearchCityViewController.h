
#import "BaseViewController.h"

@protocol SearchCityViewControllerDelegate <NSObject>

- (void)searchCityViewControllerDidSelectCity:(NSString *)city;

@end

@interface SearchCityViewController : UIViewController

@property (nonatomic, weak) id<SearchCityViewControllerDelegate> delegate;

@end
