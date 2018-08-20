//
//  SRTabBar.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTabBar.h"

@interface SRTabBar ()

@property (nonatomic, strong) UIButton *publishBtn;

@end

@implementation SRTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        UIButton *publishBtn = [[UIButton alloc] init];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishBtn.sr_size = publishBtn.currentBackgroundImage.size;
        [publishBtn addTarget:self action:@selector(publishBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    }
    return self;
}

- (void)publishBtnOnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:DidClickPublicBtn:)]) {
        [self.delegate tabBar:self DidClickPublicBtn:btn];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.publishBtn.sr_centerX = self.sr_width * 0.5;
    self.publishBtn.sr_centerY = self.sr_height * 0.5;
    CGFloat width = self.sr_width / 5;
    CGFloat index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.sr_width = width;
            view.sr_x = width * index;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

@end
