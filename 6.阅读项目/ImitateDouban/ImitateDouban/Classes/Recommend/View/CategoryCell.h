
#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell

+ (CGFloat)getCellHeight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

@end
