//
//  PaletteView.m
//  画画板
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//  贝塞尔曲线方式

#import "PaletteView.h"

@interface PaletteView ()

@property (nonatomic, strong) NSMutableArray  *paths;
@property (nonatomic, strong) UIBezierPath    *currentPath;

@end

@implementation PaletteView

- (NSMutableArray *)paths {
    
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineJoinRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = self.lineWidth;
    [path moveToPoint:startPoint];
    [self.paths addObject:path];
    self.currentPath = path;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    [self.currentPath addLineToPoint:movePoint];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self touchesMoved:touches withEvent:event];    
}

- (void)drawRect:(CGRect)rect {
    
    [self.color set];
    
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}

- (void)setColor:(UIColor *)color {
    
    _color = color;
    
    [self setNeedsDisplay];
}

- (void)clear {
    
    [self.paths removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)back {
    
    [self.paths removeLastObject];
    
    [self setNeedsDisplay];
}

/**
 // C 方式
 
 // 1.创建路径
 CGMutablePathRef path1 = CGPathCreateMutable();
 CGPathMoveToPoint(path1, NULL, 20, 20);
 CGPathAddLineToPoint(path1, NULL, 100, 100);
 CGMutablePathRef path2 = CGPathCreateMutable();
 CGPathMoveToPoint(path2, NULL, 120, 120);
 CGPathAddLineToPoint(path2, NULL, 200, 200);
 
 // 2.添加到上下文中
 CGContextRef ctx = UIGraphicsGetCurrentContext();
 CGContextAddPath(ctx, path1);
 CGContextAddPath(ctx, path2);
 
 // 3.渲染
 CGContextStrokePath(ctx);
 */

/**
 // OC 方式
 
 UIBezierPath == CGMutablePathRef
 
 // 1.创建路径
 UIBezierPath *path = [UIBezierPath bezierPath];
 
 // 2.设置路径起点和终点
 [path moveToPoint:CGPointMake(20, 20)];
 [path addLineToPoint:CGPointMake(100, 100)];
 
 // 3.设置路径属性
 [path setLineCapStyle:kCGLineCapRound];
 [path setLineWidth:10];
 [path setLineJoinStyle:kCGLineJoinRound];
 
 // 4.渲染路径
 [path stroke];
 */

@end
