//
//  xiaohuangren.m
//  绘制小黄人
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "XiaoHuangRen.h"

#define kTopX    rect.size.width * 0.5
#define kTopY    250
#define kRadius  100

@implementation XiaoHuangRen

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    [self drawBody:rect context:ctr];
    
    [self drawEyes:rect context:ctr];
    
    [self drawMouth:rect context:ctr];
}

- (void)drawBody:(CGRect)rect context:(CGContextRef)ctr {
    
    // 上半圆弧
    CGFloat topX = kTopX;
    CGFloat topY = kTopY;
    CGFloat topRadius = kRadius;
    CGContextAddArc(ctr, topX, topY, topRadius, -M_PI, 0, 0);
    // 右边直线
    CGFloat middX = topX + topRadius;
    CGFloat middY = topY + 120;
    CGContextAddLineToPoint(ctr, middX, middY);
    // 下半圆弧
    CGFloat bottomRadius = topRadius;
    CGFloat bottomX = topX;
    CGFloat bottomY = middY;
    CGContextAddArc(ctr, bottomX, bottomY, bottomRadius, 0, M_PI, 0);
    
    CGContextClosePath(ctr);
    
    [[UIColor colorWithRed:252/255.0 green:218/255.0 blue:0 alpha:1.0] set];
    
    CGContextFillPath(ctr);
}

- (void)drawEyes:(CGRect)rect context:(CGContextRef)ctr {
    
    CGFloat startX = kTopX - kRadius;
    CGFloat startY = kTopY;
    CGContextMoveToPoint(ctr, startX, startY);
    CGContextAddLineToPoint(ctr, kTopX + kRadius, kTopY);
    CGContextSetLineWidth(ctr, 10);
    [[UIColor blackColor] set];
    CGContextStrokePath(ctr);
    
    // 左眼睛
    CGFloat leftOutRadius = 30;
    CGFloat leftX = kTopX - leftOutRadius - 5;
    CGFloat leftY = kTopY;
    CGContextAddArc(ctr, leftX, leftY, leftOutRadius, 0, 2 * M_PI, 0);
    CGContextFillPath(ctr);
    CGFloat leftInRadius = 20;
    CGContextAddArc(ctr, leftX, leftY, leftInRadius, 0, 2 * M_PI, 0);
    [[UIColor whiteColor] set];
    CGContextFillPath(ctr);
    
    // 右眼睛
    CGFloat rightOutRadius = 30;
    CGFloat rightX = kTopX + rightOutRadius +5;
    CGFloat rightY = kTopY;
    CGContextAddArc(ctr, rightX, rightY, rightOutRadius, 0, 2 * M_PI, 0);
    [[UIColor blackColor] set];
    CGContextFillPath(ctr);
    CGFloat rightInRadius = 20;
    CGContextAddArc(ctr, rightX, rightY, rightInRadius, 0, 2 * M_PI, 0);
    [[UIColor whiteColor] set];
    CGContextFillPath(ctr);
}

- (void)drawMouth:(CGRect)rect context:(CGContextRef)ctr {
    
    // 贝塞尔曲线
    CGFloat controllerX = kTopX;
    CGFloat controllerY = rect.size.height * 0.5 - 10;
    CGFloat maginX = 40;
    CGFloat maginY = 20;
    CGFloat currentX =  controllerX - maginX;
    CGFloat currentY =  controllerY - maginY;
    CGContextMoveToPoint(ctr, currentX, currentY);
    CGFloat endX = controllerX + maginX;
    CGFloat endY = controllerY - maginY;
    CGContextAddQuadCurveToPoint(ctr, controllerX, controllerY, endX, endY);
    CGContextSetLineWidth(ctr, 1);
    [[UIColor blackColor] set];
    CGContextStrokePath(ctr);
}

@end
