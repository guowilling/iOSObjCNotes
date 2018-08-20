//
//  SRKeyboardToolBar.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRKeyboardToolBar.h"

@interface SRKeyboardToolBar ()

@property (nonatomic, strong) UIButton *emotionBtn;

@end

@implementation SRKeyboardToolBar

+ (instancetype)keyboardToolBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self createBtnWithNorImage:@"compose_camerabutton_background"
                          highImage:@"compose_camerabutton_background_highlighted"
                               type:SRKeyboardToolBarButtonTypeCamera];
        
        [self createBtnWithNorImage:@"compose_toolbar_picture"
                          highImage:@"compose_toolbar_picture_highlighted"
                               type:SRKeyboardToolBarButtonTypeAlbum];
        
        [self createBtnWithNorImage:@"compose_mentionbutton_background"
                          highImage:@"compose_mentionbutton_background_highlighted"
                               type:SRKeyboardToolBarButtonTypeMention];
        
        [self createBtnWithNorImage:@"compose_trendbutton_background"
                          highImage:@"compose_trendbutton_background_highlighted"
                               type:SRKeyboardToolBarButtonTypeTrend];
        
        [self createBtnWithNorImage:@"compose_emoticonbutton_background"
                          highImage:@"compose_emoticonbutton_background_highlighted"
                               type:SRKeyboardToolBarButtonTypeEmotion];
    }
    return self;
}

- (void)createBtnWithNorImage:(NSString *)norImage highImage:(NSString *)highImage type:(SRKeyboardToolBarButtonType)type {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = type;
    [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    if (type == SRKeyboardToolBarButtonTypeEmotion) {
        self.emotionBtn = btn;
    }
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(keyboardToolBar:didClickBtn:)]) {
        [self.delegate keyboardToolBar:self didClickBtn:btn.tag];
    }
}

- (void)showKeyboardBtn:(BOOL)show {
    NSString *norImage = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    if (show) {
        norImage = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionBtn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [self.emotionBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat x = w * i;
        CGFloat y = 0;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
