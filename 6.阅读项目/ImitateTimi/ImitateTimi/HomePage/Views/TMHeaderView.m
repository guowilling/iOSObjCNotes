
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMHeaderView.h"
#import "ConstDefine.h"
#import "TMCalculatorManager.h"
#import "TMPieView.h"
#import "NSString+TMNSString.h"
#import "NSArray+TMNSArray.h"

#define kCircleWidth 100

@interface TMHeaderView()

@property (nonatomic, strong) NSArray *headerBgImageFiles;

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) TMPieView   *pieView;
@property (nonatomic, strong) UILabel     *incomeLabel;
@property (nonatomic, strong) UILabel     *incomeMoneyLabel;
@property (nonatomic, strong) UILabel     *expendLabel;
@property (nonatomic, strong) UILabel     *expendMoneyLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIButton    *createBtn;

@end

@implementation TMHeaderView

#pragma mark - Lazy Load

- (NSArray *)headerBgImageFiles {
    
    if (!_headerBgImageFiles) {
        _headerBgImageFiles = @[@"background1",
                                @"background2",
                                @"background3",
                                @"background4",
                                @"background5",
                                @"background6",
                                @"background7",
                                @"background8",
                                @"background9",
                                @"background10",
                                @"background11",
                                @"background12",
                                @"background13"];
    }
    return _headerBgImageFiles;
}

- (UIImageView *)bgImageView {
    
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"background8"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (TMPieView *)pieView {
    
    if (!_pieView) {
        _pieView = [TMPieView new];
        _pieView.backgroundColor = [UIColor clearColor];
        _pieView.layer.cornerRadius = kCircleWidth/2;
        _pieView.layer.masksToBounds = YES;
        _pieView.lineWidth = 2.5;
    }
    return _pieView;
}

- (UIButton *)createBtn {
    
    if (!_createBtn) {
        _createBtn = [[UIButton alloc]init];
        [_createBtn addTarget:self action:@selector(clickCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_createBtn setImage:[UIImage imageNamed:@"circle_btn"] forState:UIControlStateNormal];
        [_createBtn setBackgroundColor:[UIColor whiteColor]];
        _createBtn.layer.cornerRadius = (kCircleWidth-30-30)/2;
        _createBtn.layer.masksToBounds = YES;
    }
    return _createBtn;
}

- (UILabel *)incomeLabel {
    
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc]init];
        _incomeLabel.backgroundColor = [UIColor clearColor];
        _incomeLabel.textColor = LineColor;
        _incomeLabel.font = [UIFont systemFontOfSize:15.0f];
        _incomeLabel.text = @"收入";
    }
    return _incomeLabel;
}

- (UILabel *)incomeMoneyLabel {
    
    if (!_incomeMoneyLabel) {
        _incomeMoneyLabel = [[UILabel alloc]init];
        _incomeMoneyLabel.backgroundColor = [UIColor clearColor];
        _incomeMoneyLabel.textColor = LineColor;
        _incomeMoneyLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _incomeMoneyLabel;
}

- (UILabel *)expendLabel {
    
    if (!_expendLabel) {
        _expendLabel = [[UILabel alloc]init];
        _expendLabel.backgroundColor = [UIColor clearColor];
        _expendLabel.textColor = LineColor;
        _expendLabel.font = [UIFont systemFontOfSize:15.0f];
        _expendLabel.text = @"支出";
    }
    return _expendLabel;
}

- (UILabel *)expendMoneyLabel {
    
    if (!_expendMoneyLabel) {
        _expendMoneyLabel = [[UILabel alloc]init];
        _expendMoneyLabel.backgroundColor = [UIColor clearColor];
        _expendMoneyLabel.textColor = LineColor;
        _expendMoneyLabel.font = [UIFont systemFontOfSize:18.0f];
        _expendMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _expendMoneyLabel;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        [self addSubview:self.bgImageView];
        [self.bgImageView makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(155);
            make.width.mas_equalTo(SCREEN_SIZE.width);
            make.left.top.and.right.equalTo(weakSelf);
        }];
        
        [self.bgImageView addSubview:self.pieView];
        [self.pieView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kCircleWidth, kCircleWidth));
            make.centerX.equalTo(weakSelf.bgImageView);
            make.centerY.equalTo(weakSelf.bgImageView.bottom);
        }];
        
        [self.bgImageView addSubview:self.createBtn];
        [self.createBtn makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.pieView).insets(UIEdgeInsetsMake(30, 30, 30, 30));
        }];
        
        [self addSubview:self.incomeLabel];
        [self.incomeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.bgImageView.bottom).offset(10);
            make.left.equalTo(weakSelf).offset(20);
        }];
        
        [self addSubview:self.incomeMoneyLabel];
        [self.incomeMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.incomeLabel).offset(20);
            make.left.equalTo(weakSelf.incomeLabel);
        }];
        
        [self addSubview:self.expendLabel];
        [self.expendLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.incomeLabel);
            make.right.equalTo(weakSelf).offset(-20);
        }];
        
        [self addSubview:self.expendMoneyLabel];
        [self.expendMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.expendLabel).offset(20);
            make.right.equalTo(weakSelf.expendLabel);
        }];
        
        [self addSubview:self.lineView];
        [self.lineView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(1, 20));
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.pieView.bottom);
        }];
    }
    return self;
}

#pragma mark - Action

- (void)clickCreateBtn:(UIButton *)sender {
    
    if ([self.headerViewDelegate respondsToSelector:@selector(didClickPieInCreateBtn)]) {
        [self.headerViewDelegate didClickPieInCreateBtn];
    }
}

#pragma mark - Public Methods

- (void)calculateMoney {
    
    self.incomeMoneyLabel.text = [NSString stringWithFormat:@"%.2f", [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                                                               moneyType:MoneyTypeIncome]];
    self.expendMoneyLabel.text = [NSString stringWithFormat:@"%.2f", [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                                                               moneyType:MoneyTypeExpend]];
    
    NSString *imageFileName = self.headerBgImageFiles[arc4random() % self.headerBgImageFiles.count];
    self.bgImageView.image = [UIImage imageNamed:imageFileName];
}

- (void)loadPieViewWithSection:(NSArray *)sections colors:(NSArray *)colors {
    
    self.pieView.sections = sections;
    self.pieView.sectionColors = colors;
    [self.pieView setNeedsDisplay];
}

- (void)animationWithCreateBtnDuration:(NSTimeInterval)time angle:(CGFloat)angle {
    
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.createBtn.transform = CGAffineTransformRotate(self.createBtn.transform, angle/500);
    } completion:^(BOOL finished) {
        [UIView  animateWithDuration:time/2 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.createBtn.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

@end
