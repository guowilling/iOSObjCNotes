//
//  SRLikeCountButton.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/7.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRLikeCountButton.h"

@implementation SRLikeCountButton

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
    
    self.cornerRadius = self.sr_height * 0.5;
    self.cornerColor = [UIColor lightGrayColor];
    self.cornerBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
}

@end
