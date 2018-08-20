//
//  GPHotWordsCell.m
//  礼物说
//
//  Created by tripleCC on 15/1/25.
//  Copyright (c) 2014年 giftTalk All rights reserved.
//

#import "SRHotWordsCell.h"
#import "SRCornerButton.h"

@interface SRHotWordsCell()

@property (weak, nonatomic) SRCornerButton *titleButton;

@end

@implementation SRHotWordsCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
//        self.contentView.backgroundColor = SRRandomColor;
        
        SRCornerButton *button = [SRCornerButton buttonWithType:UIButtonTypeCustom];
        button.cornerRadius = 10;
        button.cornerColor = SRRGBColor(230, 230, 230);
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = SRHotWordsFont;
        button.userInteractionEnabled = NO; // Notice: 需要禁止按钮交互, 不然会拦截cell的点击.
        [self.contentView addSubview:button];
        self.titleButton = button;
//        self.titleButton.backgroundColor = SRRandomColor;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.titleButton.frame = self.contentView.bounds;
}

- (void)setTitle:(NSString *)title {
    
    _title = [title copy];
    
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}

@end
