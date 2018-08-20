
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMActionSheetView.h"
#import "ConstDefine.h"

@interface TMActionSheetView()

@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) UIButton *albumBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TMActionSheetView

- (UIButton *)cameraBtn {
    
    if (!_cameraBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"拍照" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00]];
        [button addTarget:self action:@selector(clickCamerBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn = button;
    }
    return _cameraBtn;
}

- (UIButton *)albumBtn {
    
    if (!_albumBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"照片库" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00]];
        [button addTarget:self action:@selector(clickAlbumBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _albumBtn = button;
    }
    return _albumBtn;
}

- (UIButton *)cancelBtn {
    
    if (!_cancelBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.00]];
        [button addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = button;
    }
    return _cancelBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        [self addSubview:self.cameraBtn];
        [self.cameraBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width-50, 40));
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf).offset(10);
        }];
        
        [self addSubview:self.albumBtn];
        [self.albumBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf.cameraBtn);
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.cameraBtn.bottom).offset(10);
        }];
        
        [self addSubview:self.cancelBtn];
        [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width-50, 35));
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.albumBtn.bottom).offset(20);
        }];
    }
    return self;
}

- (void)clickCamerBtn:(UIButton *)sender {
    
    if (self.cameraBtnBlock) {
        self.cameraBtnBlock();
    }
}

- (void)clickAlbumBtn:(UIButton *)sender {
    
    if (self.albumBtnBlock) {
        self.albumBtnBlock();
    }
}

- (void)clickCancelBtn:(UIButton *)sender {
    
    if (self.cancelBtnBlock) {
        self.cancelBtnBlock();
    }
}

@end
