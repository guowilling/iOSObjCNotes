
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "TMTimeLineCell.h"
#import "ConstDefine.h"
#import <Masonry.h>
#import "TMBill.h"
#import "TMCategory.h"
#import "TMCalculatorManager.h"
#import "TMCategoryButton.h"
#import "TMBooks.h"

#define kTimePointViewWidth 6
#define kCategoryNameLabelSize CGSizeMake(30, 25)
#define kMoneyLabelWidth (SCREEN_SIZE.width - kTimeLineBtnWidth) / 2 - 30 - 10
#define kPhotoWidth 35
#define kRemainingWidth kBlankWidth + 30 + 5 + 5

#define kRemarkFont 10.0f
#define kMoneyFont  14.0f
#define kTextFont   12.0f

@interface TMTimeLineCell()

@property (nonatomic, strong) UIView   *timePointView;
@property (nonatomic, strong) UILabel  *timeLabel;
@property (nonatomic, strong) UILabel  *moneyLabel;
@property (nonatomic, strong) UIView   *lineView;

@property (nonatomic, strong) UILabel  *leftCategoryNameLabel;
@property (nonatomic, strong) UILabel  *leftMoneyLabel;
@property (nonatomic, strong) UILabel  *leftRemarkLabel;
@property (nonatomic, strong) UIButton *leftRemarkPhotoBtn;

@property (nonatomic, strong) UILabel  *rightCategoryNameLabel;
@property (nonatomic, strong) UILabel  *rightMoneyLabel;
@property (nonatomic, strong) UILabel  *rightRemarkLabel;
@property (nonatomic, strong) UIButton *rightRemarkPhotoBtn;

@end

@implementation TMTimeLineCell

- (void)dealloc {
    
    self.timeLineBill = nil;
}

#pragma mark - Lazy Load

- (UIView *)timePointView {
    
    if (!_timePointView) {
        _timePointView = [UIView new];
        _timePointView.backgroundColor = LineColor;
        _timePointView.layer.cornerRadius = kTimePointViewWidth/2;
        _timePointView.layer.masksToBounds = YES;
    }
    return _timePointView;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kTextFont];
        label.textAlignment = NSTextAlignmentRight;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kTextFont];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

- (TMCategoryButton *)categoryImageBtn {
    
    if (!_categoryImageBtn) {
        TMCategoryButton *button = [[TMCategoryButton alloc]init];
        [button addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        _categoryImageBtn = button;
    }
    return _categoryImageBtn;
}

- (UILabel *)leftCategoryNameLabel {
    
    if (!_leftCategoryNameLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kMoneyFont];
        label.textAlignment = NSTextAlignmentRight;
        [self setLabelContentPriority:label];
        _leftCategoryNameLabel = label;
    }
    return _leftCategoryNameLabel;
}

- (UILabel *)leftMoneyLabel {
    
    if (!_leftMoneyLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kMoneyFont];
        label.textAlignment = NSTextAlignmentRight;
        [self setLabelContentPriority:label];
        _leftMoneyLabel = label;
    }
    return _leftMoneyLabel;
}

- (UILabel *)leftRemarkLabel {
    
    if (!_leftRemarkLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kRemarkFont];
        label.textAlignment = NSTextAlignmentRight;
        [self setLabelContentPriority:label];
        _leftRemarkLabel = label;
    }
    return _leftRemarkLabel;
}

- (UIButton *)leftRemarkPhotoBtn {
    
    if (!_leftRemarkPhotoBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(clickLeftRemarkPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        _leftRemarkPhotoBtn = button;
    }
    return _leftRemarkPhotoBtn;
}

- (UILabel *)rightCategoryNameLabel {
    
    if (!_rightCategoryNameLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kMoneyFont];
        label.textAlignment = NSTextAlignmentLeft;
        [self setLabelContentPriority:label];
        _rightCategoryNameLabel = label;
    }
    return _rightCategoryNameLabel;
}

- (UILabel *)rightMoneyLabel {
    
    if (!_rightMoneyLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kMoneyFont];
        label.textAlignment = NSTextAlignmentLeft;
        [self setLabelContentPriority:label];
        _rightMoneyLabel = label;
    }
    return _rightMoneyLabel;
}

- (UILabel *)rightRemarkLabel {
    
    if (!_rightRemarkLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:kRemarkFont];
        [self setLabelContentPriority:label];
        _rightRemarkLabel = label;
    }
    return _rightRemarkLabel;
}

- (UIButton *)rightRemarkPhotoBtn {
    
    if (!_rightRemarkPhotoBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(clickRightRemarkPhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightRemarkPhotoBtn = button;
    }
    return _rightRemarkPhotoBtn;
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    // 此处 cell 的 height 是 44, layoutSubviews 方法里的 height 才是准确的.
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // label 可以不用设置 size, label 会根据内容调用系统的 intrinsicContentSize 方法得到值.
        self.backgroundColor = LinebgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WEAKSELF
        
        [self.contentView addSubview:self.timePointView];
        [self.timePointView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kTimePointViewWidth, kTimePointViewWidth));
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(9);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.timePointView);
            make.right.equalTo(weakSelf.timePointView.left).offset(-3);
        }];
        
        [self.contentView addSubview:self.moneyLabel];
        [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.timePointView);
            make.left.equalTo(weakSelf.timePointView.right).offset(3);
        }];
        
        [self.contentView addSubview:self.lineView];
        self.lineView.frame = CGRectMake((SCREEN_SIZE.width - 1)/2, 0, 1, self.contentView.bounds.size.height);
        
        [self.contentView addSubview:self.categoryImageBtn];
        [self.categoryImageBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kTimeLineBtnWidth + 10, kTimeLineBtnWidth + 10));
            make.centerX.equalTo(weakSelf.contentView);
            make.bottom.equalTo(weakSelf.contentView);
        }];
        
        [self.contentView addSubview:self.leftCategoryNameLabel];
        [self.leftCategoryNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(weakSelf.categoryImageBtn.leading).mas_offset(-5);
            make.centerY.equalTo(weakSelf.categoryImageBtn);
        }];
        
        [self.contentView addSubview:self.leftMoneyLabel];
        [self.leftMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.leftCategoryNameLabel.leading).offset(-3);
            make.top.equalTo(weakSelf.leftCategoryNameLabel);
        }];
        
        [self.contentView addSubview:self.leftRemarkLabel];
        [self.leftRemarkLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.leftCategoryNameLabel.bottom);
            make.right.equalTo(weakSelf.leftCategoryNameLabel);
            make.left.equalTo(weakSelf);
            
        }];
        
        [self.contentView addSubview:self.leftRemarkPhotoBtn];
        [self.leftRemarkPhotoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kPhotoWidth, kPhotoWidth));
            make.right.equalTo(weakSelf.categoryImageBtn.left).offset(-5);
            make.centerY.equalTo(weakSelf.categoryImageBtn);
        }];
        
        [self.contentView addSubview:self.rightCategoryNameLabel];
        [self.rightCategoryNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.categoryImageBtn.trailing).offset(5);
            make.centerY.equalTo(weakSelf.categoryImageBtn);
        }];
        
        [self.contentView addSubview:self.rightMoneyLabel];
        [self.rightMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.rightCategoryNameLabel.trailing).offset(5);
            make.top.equalTo(weakSelf.rightCategoryNameLabel);
        }];
        
        [self.contentView addSubview:self.rightRemarkLabel];
        [self.rightRemarkLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.rightCategoryNameLabel.bottom);
            make.left.equalTo(weakSelf.rightCategoryNameLabel);
            make.right.equalTo(weakSelf);
        }];
        
        [self.contentView addSubview:self.rightRemarkPhotoBtn];
        [self.rightRemarkPhotoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf.leftRemarkPhotoBtn);
            make.left.equalTo(weakSelf.categoryImageBtn.right).offset(5);
            make.centerY.equalTo(weakSelf.categoryImageBtn);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!self.isLastBill) {
        self.lineView.frame = CGRectMake((SCREEN_SIZE.width - 1)/2, 0, 1, self.contentView.bounds.size.height);
    } else {
        self.lineView.frame = CGRectMake((SCREEN_SIZE.width - 1)/2, 0, 1, self.contentView.bounds.size.height-5);
    }
    
    if (_timeLineBill.isEmpty) {
        self.lineView.frame = CGRectMake((SCREEN_SIZE.width - 1)/2, 0, 1, 9);
    }
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    // 重置数据, 防止滚动重用 cell 时出现数据错乱.
    self.timeLineBill = nil;
    self.categoryImageBtn.imageView.image = nil;
    [self.categoryImageBtn setImage:nil forState:UIControlStateNormal];
    self.leftCategoryNameLabel.text = nil;
    self.leftMoneyLabel.text = nil;
    self.leftRemarkLabel.text = nil;
    self.rightCategoryNameLabel.text = nil;
    self.rightMoneyLabel.text = nil;
    self.rightRemarkLabel.text = nil;
    self.isLastBill = NO;
}

- (void)setLabelContentPriority:(UILabel *)label {
    
    // 内容不被压缩
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // 内容不被拉宽
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

#pragma mark - Actions

- (void)clickCategoryBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickCategoryBtnWithIndexPath:)]) {
        [self.delegate didClickCategoryBtnWithIndexPath:self.indexPath];
    }
}

- (void)clickLeftRemarkPhotoBtn:(UIButton *)sender {
    
    NSLog(@"click LeftRemarkPhotoBtn");
}

- (void)clickRightRemarkPhotoBtn:(UIButton *)sender {
    
    NSLog(@"click RightRemarkPhotoBtn");
}

#pragma mark - Public Methods

- (void)cellLabelWithHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.leftCategoryNameLabel.hidden = hidden;
        self.leftMoneyLabel.hidden = hidden;
        self.rightCategoryNameLabel.hidden = hidden;
        self.rightMoneyLabel.hidden = hidden;
        self.leftRemarkLabel.hidden = hidden;
        self.rightRemarkLabel.hidden = hidden;
        
        if (self.isDeleted) {
            self.isDeleted = NO;
            _timeLineBill = nil;
            return;
        }
        if (!_timeLineBill.remarkPhoto) {
            return;
        }
        if (_timeLineBill.isIncome.boolValue) {
            if (self.rightRemarkPhotoBtn.isHidden) {
                self.rightRemarkPhotoBtn.hidden = NO;
            } else {
                self.rightRemarkPhotoBtn.hidden = YES;
            }
        } else {
            if (self.leftRemarkPhotoBtn.isHidden) {
                self.leftRemarkPhotoBtn.hidden = NO;
            } else {
                self.leftRemarkPhotoBtn.hidden = YES;
            }
        }
    } completion:nil];
}

- (void)setTimeLineBill:(TMBill *)timeLineBill {
    
    if (!timeLineBill) {
        return;
    }
    
    _timeLineBill = timeLineBill;
    
    self.timeLabel.text = _timeLineBill.dateStr;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [TMCalculatorManager queryDayAllExpendWithBookID:_timeLineBill.books.booksID
                                                                                                     dateString:_timeLineBill.dateStr]];
    
    [self hiddenRemarkPhoto:YES];
    [self.categoryImageBtn setImage:nil forState:UIControlStateNormal];
    
    if (_timeLineBill.isEmpty) {
        return;
    }
    
    if (_timeLineBill.category.categoryImage) {
        [self.categoryImageBtn setImage:_timeLineBill.category.categoryImage forState:UIControlStateNormal];
    }
    
    UIImage *remarkPhoto = [UIImage imageWithData:_timeLineBill.remarkPhoto];
    if (_timeLineBill.isIncome.boolValue) {
        self.leftMoneyLabel.text = [NSString stringWithFormat:@"%.2f",_timeLineBill.money.floatValue];
        self.leftCategoryNameLabel.text = _timeLineBill.category.categoryTitle;
        self.leftRemarkLabel.text = _timeLineBill.reMarks;
        if (_timeLineBill.remarkPhoto) {
            self.rightRemarkPhotoBtn.hidden = NO;
            [self.rightRemarkPhotoBtn setImage:remarkPhoto forState:UIControlStateNormal];
        }
    } else {
        self.rightCategoryNameLabel.text = _timeLineBill.category.categoryTitle;
        self.rightMoneyLabel.text = [NSString stringWithFormat:@"%.2f",_timeLineBill.money.floatValue];
        self.rightRemarkLabel.text = _timeLineBill.reMarks;
        if (_timeLineBill.remarkPhoto) {
            self.leftRemarkPhotoBtn.hidden = NO;
            [self.leftRemarkPhotoBtn setImage:remarkPhoto forState:UIControlStateNormal];
        }
    }

    [self hiddenUIControl:_timeLineBill.isSame];
}

- (void)hiddenRemarkPhoto:(BOOL)hidden {
    
    self.leftRemarkPhotoBtn.hidden = hidden;
    self.rightRemarkPhotoBtn.hidden = hidden;
    [self.leftRemarkPhotoBtn setImage:nil forState:UIControlStateNormal];
    [self.rightRemarkPhotoBtn setImage:nil forState:UIControlStateNormal];
}

- (void)hiddenUIControl:(BOOL)hidden {
    
    self.timeLabel.hidden = hidden;
    self.timePointView.hidden = hidden;
    self.moneyLabel.hidden = hidden;
}

@end
