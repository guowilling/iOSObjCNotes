//
//  CircleView.m
//  基本图形
//
//  Created by 郭伟林 on 15/9/19.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    {
        // 圆形
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 50, 50));
        [[UIColor greenColor] set];
        CGContextFillPath(ctx);
    }
    
    {
        // 圆弧
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddArc(ctx, 100, 25, 25, -M_PI, 0, 0);
        [[UIColor blueColor] set];
        CGContextFillPath(ctx);
    }
    
    {
        // 扇形
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, 150, 0);
        CGContextAddLineToPoint(ctx, 150, 50);
        CGContextAddArc(ctx, 150, 50, 50, -M_PI_2, 0, 0);
        CGContextAddLineToPoint(ctx, 150, 50);
        CGContextStrokePath(ctx);
    }
    
    {
        // 圆形
        CGContextRef ctr = UIGraphicsGetCurrentContext();
        CGContextAddArc(ctr, 250, 25, 25, 0, M_PI * 2, 1);
        [[UIColor purpleColor] set];
        CGContextFillPath(ctr);
    }
}

@end
