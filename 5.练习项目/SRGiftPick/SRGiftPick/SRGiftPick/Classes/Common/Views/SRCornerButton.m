//
//  SRButton.m
//  SR礼物说
//
//  Created by 郭伟林 on 15/10/2.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRCornerButton.h"

@implementation SRCornerButton

- (void)setCornerBackgroundColor:(UIColor *)cornerBackgroundColor {
    
    _cornerBackgroundColor = cornerBackgroundColor;
    
    [self setNeedsDisplay];
}

- (void)setCornerColor:(UIColor *)cornerBoarderColor {
    
    _cornerColor = cornerBoarderColor;
    
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerBoarderRadius {
    
    _cornerRadius = cornerBoarderRadius;
    
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (self.cornerBackgroundColor) {
        [self.cornerBackgroundColor set];
        [[self pathWithCornerRadius:self.cornerRadius] fill];
    }
    
    if (self.cornerRadius) {
        [self.cornerColor set];
        [[self pathWithCornerRadius:self.cornerRadius] stroke];
    }
}

- (UIBezierPath *)pathWithCornerRadius:(CGFloat)cornerRadius {
    
    CGFloat buttonW = self.sr_width;
    CGFloat buttonH = self.sr_height;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(cornerRadius, 1)];
    [path addLineToPoint:CGPointMake(buttonW - cornerRadius - 1, 1)];
    [path addArcWithCenter:CGPointMake(buttonW - cornerRadius  - 1, cornerRadius + 1) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(buttonW - 1, buttonH - cornerRadius - 1)];
    [path addArcWithCenter:CGPointMake(buttonW - cornerRadius  - 1, buttonH - cornerRadius  - 1) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(cornerRadius, buttonH - 1)];
    [path addArcWithCenter:CGPointMake(cornerRadius + 1, buttonH - cornerRadius  - 1) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [path addLineToPoint:CGPointMake(1, cornerRadius + 1)];
    [path addArcWithCenter:CGPointMake(cornerRadius + 1, cornerRadius + 1) radius:cornerRadius startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
    
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    return path;
}

@end
