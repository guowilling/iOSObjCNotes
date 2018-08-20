
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMSideLeftHeaderView.h"
#import "ConstDefine.h"
#import "TMSideLeftButton.h"
#import "TMCalculatorManager.h"

#define kFont [UIFont systemFontOfSize:12.5]

@interface TMSideLeftHeaderView ()

@property (nonatomic, strong) UIButton     *avatarBtn;
@property (nonatomic, strong) UILabel      *nikeNameLabel;
@property (nonatomic, strong) TMSideLeftButton *synBtn;
@property (nonatomic, strong) TMSideLeftButton *settingBtn;

@property (nonatomic, strong) UIView  *lineView;

@property (nonatomic, strong) UILabel *allIncomeLabel;
@property (nonatomic, strong) UILabel *allExpendLabel;
@property (nonatomic, strong) UILabel *allBalancLabel;

@end

@implementation TMSideLeftHeaderView

#pragma mark - Lazy Load

- (UIButton *)avatarBtn {
    
    if (!_avatarBtn) {
        _avatarBtn = [UIButton new];
        _avatarBtn.layer.cornerRadius = 40/2;
        _avatarBtn.layer.masksToBounds = YES;
        [_avatarBtn setImage:[UIImage imageNamed:@"placeholder.png"] forState:UIControlStateNormal];
        [_avatarBtn addTarget:self action:@selector(clickAvatarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarBtn;
}

- (UILabel *)nikeNameLabel {
    
    if (!_nikeNameLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:14.0f];
        _nikeNameLabel = label;
    }
    return _nikeNameLabel;
}

- (TMSideLeftButton *)settingBtn {
    
    if (!_settingBtn) {
        TMSideLeftButton *button = [[TMSideLeftButton alloc]init];
        [button setTitle:@"设置" forState:UIControlStateNormal];
        button.titleLabel.font = kFont;
        [button setImage:[UIImage imageNamed:@"menu_setting"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn = button;
    }
    return _settingBtn;
}

- (TMSideLeftButton *)synBtn {
    
    if (!_synBtn) {
        TMSideLeftButton *button = [[TMSideLeftButton alloc]init];
        [button setTitle:@"同步" forState:UIControlStateNormal];
        button.titleLabel.font = kFont;
        [button setImage:[UIImage imageNamed:@"synchronize_default"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickSynBtn:) forControlEvents:UIControlEventTouchUpInside];
        _synBtn = button;
    }
    return _synBtn;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

- (UILabel *)allIncomeLabel {
    
    if (!_allIncomeLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = kFont;
        label.numberOfLines = 2;
        _allIncomeLabel = label;
    }
    return _allIncomeLabel;
}

- (UILabel *)allExpendLabel {
    
    if (!_allExpendLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = kFont;
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        _allExpendLabel = label;
    }
    return _allExpendLabel;
}

- (UILabel *)allBalancLabel {
    
    if (!_allBalancLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = kFont;
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentRight;
        _allBalancLabel = label;
    }
    return _allBalancLabel;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        WEAKSELF
        
        [self addSubview:self.avatarBtn];
        [self.avatarBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.top.equalTo(weakSelf).offset(kStatusBarHeight + 10);
            make.left.equalTo(weakSelf).offset(20);
        }];
        
        [self addSubview:self.nikeNameLabel];
        self.nikeNameLabel.text = @"ImitateTimi";
        [self.nikeNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(100);
            make.centerY.equalTo(weakSelf.avatarBtn);
            make.left.equalTo(weakSelf.avatarBtn.right).offset(10);
        }];
        
        [self addSubview:self.settingBtn];
        [self.settingBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(30, 40));
            make.centerY.equalTo(weakSelf.avatarBtn);
            make.right.equalTo(weakSelf).offset(-20);
        }];
        
        [self addSubview:self.synBtn];
        [self.synBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf.settingBtn);
            make.centerY.equalTo(weakSelf.avatarBtn);
            make.right.equalTo(weakSelf.settingBtn.left).offset(-10);
        }];
        
        [self addSubview:self.lineView];
        [self.lineView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(SCREEN_SIZE.width);
            make.height.equalTo(0.5);
            make.top.equalTo(weakSelf.avatarBtn.bottom).offset(15);
        }];
        
        [self addSubview:self.allIncomeLabel];
        CGFloat width = SCREEN_SIZE.width - 50;
        [self.allIncomeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(width/3.5);
            make.left.equalTo(weakSelf.avatarBtn);
            make.top.equalTo(weakSelf.lineView.bottom).offset(15);
        }];
        
        [self addSubview:self.allExpendLabel];
        [self.allExpendLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.allIncomeLabel);
            make.width.lessThanOrEqualTo(weakSelf.allIncomeLabel);
        }];
        
        [self addSubview:self.allBalancLabel];
        [self.allBalancLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(weakSelf.allIncomeLabel);
            make.right.equalTo(weakSelf.settingBtn);
            make.top.equalTo(weakSelf.allIncomeLabel);
        }];
    }
    return self;
}

#pragma mark - Actions

- (void)clickAvatarBtn:(UIButton *)sender {
    
    NSLog(@"clickAvatarBtn");
}

- (void)clickSettingBtn:(TMSideLeftButton *)sender {
    
    NSLog(@"clickSettingBtn");
}

- (void)clickSynBtn:(TMSideLeftButton *)sender {
    
    NSLog(@"clickSynBtn");
}

- (void)reloadData {
    
    self.allExpendLabel.text = [NSString stringWithFormat:@"总支出\n%.2f", [TMCalculatorManager queryAllIncomeOrExpendWithMoneyType:MoneyTypeExpend]];
    self.allIncomeLabel.text = [NSString stringWithFormat:@"总收入\n%.2f", [TMCalculatorManager queryAllIncomeOrExpendWithMoneyType:MoneyTypeIncome]];
    self.allBalancLabel.text = [NSString stringWithFormat:@"总结余\n%.2f", [TMCalculatorManager queryBalanceOfAllBills]];
}

@end
