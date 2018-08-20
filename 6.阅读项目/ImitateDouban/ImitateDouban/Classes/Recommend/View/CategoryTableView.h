
#import <UIKit/UIKit.h>

@protocol CategoryTableViewDelegate <NSObject>

- (void)categoryTableViewDidSelectCategory:(NSString *)category;

@end

@interface CategoryTableView : UIView

@property (nonatomic, weak) id<CategoryTableViewDelegate> delegate;

@end
