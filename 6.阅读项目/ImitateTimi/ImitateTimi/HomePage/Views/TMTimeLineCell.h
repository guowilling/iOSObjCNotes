
#import <UIKit/UIKit.h>

@class TMBill, TMCategoryButton;

static NSString * const timeLineCellID = @"timeLineCell";

@protocol TMTimeLineCellDelegate <NSObject>

@required
- (void)didClickCategoryBtnWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface TMTimeLineCell : UITableViewCell

@property (nonatomic, weak) id<TMTimeLineCellDelegate> delegate;

@property (nonatomic, strong) TMBill *timeLineBill;

@property (nonatomic, strong) NSIndexPath *indexPath; // 保存 cell 对应的 indexPath 用于获取 cell 的 rect.

@property (nonatomic, assign) BOOL isLastBill;

@property (nonatomic, assign) BOOL isDeleted;

@property (nonatomic, strong) TMCategoryButton *categoryImageBtn;

- (void)cellLabelWithHidden:(BOOL)hidden;

@end
