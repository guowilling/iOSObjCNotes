
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMAddCategoryCollectionViewCell.h"
#import "ConstDefine.h"

@implementation TMAddCategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        self.imageView = [UIImageView new];
        [self.contentView addSubview:self.imageView];
        [self.imageView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView);
        }];
    }
    return self;
}

@end
