//
//  SREmotionTabBar.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionTabBar.h"
#import "SREmotionTabBarButton.h"

@interface SREmotionTabBar ()

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation SREmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createBtnWithTitle:@"最近" btnType:SREmotionTabBarButtonRencent];
        [self createBtnWithTitle:@"默认" btnType:SREmotionTabBarButtonDefault];
        [self createBtnWithTitle:@"emoji" btnType:SREmotionTabBarButtonEmoji];
        [self createBtnWithTitle:@"浪小花" btnType:SREmotionTabBarButtonLxh];
    }
    return self;
}

- (void)createBtnWithTitle:(NSString *)title btnType:(SREmotionTabBarButtonType)type {
    SREmotionTabBarButton *btn = [[SREmotionTabBarButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = type;
    [self addSubview:btn];
    NSString *norImage = @"compose_emotion_table_mid_normal";
    NSString *selImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        norImage = @"compose_emotion_table_left_normal";
        selImage = @"compose_emotion_table_left_selected";
    }
    if (self.subviews.count == 4) {
        norImage = @"compose_emotion_table_right_normal";
        selImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selImage] forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([title isEqualToString:@"默认"]) { // Notice: 此时代理还没有设置不会调用代理方法
//        [self btnClick:btn];
//    }
}

- (void)btnClick:(SREmotionTabBarButton *)btn {
    self.selectedBtn.enabled = YES;
    self.selectedBtn = btn;
    self.selectedBtn.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didClickBtn:)]) {
        [self.delegate emotionTabBar:self didClickBtn:btn];
    }
}

- (void)setDelegate:(id<SREmotionTabBarDelegate>)delegate {
    _delegate = delegate;
    
    [self btnClick:(SREmotionTabBarButton *)[self viewWithTag:SREmotionTabBarButtonDefault]]; // 设置代理的时候显示默认表情
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = w;
        btn.height = h;
        btn.x = w * i;
        btn.y = 0;
    }
}

@end
