
#import "TranslucentNavBar.h"

@interface TranslucentNavBar () {
    
    UIButton *_backButton;
    UILabel  *_titleLabel;
    UILabel  *_subTitleLabel;
}

@end

@implementation TranslucentNavBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 20, 40, 44);
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backBntClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 20, 200, 20);
        [self addSubview:_titleLabel];
        _titleLabel.hidden = YES;
        
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:13.0];
        _subTitleLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 42, 200, 20);
        [self addSubview:_subTitleLabel];
        _subTitleLabel.hidden = YES;
    }
    return self;
}

- (void)setBarHidden:(BOOL)barHidden {
    
    _barHidden = barHidden;
    
    if (barHidden) {
        _titleLabel.hidden = YES;
        _subTitleLabel.hidden  = YES;
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow_white"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    } else {
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundColor = [AppTools colorWithHexString:@"f0f0f0"];
        }];
        _titleLabel.hidden = NO;
        _subTitleLabel.hidden = NO;
    }
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    _titleLabel.text = title;
}

- (void)setOrgTitle:(NSString *)orgTitle {
    
    _orgTitle = orgTitle;
    
    _subTitleLabel.text = orgTitle;
}

- (void)backBntClicked {
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
