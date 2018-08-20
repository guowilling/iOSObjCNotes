
#import <UIKit/UIKit.h>

@class RecommendModel;

@interface DetialSecondCell : UITableViewCell

@property (nonatomic ,strong) RecommendModel *model;

+ (CGFloat)getCellHeight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;

@end
