
#import "MovieMenuView.h"

@interface MovieMenuView () {
    
    UIView *_bottomline;
}

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MovieMenuView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _buttonArray = [[NSMutableArray alloc] init];
        
        [self addButtonTitle:@"正在热映" buttonIndex:0];
        [self addButtonTitle:@"即将上映" buttonIndex:1];
        
        _bottomline = [[UIView alloc] init];
        _bottomline.frame = CGRectMake(0, 43, (SCREEN_WIDTH/2), 2);
        _bottomline.backgroundColor = TheThemeColor;
        [self addSubview:_bottomline];
    }
    return self;
}

- (void)addButtonTitle:(NSString *)title buttonIndex:(int)buttonIndex {
    
    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oneBtn.frame = CGRectMake((SCREEN_WIDTH/2)*buttonIndex, 0, (SCREEN_WIDTH/2), 45);
    [oneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [oneBtn setTitleColor:TheThemeColor forState:UIControlStateSelected];
    [oneBtn setTitle:title forState:UIControlStateNormal];
    [oneBtn setTitle:title forState:UIControlStateSelected];
    [oneBtn addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    oneBtn.tag  = buttonIndex;
    if (buttonIndex == 0) {
        oneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        oneBtn.selected = YES;
    }else{
        oneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        oneBtn.selected = NO;
    }
    [self addSubview:oneBtn];
    [_buttonArray addObject:oneBtn];
}

- (void)selectButtonAction:(UIButton *)sender {
    
    int buttonTag = (int)sender.tag;
    [self bottomLineAnimationBtnIndex:buttonTag];
    if ([_delegate respondsToSelector:@selector(movieMenuViewDidSelectIndex:)]) {
        [_delegate movieMenuViewDidSelectIndex:buttonTag];
    }
}

- (void)bottomLineAnimationBtnIndex:(int)btnIndex {
    
    UIButton *currentBtn=[_buttonArray objectAtIndex:btnIndex];
    [UIView animateWithDuration:0.25 animations:^{
        _bottomline.left = currentBtn.left;
    }];
    
    for (UIButton *oneBtn in _buttonArray) {
        if (oneBtn.tag == btnIndex) {
            oneBtn.selected = YES;
        }else{
            oneBtn.selected = NO;
        }
    }
}

@end
