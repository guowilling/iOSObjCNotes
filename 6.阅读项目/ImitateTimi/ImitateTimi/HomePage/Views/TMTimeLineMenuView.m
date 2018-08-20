
#import "TMTimeLineMenuView.h"
#import "ConstDefine.h"
#import "TMTimeLineCell.h"

#define kDefaulBtnFrame(y) CGRectMake((SCREEN_SIZE.width - kTimeLineBtnWidth) / 2, y, kTimeLineBtnWidth, kTimeLineBtnWidth)

@interface TMTimeLineMenuView()

@property (nonatomic, strong) UIButton *categoryBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *updateBtn;
@property (nonatomic, assign) CGRect receiveRect;

@end

@implementation TMTimeLineMenuView

#pragma mark - Lazy Load

- (UIButton *)deleteBtn {
    
    if (!_deleteBtn) {
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"item_delete"] forState:UIControlStateNormal];
        _deleteBtn = button;
    }
    return _deleteBtn;
}

- (UIButton *)updateBtn {
    
    if (!_updateBtn) {
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(clickUpdateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"item_edit"] forState:UIControlStateNormal];
        _updateBtn = button;
    }
    return _updateBtn;
}

- (UIButton *)categoryBtn {
    
    if (!_categoryBtn) {
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        _categoryBtn = button;
    }
    return _categoryBtn;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.deleteBtn];
        [self addSubview:self.updateBtn];
        [self addSubview:self.categoryBtn];
    }
    return self;
}

#pragma mark - Actions

- (void)clickDeleteBtn:(UIButton *)sender {
    
    if ([self.timeLineMenuDelegate respondsToSelector:@selector(clickDeleteBtn)]) {
        [self.timeLineMenuDelegate clickDeleteBtn];
    }
}

- (void)clickUpdateBtn:(UIButton *)sender {

    if ([self.timeLineMenuDelegate respondsToSelector:@selector(clickUpdateBtn)]) {
        [self.timeLineMenuDelegate clickUpdateBtn];
    }
}

- (void)clickCategoryBtn:(UIButton *)sender {

    [self dismiss];
}

#pragma mark - Public Methods

- (void)showTimeLineMenuViewWithRect:(CGRect)receiveRect {
    
    _receiveRect = receiveRect;
    
    [self.categoryBtn setImage:self.currentImage forState:UIControlStateNormal];

    if ([self.timeLineMenuDelegate respondsToSelector:@selector(hiddenCellLabelWithBool:)]) {
        [self.timeLineMenuDelegate hiddenCellLabelWithBool:YES];
    }
    
    receiveRect.origin.y += 64-kTimeLineBtnWidth-5;
    CGRect btnRect = kDefaulBtnFrame(receiveRect.origin.y);
    self.deleteBtn.frame = btnRect;
    self.updateBtn.frame = btnRect;
    self.categoryBtn.frame = btnRect;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.deleteBtn.frame = CGRectMake((SCREEN_SIZE.width-kTimeLineBtnWidth)/2 - kBlankWidth , btnRect.origin.y, kTimeLineBtnWidth, kTimeLineBtnWidth);
        self.updateBtn.frame = CGRectMake((SCREEN_SIZE.width-kTimeLineBtnWidth)/2 + kBlankWidth , btnRect.origin.y, 30, 30);
        [self.superview bringSubviewToFront:self];
    } completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGRect rect = self.receiveRect;
        rect.origin.y += 64-kTimeLineBtnWidth-5;
        self.deleteBtn.frame = CGRectMake((SCREEN_SIZE.width-kTimeLineBtnWidth)/2 , rect.origin.y, kTimeLineBtnWidth, kTimeLineBtnWidth);
        self.updateBtn.frame = CGRectMake((SCREEN_SIZE.width-kTimeLineBtnWidth)/2 , rect.origin.y, kTimeLineBtnWidth, kTimeLineBtnWidth);
    } completion:^(BOOL finished) {
        [self.superview sendSubviewToBack:self];
        [self.categoryBtn setImage:nil forState:UIControlStateNormal];
        //self.receiveRect = CGRectZero;
        
        if ([self.timeLineMenuDelegate respondsToSelector:@selector(hiddenCellLabelWithBool:)]) {
            [self.timeLineMenuDelegate hiddenCellLabelWithBool:NO];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //[self dismiss];
}

@end
