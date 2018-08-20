
#import <UIKit/UIKit.h>

@interface CityCell : UITableViewCell

@property (nonatomic ,strong) NSString *cityName;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)getCellHeight;

@end
