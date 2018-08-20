
#import <UIKit/UIKit.h>

@class MovieModel;

@interface MovieCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)getCellHeight:(MovieModel *)model;

@property (nonatomic, strong) MovieModel *model;

@end
