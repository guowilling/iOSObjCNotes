
#import "RecommendHeadView.h"

@implementation RecommendHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KBackgroundColor;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UILabel *currentL = [[UILabel alloc] init];
    currentL.text = @"当前城市:";
    currentL.backgroundColor = [UIColor clearColor];
    currentL.font = [UIFont systemFontOfSize:16.f];
    currentL.textColor = [UIColor lightGrayColor];
    [backView addSubview:currentL];
    
    _currentCityLabel = [[UILabel alloc] init];
    _currentCityLabel.text = @"北京";
    _currentCityLabel.backgroundColor = [UIColor clearColor];
    _currentCityLabel.font = [UIFont systemFontOfSize:16.f];
    _currentCityLabel.textColor = TheThemeColor;
    [backView addSubview:_currentCityLabel];
    
    int padding = 15;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.width.equalTo(self);
        make.top.equalTo(self).offset(padding);
        make.height.mas_equalTo(@40);
    }];
    
    [currentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(padding);
        make.top.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [_currentCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentL.mas_right);
        make.top.equalTo(currentL.mas_top);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
}

- (void)tapAction {
    
    if ([_delegate respondsToSelector:@selector(recommendHeadViewTapAction)]) {
        [_delegate recommendHeadViewTapAction];
    }
}

@end
