//
//  TestView.m
//  自定义Layer
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctr, CGRectMake(0, 0, 100, 100));
    CGContextSetRGBFillColor(ctr, 1, 0, 0, 1);
    // 渲染显示: 内部调用 CALayer 对象的 - (void)drawInContext:(CGContextRef)ctx;
    CGContextFillPath(ctr);
}

@end
