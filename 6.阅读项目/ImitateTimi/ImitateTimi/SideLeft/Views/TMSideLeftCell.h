
#import <UIKit/UIKit.h>

@class TMBooks;

@protocol TMSideLeftCellDelegate <NSObject>

@required
- (void)sideLeftCellWithIndexPath:(NSIndexPath *)indexPath withLongPress:(UILongPressGestureRecognizer *)longPress;

@end

@interface TMSideLeftCell : UICollectionViewCell

@property (nonatomic, weak) id<TMSideLeftCellDelegate> sideCellDelegate;

@property (nonatomic, strong) TMBooks *book;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *selectedItemImageView;

@property (nonatomic, strong) UIImageView *editSelectedItemImageView;

@end
