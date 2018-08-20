
#import <UIKit/UIKit.h>

@class TMBill;

static NSString * const detailViewCellID = @"detailViewCell";

@interface TMDetailViewCell : UITableViewCell

@property (nonatomic, strong) TMBill *detailBill;

@end
