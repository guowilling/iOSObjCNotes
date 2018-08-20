
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMCategoryDetailCell.h"
#import "ConstDefine.h"
#import "TMBill.h"
#import "TMCategory.h"
#import "NSString+TMNSString.h"

#define kSmallFont [UIFont systemFontOfSize:10.0f]

#define kPointViewWidth 5

@interface TMCategoryDetailCell()

@property (nonatomic, strong) UIView *vLineView;
@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) UIView *hLineView;

@property (nonatomic, strong) UILabel *categoryNameAndMoneyLabel;

@property (nonatomic, strong) UILabel *dayNumberLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *yearAndMonthLabel;

@property (nonatomic, strong) UILabel *remarkLabel;

@end

@implementation TMCategoryDetailCell

- (UIView *)vLineView {
    
    if (!_vLineView) {
        _vLineView = [UIView new];
        _vLineView.backgroundColor = LineColor;
    }
    return _vLineView;
}

- (UIView *)pointView {
    
    if (!_pointView) {
        _pointView = [UIView new];
        _pointView.backgroundColor = LineColor;
        _pointView.layer.cornerRadius = kPointViewWidth/2;
    }
    return _pointView;
}

- (UIView *)hLineView {
    
    if (!_hLineView) {
        _hLineView = [UIView new];
        _hLineView.backgroundColor = LineColor;
    }
    return _hLineView;
}

- (UILabel *)categoryNameAndMoneyLabel {
    
    if (!_categoryNameAndMoneyLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:22.0f];
        _categoryNameAndMoneyLabel = label;
    }
    return _categoryNameAndMoneyLabel;
}

- (UILabel *)dayLabel {
    
    if (!_dayLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = kSmallFont;
        label.text = @"日";
        _dayLabel = label;
    }
    return _dayLabel;
}

- (UILabel *)yearAndMonthLabel {
    
    if (!_yearAndMonthLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = kSmallFont;
        _yearAndMonthLabel = label;
    }
    return _yearAndMonthLabel;
}

- (UILabel *)dayNumberLabel {
    
    if (!_dayNumberLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:22.0f];
        _dayNumberLabel = label;
    }
    return _dayNumberLabel;
}

- (UILabel *)remarkLabel {
    
    if (!_remarkLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = kSmallFont;
        _remarkLabel = label;
    }
    return _remarkLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.vLineView];
        
        WEAKSELF
        
        [self.contentView addSubview:self.pointView];
        [self.pointView makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.contentView);
            make.size.equalTo(CGSizeMake(kPointViewWidth, kPointViewWidth));
        }];
        
        [self.contentView addSubview:self.hLineView];
        [self.hLineView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(5, 1));
            make.top.equalTo(weakSelf.contentView).offset(5);
            make.right.equalTo(weakSelf.vLineView.left);
        }];
        
        [self.contentView addSubview:self.categoryNameAndMoneyLabel];
        [self.categoryNameAndMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.vLineView.left).offset(10.5);
            make.height.equalTo(30);
            make.right.lessThanOrEqualTo(weakSelf.contentView);
            make.centerY.equalTo(weakSelf.contentView);
        }];
        
        [self.contentView addSubview:self.dayLabel];
        [self.dayLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.centerY);
            make.right.equalTo(weakSelf.vLineView.left).offset(-20);
        }];
        
        [self.contentView addSubview:self.yearAndMonthLabel];
        [self.yearAndMonthLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView);
            make.right.equalTo(weakSelf.hLineView.left).offset(-5);
            make.height.equalTo(12);
        }];
        
        [self.contentView addSubview:self.dayNumberLabel];
        [self.dayNumberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(weakSelf.categoryNameAndMoneyLabel);
            make.top.equalTo(weakSelf.yearAndMonthLabel.bottom);
            make.right.equalTo(weakSelf.dayLabel.left).offset(-5);
        }];
        
        [self.contentView addSubview:self.remarkLabel];
        [self.remarkLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.categoryNameAndMoneyLabel.bottom);
            make.left.equalTo(weakSelf.categoryNameAndMoneyLabel);
            make.right.lessThanOrEqualTo(weakSelf.contentView);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    WEAKSELF
    [self.vLineView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.size.equalTo(CGSizeMake(1, weakSelf.contentView.bounds.size.height));
    }];
}

- (void)setBill:(TMBill *)bill {
    
    _bill = bill;
    
    self.yearAndMonthLabel.text = [NSString conversionYearMonthWithDateStr:_bill.dateStr];
    
    self.dayNumberLabel.text = [NSString stringWithFormat:@"%li", [bill.dateStr substringFromIndex:8].integerValue];
    
    NSMutableAttributedString *categoryString = [[NSMutableAttributedString alloc] initWithString:bill.category.categoryTitle
                                                                                       attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20],
                                                                                                    NSForegroundColorAttributeName: [UIColor colorWithWhite:0.203 alpha:1.000]}];
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", bill.money.floatValue]
                                                                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20],
                                                                                                 NSForegroundColorAttributeName: [UIColor colorWithWhite:0.742 alpha:1.000]}];
    [categoryString appendAttributedString:moneyString];
    self.categoryNameAndMoneyLabel.attributedText = categoryString;
    
    self.remarkLabel.text = bill.reMarks;
    
    if (bill.isSame) {
        [self hiddenThreeUIView:YES];
    }
    if (bill.isPartSame) {
        [self hiddenYearLabel:YES];
    }
}

- (void)hiddenThreeUIView:(BOOL)hidden {
    
    self.yearAndMonthLabel.hidden = hidden;
    self.dayLabel.hidden = hidden;
    self.dayNumberLabel.hidden = hidden;
    self.hLineView.hidden = hidden;
}

- (void)hiddenYearLabel:(BOOL)hidden {
    
    self.yearAndMonthLabel.hidden = hidden;
    self.hLineView.hidden = hidden;
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.categoryNameAndMoneyLabel.text = nil;
    self.yearAndMonthLabel.text = nil;
    self.remarkLabel.text = nil;
    self.dayNumberLabel.text = nil;
}

@end
