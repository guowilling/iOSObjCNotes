
#import <UIKit/UIKit.h>

@class DetailMovieModel;

typedef void (^CellBlock)(NSIndexPath *indexPath);

@interface MovieDetailIntroCell : UITableViewCell

@property (nonatomic, copy) CellBlock block;

@property (nonatomic, strong) UIButton *unfoldBtn;

@property (nonatomic, strong) NSIndexPath *indexPath;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)heightWithModel:(DetailMovieModel *)model;

- (void)configCellWithModel:(DetailMovieModel *)model;

@end
