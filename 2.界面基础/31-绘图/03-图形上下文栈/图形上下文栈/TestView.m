//
//  TestView.m
//  图形上下文栈
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    // 第一条线
    CGContextMoveToPoint(ctx, 150, 120);
    CGContextAddLineToPoint(ctx, 150, 220);
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    [[UIColor redColor] set];
    CGContextStrokePath(ctx);
    
    // 第二条线
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
    CGContextMoveToPoint(ctx, 200, 150);
    CGContextAddLineToPoint(ctx, 200, 300);
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor greenColor] set];
    CGContextStrokePath(ctx);
    
    // 第三线
    CGContextRestoreGState(ctx);
    CGContextMoveToPoint(ctx, 255, 200);
    CGContextAddLineToPoint(ctx, 255, 400);
    CGContextStrokePath(ctx);
}

@end
