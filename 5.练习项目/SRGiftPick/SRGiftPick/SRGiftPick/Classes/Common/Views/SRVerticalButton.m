//
//  SRVerticalButton.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//  

#import "SRVerticalButton.h"

@implementation SRVerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup {
    
    self.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    self.adjustsImageWhenHighlighted = NO;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.sr_width = self.sr_width * 0.5;
    self.imageView.sr_height = self.sr_width * 0.5;
    self.imageView.sr_centerX = self.sr_width * 0.5;
    self.imageView.sr_y = self.sr_height * 0.1;
    
    self.titleLabel.sr_height = self.sr_height - self.imageView.sr_height - self.titleEdgeInsets.top;
    self.titleLabel.sr_width  = self.sr_width;
    self.titleLabel.sr_x = 0;
    self.titleLabel.sr_y = self.imageView.sr_height + self.titleEdgeInsets.top;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
