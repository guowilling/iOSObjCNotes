//
//  CircleView.m
//  刷帧
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        _radius = 50;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctr, 150, 150, self.radius, 0, M_PI * 2, 0);
    [[UIColor blueColor] set];
    CGContextFillPath(ctr);
}

- (void)setRadius:(CGFloat)radius {
    
    _radius = radius;
    
    [self setNeedsDisplay];
}

@end
