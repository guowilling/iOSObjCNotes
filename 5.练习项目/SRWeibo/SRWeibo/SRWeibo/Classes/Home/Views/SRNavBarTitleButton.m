//
//  SRTitleButton.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRNavBarTitleButton.h"

@implementation SRNavBarTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

/**
 重写setFrame: 拦截设置按钮尺寸的过程, 系统设置完控件的尺寸后再修改.

 @param frame 不重写 titleView 显示的位置会错位, why?
 */
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    frame.size.width += 5;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 只调整按钮内部 titleLabel 和 imageView 的位置在 layoutSubviews 中设置即可
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];

    // 修改了文字让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    
    // 修改了图片让按钮重新计算自己的尺寸
    [self sizeToFit];
}

// 设置按钮内部 titleLable's frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return [super titleRectForContentRect:contentRect];
}

// 设置按钮内部 imageView's frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return [super imageRectForContentRect:contentRect];
}

@end
