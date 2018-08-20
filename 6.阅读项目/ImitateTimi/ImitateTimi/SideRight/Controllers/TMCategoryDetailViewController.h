
#import "TMBaseViewController.h"

@class TMCalculatorManager;

@interface TMCategoryDetailViewController : TMBaseViewController

@property (nonatomic, strong) NSString *dateString;

@property (nonatomic, strong) NSString *categoryName;

@property (nonatomic, assign) MoneyType type;

@end
