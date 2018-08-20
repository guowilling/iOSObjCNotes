
#import "TMCategoryCollectionViewFlowLayout.h"
#import "ConstDefine.h"

@implementation TMCategoryCollectionViewFlowLayout

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(kCollectionCellWidth, kCollectionCellWidth);
        self.minimumInteritemSpacing = 0;
        //self.minimumLineSpacing=10;
        //[self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}

@end
