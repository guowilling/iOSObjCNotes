//
//  SRDropDownMenu.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRDropDownMenu.h"

@interface SRDropDownMenu ()

@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation SRDropDownMenu

- (UIImageView *)containerView {
    if (!_containerView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"popover_background"]; // 通过 Xcode 设置拉伸图片的垂直水平方向和中心
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _containerView = imageView;
    }
    return _containerView;
}

+ (instancetype)dropDownMenu {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
    return self;
}

- (void)setContentVC:(UIViewController *)contentVC {
    _contentVC = contentVC;
    
    contentVC.view.x = 10;
    contentVC.view.y = 15;
    self.containerView.width = contentVC.view.width + 20;
    self.containerView.height = contentVC.view.height + 25;
    [self.containerView addSubview:contentVC.view];
}

- (void)showFrom:(UIView *)fromView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    
    NSLog(@"fromView.frame: %@", NSStringFromCGRect(fromView.frame));
    CGRect newFrame = [fromView convertRect:fromView.bounds toView:keyWindow];
    //CGRect newFrame = [fromView.superview convertRect:fromView.frame toView:window];
    NSLog(@"newFrame.frame: %@", NSStringFromCGRect(newFrame));
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }
}

- (void)dismiss {
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
    
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
