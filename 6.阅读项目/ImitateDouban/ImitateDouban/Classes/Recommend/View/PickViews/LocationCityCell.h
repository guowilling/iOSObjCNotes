
#import <UIKit/UIKit.h>

@protocol LocationCityCellDelegate <NSObject>

- (void)locationCityCellDidSelectCity:(NSString *)city;

@end

@interface LocationCityCell : UITableViewCell

@property (nonatomic, weak) id<LocationCityCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)getCellHeight;

@end
