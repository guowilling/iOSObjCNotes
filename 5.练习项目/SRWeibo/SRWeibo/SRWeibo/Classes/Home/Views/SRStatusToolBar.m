//
//  SRStatusToolBar.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusToolBar.h"
#import "SRStatus.h"

@interface SRStatusToolBar ()

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation SRStatusToolBar

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)dividers {
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)statusToolBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.repostBtn   = [self createBtnWithTitle:@"转发" iconName:@"timeline_icon_retweet"];
        self.commentBtn  = [self createBtnWithTitle:@"评论" iconName:@"timeline_icon_comment"];
        self.attitudeBtn = [self createBtnWithTitle:@"赞" iconName:@"timeline_icon_unlike"];
        [self createDivider];
        [self createDivider];
    }
    return self;
}

- (UIButton *)createBtnWithTitle:(NSString *)title iconName:(NSString *)iconName {
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [self.buttons addObject:btn];
    [self addSubview:btn];
    return btn;
}

- (void)createDivider {
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self.dividers addObject:divider];
    [self addSubview:divider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger btnCount = self.buttons.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.buttons[i];
        btn.x = btnW * i;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }

    NSInteger dividerCount = self.dividers.count;
    CGFloat dividerW = 1;
    CGFloat dividerH = self.height;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.x = (dividerW + btnW) * (i + 1);
        divider.y = 0;
        divider.width = dividerW;
        divider.height = dividerH;
    }
}

- (void)setStatus:(SRStatus *)status {
    _status = status;
    
    [self setBtnTitle:self.repostBtn title:@"转发" count:status.reposts_count];
    [self setBtnTitle:self.commentBtn title:@"评论" count:status.comments_count];
    [self setBtnTitle:self.attitudeBtn title:@"赞" count:status.attitudes_count];
}

- (void)setBtnTitle:(UIButton *)btn title:(NSString *)title count:(NSInteger)count {
    // status.reposts_count = 587456; // 58.7万
    // status.comments_count = 10011; // 1万
    // status.attitudes_count = 7853; // 7853
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%zd", count];
        } else {
            CGFloat wan = count / 10000;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
