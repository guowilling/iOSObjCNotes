
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import <YYText.h>
#import "TMDetailViewCell.h"
#import "ConstDefine.h"
#import "TMBill.h"
#import "TMCategory.h"

#define kDetailViewTimePointWidth          10
#define kDetailViewCategoryImageViewWidth  20
#define kDetailViewContainerViewHeight     75

@interface TMDetailViewCell()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView  *timePointView;

@property (nonatomic, strong) UIView      *containerCategoryImageAndLabelView;
@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UILabel     *categoryMoneyLabel;

@property (nonatomic, strong) UIImageView *pictureImageView;

@property (nonatomic, strong) UIView  *containerRemarkLabelView;
@property (nonatomic, strong) YYLabel *remarkLabel;

@property (nonatomic, strong) UIImageView *timiLogoImageView;

@end

@implementation TMDetailViewCell

#pragma mark - Lazy Load

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.text = @"31日";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = LineColor;
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textAlignment = NSTextAlignmentRight;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UIView *)timePointView {
    
    if (!_timePointView) {
        _timePointView = [UIView new];
        _timePointView.backgroundColor = LineColor;
        _timePointView.layer.cornerRadius = kDetailViewTimePointWidth/2;
        //_timePointView.layer.masksToBounds = YES;
    }
    return _timePointView;
}

- (UIView *)containerCategoryImageAndLabelView {
    
    if (!_containerCategoryImageAndLabelView) {
        _containerCategoryImageAndLabelView = [UIView new];
        _containerCategoryImageAndLabelView.backgroundColor = [UIColor whiteColor];
    }
    return _containerCategoryImageAndLabelView;
}

- (UIImageView *)categoryImageView {
    
    if (!_categoryImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"type_big_1006"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = kDetailViewCategoryImageViewWidth/2;
        //imageView.layer.masksToBounds = YES;
        _categoryImageView = imageView;
    }
    return _categoryImageView;
}

- (UILabel *)categoryMoneyLabel {
    
    if (!_categoryMoneyLabel) {
        UILabel* label = [[UILabel alloc] init];
        label.text = @"用餐 4558.00";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        _categoryMoneyLabel = label;
    }
    return _categoryMoneyLabel;
}

- (UIImageView *)pictureImageView {
    
    if (!_pictureImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.borderWidth = 1.0;
        imageView.layer.borderColor = [UIColor colorWithWhite:0.689 alpha:1.000].CGColor;
        _pictureImageView = imageView;
    }
    return _pictureImageView;
}

- (UIView *)containerRemarkLabelView {
    
    if (!_containerRemarkLabelView) {
        _containerRemarkLabelView = [UIView new];
        _containerRemarkLabelView.backgroundColor = [UIColor whiteColor];
    }
    return _containerRemarkLabelView;
}

- (YYLabel *)remarkLabel {
    
    if (!_remarkLabel) {
        _remarkLabel = [YYLabel new];
        _remarkLabel.backgroundColor = [UIColor whiteColor];
        _remarkLabel.textColor = [UIColor colorWithWhite:0.232 alpha:1.000];
        _remarkLabel.numberOfLines = 3;
    }
    return _remarkLabel;
}

- (UIImageView *)timiLogoImageView {
    
    if (!_timiLogoImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"launch_title"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _timiLogoImageView = imageView;
    }
    return _timiLogoImageView;
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.timePointView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.containerCategoryImageAndLabelView];
        [self.containerCategoryImageAndLabelView addSubview:self.categoryImageView];
        [self.containerCategoryImageAndLabelView addSubview:self.categoryMoneyLabel];
        [self.contentView addSubview:self.timiLogoImageView];
        [self.contentView addSubview:self.pictureImageView];
        [self.contentView addSubview:self.containerRemarkLabelView];
        
        WEAKSELF
        
        [self.lineView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(1.5, SCREEN_SIZE.height));
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView);
        }];
        
        [self.containerCategoryImageAndLabelView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, kDetailViewContainerViewHeight));
            make.center.equalTo(weakSelf.contentView).priorityLow();
        }];
        
        [self.categoryImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.centerX.equalTo(weakSelf.containerCategoryImageAndLabelView);
            make.top.equalTo(weakSelf.containerCategoryImageAndLabelView).offset(5).priorityLow();
        }];
        
        [self.categoryMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.containerCategoryImageAndLabelView).priorityLow();
            make.bottom.equalTo(weakSelf.containerCategoryImageAndLabelView).offset(-5);
        }];
        
        [self.timePointView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kDetailViewTimePointWidth, kDetailViewTimePointWidth));
            make.centerX.equalTo(weakSelf.contentView);
            make.centerY.equalTo(weakSelf.containerCategoryImageAndLabelView.top).offset(-15).priorityLow();
        }];
        
        [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.timePointView).priorityLow();
            make.right.equalTo(weakSelf.timePointView.left).offset(-10);
        }];
        
        [self.timiLogoImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(88, 16));
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.bottom.equalTo(weakSelf.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    self.detailBill = nil;
}

#pragma mark - Update Constraints

- (void)updateTimePointAndContainerViewConstraints {
    
    WEAKSELF
    
    [self.timePointView remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kDetailViewTimePointWidth, kDetailViewTimePointWidth));
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset(50);
    }];
    
    [self.containerCategoryImageAndLabelView remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, kDetailViewContainerViewHeight));
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.timePointView.bottom).offset(15);
    }];
}


- (void)updatePictureImageViewConstraintsWithHave:(BOOL)have {
    
    WEAKSELF

    if (have) {
        [self.pictureImageView remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@250);
            make.bottom.equalTo(weakSelf.contentView).offset(-150);
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.containerCategoryImageAndLabelView.bottom);
        }];
    } else {
        [self.pictureImageView remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    }
}

- (void)updateRemarkLabelConstraintsWithBottom:(BOOL)bottom {
    
    WEAKSELF
    if (bottom) {
        [self.remarkLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.pictureImageView.bottom);
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width - 50, 65));
            make.centerX.equalTo(weakSelf.contentView);
        }];
        [self.containerRemarkLabelView remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    } else {
        [self.containerRemarkLabelView remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_SIZE.width);
            make.top.equalTo(weakSelf.containerCategoryImageAndLabelView.bottom);
            make.bottom.equalTo(weakSelf).offset(-100);
        }];
        
        [self.remarkLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_SIZE.width);
            make.height.equalTo(@250);
            make.center.equalTo(weakSelf.containerRemarkLabelView);
        }];
    }
}

- (void)originTimePointAndContainerViewContraints {
    
    WEAKSELF
    
    [self.containerCategoryImageAndLabelView remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, kDetailViewContainerViewHeight));
        make.center.equalTo(weakSelf.contentView);
    }];
    
    [self.timePointView remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kDetailViewTimePointWidth, kDetailViewTimePointWidth));
        make.centerX.equalTo(weakSelf.contentView);
        make.centerY.equalTo(weakSelf.containerCategoryImageAndLabelView.top).offset(-15).priorityLow();
    }];
}


#pragma mark - Setter

- (void)setDetailBill:(TMBill *)detailBill {
    
    _detailBill = detailBill;
    
    [self.remarkLabel removeFromSuperview];
    
    NSRange range = NSMakeRange(8, 2);
    self.timeLabel.text = [NSString stringWithFormat:@"%@日",[detailBill.dateStr substringWithRange:range]];
    
    self.categoryImageView.image = detailBill.category.categoryImage;
    
    self.categoryMoneyLabel.text = [NSString stringWithFormat:@"%@ %.2f",detailBill.category.categoryTitle,detailBill.money.floatValue];
    
    if (_detailBill.remarkPhoto && _detailBill.reMarks.length > 0) {
        [self.contentView addSubview:self.remarkLabel];
        self.remarkLabel.numberOfLines = 2;
        self.remarkLabel.textAlignment = NSTextAlignmentCenter;
        [self updateTimePointAndContainerViewConstraints];
        [self updatePictureImageViewConstraintsWithHave:YES];
        [self updateRemarkLabelConstraintsWithBottom:YES];
        self.pictureImageView.image = [UIImage imageWithData:detailBill.remarkPhoto];
        self.remarkLabel.text = detailBill.reMarks;
        return;
        
    } else if (_detailBill.remarkPhoto) {
        self.pictureImageView.image = [UIImage imageWithData:detailBill.remarkPhoto];
        [self updateTimePointAndContainerViewConstraints];
        [self updatePictureImageViewConstraintsWithHave:YES];
        return;
        
    } else if (_detailBill.reMarks.length > 0) {
        [self.containerRemarkLabelView addSubview:self.remarkLabel];
        self.remarkLabel.textAlignment = NSTextAlignmentCenter; // No effects.
        self.remarkLabel.verticalForm = YES;
        self.remarkLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        [self updateTimePointAndContainerViewConstraints];
        [self updatePictureImageViewConstraintsWithHave:NO];
        [self updateRemarkLabelConstraintsWithBottom:NO];
        self.remarkLabel.text = detailBill.reMarks;
        return;
        
    } else {
        [self originTimePointAndContainerViewContraints];
        [self updatePictureImageViewConstraintsWithHave:NO];
        [self.containerRemarkLabelView remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    }
}

@end
