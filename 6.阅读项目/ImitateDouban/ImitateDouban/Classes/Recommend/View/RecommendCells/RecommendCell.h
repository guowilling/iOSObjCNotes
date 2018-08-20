
#import <UIKit/UIKit.h>

@class RecommendModel;

@interface RecommendCell : UITableViewCell

+ (CGFloat)getCellHeight:(RecommendModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) RecommendModel *model;

@end
