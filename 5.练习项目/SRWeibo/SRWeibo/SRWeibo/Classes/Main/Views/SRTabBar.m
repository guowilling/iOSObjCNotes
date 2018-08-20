//
//  SRTabBar.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTabBar.h"

@interface SRTabBar ()

@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation SRTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:({
            UIButton *plusBtn = [[UIButton alloc] init];
            [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
            [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
            [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
            [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
            [plusBtn setSize:plusBtn.currentBackgroundImage.size];
            [plusBtn addTarget:self action:@selector(plusBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:plusBtn];
            _plusBtn = plusBtn;
        })];
    }
    return self;
}

- (void)plusBtnAction {
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusBtn:)]) {
        [self.delegate tabBarDidClickPlusBtn:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    SRLog(@"%@", self.subviews);
    
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.x = index * tabBarButtonW;
            view.y = 0;
            view.width = tabBarButtonW;
            view.height = self.height;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

@end
