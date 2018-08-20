//
//  LineView.m
//  基本图形
//
//  Created by 郭伟林 on 15/9/19.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctr, 100, 100);
    CGContextAddLineToPoint(ctr, 200, 200);
    [[UIColor blueColor] set];
    CGContextSetLineWidth(ctr, 5);
    CGContextSetLineCap(ctr, kCGLineCapRound);
    CGContextSetLineJoin(ctr, kCGLineJoinRound);
    CGContextStrokePath(ctr);
}

@end
