//
//  RectView.m
//  基本图形
//
//  Created by 郭伟林 on 15/9/19.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "RectView.h"

@implementation RectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawTriangle];
    
    [self drawRect];
}

- (void)drawTriangle {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctr, 50, 50);
    CGContextAddLineToPoint(ctr, 50, 100);
    CGContextAddLineToPoint(ctr, 100, 50);
    CGContextClosePath(ctr);
    CGContextStrokePath(ctr);
}

- (void)drawRect {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctr, CGRectMake(100, 100, 100, 100));
    //[[UIColor blueColor] setStroke];
    //[[UIColor purpleColor] setFill];
    [[UIColor redColor] set];
    CGContextFillPath(ctr);
}

@end
