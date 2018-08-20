
#import "TMBaseViewController.h"

@class TMBill, TMCreateBillViewController;

@interface TMCreateBillViewController : TMBaseViewController

@property (nonatomic, strong) TMBill *bill;

@property (nonatomic, assign, getter=isUpdade) BOOL update;

@end
