
#import <UIKit/UIKit.h>

@class TMBill;

static NSString *TMCategoryDetailCellID = @"TMPiewCategoryDetailCell";

@interface TMCategoryDetailCell : UITableViewCell

@property (nonatomic, strong) TMBill *bill;

- (void)hiddenThreeUIView:(BOOL)hidden;

- (void)hiddenYearLabel:(BOOL)hidden;

@end
