
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMCreateHeaderView.h"
#import "ConstDefine.h"

@interface TMCreateHeaderView()

@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UIButton *categoryNameBtn;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) CAShapeLayer *bgColorlayer;
@property (nonatomic, strong) UIColor *previousSelectColor;

@end

@implementation TMCreateHeaderView

- (void)dealloc {
    
    [self.bgColorlayer removeAllAnimations];
    [self.moneyLabel.layer removeAllAnimations];
}

#pragma mark - Lazy Load

- (UIImageView *)categoryImageView {
    
    if (!_categoryImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"type_big_2"];
        _categoryImageView = imageView;
    }
    return _categoryImageView;
}

- (UIButton *)categoryNameBtn {
    
    if (!_categoryNameBtn) {
        _categoryNameBtn = [UIButton new];
        [_categoryNameBtn addTarget:self action:@selector(clickCategoryNameBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_categoryNameBtn setTintColor:[UIColor whiteColor]];
        _categoryNameBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_categoryNameBtn setTitle:@"用餐" forState:UIControlStateNormal];
        [_categoryNameBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _categoryNameBtn;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:20.0f];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"¥ 0.00";
        _moneyLabel = label;
    }
    return _moneyLabel;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        [self addSubview:self.categoryImageView];
        [self.categoryImageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(48.5, 48.5));
            make.centerY.equalTo(weakSelf);
            make.left.equalTo(weakSelf).offset(10);
        }];
        
        [self addSubview:self.categoryNameBtn];
        [self.categoryNameBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.categoryImageView.right).offset(10);
            make.centerY.equalTo(weakSelf);
        }];
        
        [self addSubview:self.moneyLabel];
        [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(-10);
        }];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.bounds.origin];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    self.bgColorlayer = layer;
}

#pragma mark - Action

- (void)clickCategoryNameBtn:(UIButton *)sender {
    
    if (self.clickCategoryName) {
        self.clickCategoryName();
    }
}

#pragma mark - Public Methods

- (void)categoryImageWithFileName:(NSString *)imageFileName andCategoryName:(NSString *)categoryName {
    
    [self.categoryImageView setImage:[UIImage imageNamed:imageFileName]];
    
    [self.categoryNameBtn setTitle:categoryName forState:UIControlStateNormal];
}

- (void)updateMoney:(NSString *)money {
    
    if (self.moneyLabel.text.length > 13) {
        if ([money isEqualToString:@"0.00"]) {
            self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",money];
        }
        return;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",money];
}

- (void)animationWithBgColor:(UIColor *)color {
    
    if ([color isEqual:self.previousSelectColor]) {
        return;
    }
    
    self.backgroundColor = self.previousSelectColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation.fromValue = @0.0;
    animation.toValue = @(self.bounds.size.width * 2);
    animation.duration = 0.3f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.bgColorlayer addAnimation:animation forKey:@"bgColorAnimation"];
    
    self.bgColorlayer.fillColor = color.CGColor;
    self.bgColorlayer.strokeColor = color.CGColor;
    self.previousSelectColor = color;
    
    [self bringSubviewToFront:self.categoryImageView];
    [self bringSubviewToFront:self.moneyLabel];
    [self bringSubviewToFront:self.categoryNameBtn];
}

@end
