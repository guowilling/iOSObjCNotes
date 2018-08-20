//
//  TestView.m
//  形变
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    // 设置形变必须在添加绘图信息之前
    
    // 因为添加绘图信息后图形就绘制到了图形上下文中
    
    // 渲染只是将图形上下文中的内容显示到View上
    
    CGContextRotateCTM(ctx, M_PI_4);
    CGContextScaleCTM(ctx, 0.5, 0.5);
    CGContextTranslateCTM(ctx, 150, -150);
    
    CGContextAddRect(ctx, CGRectMake(300, 300, 100, 100));
    [[UIColor blueColor] set];
    CGContextFillPath(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 200, 100, 100));
    [[UIColor redColor] set];
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
    CGContextMoveToPoint(ctx, 125, 50);
    CGContextAddLineToPoint(ctx, 125, 100);
    CGContextAddLineToPoint(ctx, 75, 100);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}

@end
