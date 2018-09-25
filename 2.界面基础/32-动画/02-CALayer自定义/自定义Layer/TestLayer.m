//
//  TestLayer.m
//  自定义Layer
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TestLayer.h"
#import <UIKit/UIKit.h>

@implementation TestLayer

// CALayer 的 drawInContext: 方法不会自动调用, 需要通过 setNeedDisplay 方法主动调用.
- (void)drawInContext:(CGContextRef)ctx {
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
    //[[UIColor redColor] set]; // 注意: 不能使用UIKit框架
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    CGContextFillPath(ctx);
}

@end
