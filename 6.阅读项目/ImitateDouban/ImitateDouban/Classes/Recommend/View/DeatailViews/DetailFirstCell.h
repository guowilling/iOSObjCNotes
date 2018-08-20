
#import <UIKit/UIKit.h>

@class RecommendModel;

@interface DetailFirstCell : UITableViewCell

@property (nonatomic, strong) RecommendModel *model;

+ (CGFloat)getCellHeight:(RecommendModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
