//
//  SREmotionButton.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionButton.h"
#import "SREmotion.h"
#import "NSString+Emoji.h"

@implementation SREmotionButton

// 通过代码方式创建时调用
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// 通过 xib/storyboard 方式创建时调用
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

// initWithCoder: 方法之后调用
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setup {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setHighlighted:(BOOL)highlighted { }

- (void)setEmotion:(SREmotion *)emotion {
    _emotion = emotion;
    
    if (emotion.png) { // 图片表情
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else { // emoji表情
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

@end
