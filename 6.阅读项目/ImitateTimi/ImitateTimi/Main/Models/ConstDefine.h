
#ifndef ConstDefine_h
#define ConstDefine_h

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define LineColor [UIColor colorWithWhite:0.800 alpha:1.000] // 时光轴线条颜色

#define LinebgColor [UIColor colorWithWhite:0.986 alpha:1.000] // 时光轴背景颜色

#define kSelectColor [UIColor colorWithRed:0.907 green:0.454 blue:0.000 alpha:1.000]

#define kTimeLineBtnWidth 30.0 // 时光轴按钮宽度

#define kAnimationDuration .2f // 时光轴动画时间

#define kBlankWidth ((SCREEN_SIZE.width - kTimeLineBtnWidth)/2/2 + (SCREEN_SIZE.width - kTimeLineBtnWidth)/2/2/3) // 时光轴空白区域宽度

#define kNavigationBarMaxY CGRectGetMaxY(self.navigationController.navigationBar.frame)

#define kHeaderViewHeight 220 // 时光轴顶部视图高度

#define kRectY self.receiveRect.origin.y + kHeaderViewHeight + 2

#define kMaxNBY CGRectGetMaxY(self.navigationController.navigationBar.frame) + CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame)

#define kCollectionCellWidth SCREEN_SIZE.width/6

#define kCollectionFrame CGRectMake(0, kMaxNBY + kCreateBillHeaderViewFrame.size.height, SCREEN_SIZE.width, (kCollectionCellWidth + 10) * 4)

#define kPageControllerFrame CGRectMake(0, kMaxNBY + kCollectionFrame.size.height + kCreateBillHeaderViewFrame.size.height, SCREEN_SIZE.width, 30)

#define kCreateBillHeaderViewFrame CGRectMake(0, kMaxNBY, SCREEN_SIZE.width, 60)

#define kHeaderCategoryImageCenter CGPointMake(30, (kCreateBillHeaderViewFrame.size.height - 48.5)/2 + kMaxNBY);

#endif
