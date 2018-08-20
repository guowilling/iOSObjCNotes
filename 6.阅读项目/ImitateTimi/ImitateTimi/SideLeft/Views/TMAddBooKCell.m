
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMAddBooKCell.h"
#import "ConstDefine.h"

@interface TMAddBooKCell()

@end

@implementation TMAddBooKCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        self.imageView = [UIImageView new];
        self.imageView.image = [UIImage imageNamed:@"book_cover_0"];
        [self.contentView addSubview:self.imageView];
        [self.imageView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView);
        }];
        
        self.selectedImageView = [UIImageView new];
        self.selectedImageView.image = [UIImage imageNamed:@"menu_selected_icon"];
        [self.contentView addSubview:self.selectedImageView];
        [self.selectedImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(10, 20));
            make.top.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView).offset(5);
        }];
    }
    return self;
}

@end
