//
//  SRTextView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRPlaceholderTextView.h"

@implementation SRPlaceholderTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"请输入内容";
        self.placeholderColor = [UIColor grayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange {
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.hasText) {
        return;
    }
    // 每次调用这个方法会擦掉之前的内容
    // 画占位文字
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    CGFloat X = 5;
    CGFloat Y = 10;
    CGFloat W = rect.size.width  - 2 * X;
    CGFloat H = rect.size.height - 2 * Y;
    CGRect placeholderRect = CGRectMake(X, Y, W, H);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

@end
