
#import "DetailHeadView.h"
#import "RecommendModel.h"

@interface DetailHeadView () {
    
    UIImageView *_headImageView;
}

@end

@implementation DetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        [self addSubview:_headImageView];
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(250, 200));
            make.center.equalTo(self);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHeadPortrait)];
        [_headImageView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setRecommendModel:(RecommendModel *)recommendModel {
    
    _recommendModel = recommendModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:recommendModel.image_hlarge]
                      placeholderImage:[UIImage imageNamed:@"detail_defultImage.png"]];
}

- (void)showHeadPortrait {
    
}

@end
