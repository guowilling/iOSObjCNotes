
#import <UIKit/UIKit.h>

@protocol HotCityCellDelegate <NSObject>

- (void)hotCityCellDidSelectCity:(NSString *)city;

@end

@interface HotCityCell : UITableViewCell

@property (nonatomic, weak) id<HotCityCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)getCellHeight;

@end
