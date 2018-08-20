//
//  TestView.m
//  路径
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect {
    
    //[self drawRect];
    //return;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, NULL, 100, 100);
    CGPathAddLineToPoint(path1, NULL, 100, 200);
    CGContextAddPath(contextRef, path1);
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathAddEllipseInRect(path2, NULL, CGRectMake(75, 75, 50, 50));
    CGContextAddPath(contextRef, path2);
    CGContextStrokePath(contextRef);
    
    // Core Foundation 中带有 create/copy/retain 方法创建出来的东西必须手动释放
    CGPathRelease(path1);
    CGPathRelease(path2);
    //CFRelease(path1);
    //CFRelease(path2);
}

- (void)drawRectMethods {
    
    // 画四边形多种方式
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    // 第一种方式
    CGContextMoveToPoint(ctr, 50, 50);
    CGContextAddLineToPoint(ctr, 50, 100);
    CGContextAddLineToPoint(ctr, 100, 100);
    CGContextAddLineToPoint(ctr, 100, 50);
    CGContextClosePath(ctr);
    
    // 第二种方式
    CGContextAddRect(ctr, CGRectMake(100, 100, 50, 50));
    CGContextStrokePath(ctr);
    
    // 第三种方式
    CGContextFillRect(ctr, CGRectMake(150, 150, 50, 50));
    
    // 第四种方式: OC方法绘制实心四边形注意没有空心方法
    UIRectFill(CGRectMake(200, 200, 100, 100));
    
    // 第五种方式: 绘制线条设置宽度
    CGContextMoveToPoint(ctr, 150, 300);
    CGContextAddLineToPoint(ctr, 150, 400);
    CGContextSetLineWidth(ctr, 100);
    CGContextStrokePath(ctr);
}

@end
