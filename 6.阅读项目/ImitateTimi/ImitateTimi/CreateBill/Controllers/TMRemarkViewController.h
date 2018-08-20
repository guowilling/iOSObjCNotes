
#import "TMBaseViewController.h"

@class TMBill;

@interface TMRemarkViewController : TMBaseViewController

@property (nonatomic, strong) TMBill *bill;

@property (nonatomic, copy) void (^passbackBlock)(NSString *remarks,NSData *photoData);

@end
