//
//  SREmotionKeyboard.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionKeyboard.h"
#import "SREmotionTabBar.h"
#import "SREmotionListView.h"
#import "SREmotion.h"
#import "MJExtension.h"
#import "SREmotionManager.h"

@interface SREmotionKeyboard () <SREmotionTabBarDelegate>

@property (nonatomic, strong) SREmotionListView *recentListView;
@property (nonatomic, strong) SREmotionListView *defaultListView;
@property (nonatomic, strong) SREmotionListView *emojiListView;
@property (nonatomic, strong) SREmotionListView *lxhListView;

@property (nonatomic, weak  ) SREmotionTabBar   *emotionTabBar;
@property (nonatomic, weak  ) SREmotionListView *showingListView;

@end

@implementation SREmotionKeyboard

#pragma mark - Lazy Load

- (SREmotionListView *)recentListView {
    if (!_recentListView) {
        _recentListView = [[SREmotionListView alloc] init];
        _recentListView.emotions = [SREmotionManager recentEmotions];
    }
    return _recentListView;
}

- (SREmotionListView *)defaultListView {
    if (!_defaultListView) {
        _defaultListView = [[SREmotionListView alloc] init];
        _defaultListView.emotions = [SREmotionManager defaultEmotions];
    }
    return _defaultListView;
}

- (SREmotionListView *)emojiListView {
    if (!_emojiListView) {
        _emojiListView = [[SREmotionListView alloc] init];
        _emojiListView.emotions = [SREmotionManager emojiEmotions];
    }
    return _emojiListView;
}

- (SREmotionListView *)lxhListView {
    if (!_lxhListView) {
        _lxhListView = [[SREmotionListView alloc] init];
        _lxhListView.emotions = [SREmotionManager lxhEmotions];
    }
    return _lxhListView;
}

+ (instancetype)enmotionKeyboard {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        SREmotionTabBar *emotionTabBar = [[SREmotionTabBar alloc] init];
        emotionTabBar.delegate = self;
        self.emotionTabBar = emotionTabBar;
        [self addSubview:emotionTabBar];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emtionDidSelect) name:SREmotionBtnDidSelectNotification object:nil];
    }
    return self;
}

- (void)emtionDidSelect {
    NSMutableArray *arrayM = [SREmotionManager recentEmotions];
    if (arrayM.count > 20) {
        [arrayM removeLastObject];
    }
    self.recentListView.emotions = arrayM;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emotionTabBar.x = 0;
    self.emotionTabBar.y = self.height - self.emotionTabBar.height;
    self.emotionTabBar.width = self.width;
    self.emotionTabBar.height = 44;
    
    self.showingListView.x = 0;
    self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.height - 44;
}

#pragma mark - SREmotionTabBarDelegate

- (void)emotionTabBar:(SREmotionTabBar *)emotionTabBar didClickBtn:(UIButton *)btn {
    [self.showingListView removeFromSuperview];
    switch (btn.tag) {
        case SREmotionTabBarButtonRencent:
            [self addSubview:self.recentListView];
            break;
            
        case SREmotionTabBarButtonDefault:
            [self addSubview:self.defaultListView];
            break;
            
        case SREmotionTabBarButtonEmoji:
            [self addSubview:self.emojiListView];
            break;
            
        case SREmotionTabBarButtonLxh:
            [self addSubview:self.lxhListView];
            break;
    }
    self.showingListView = [self.subviews lastObject];
    
    [self setNeedsLayout];
}

@end
