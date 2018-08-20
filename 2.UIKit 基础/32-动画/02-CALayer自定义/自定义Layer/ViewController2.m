//
//  ViewController2.m
//  自定义Layer
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController2.h"
#import "TestLayer.h"

@implementation ViewController2

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    TestLayer *myLayer      = [TestLayer layer];
    myLayer.bounds          = CGRectMake(0, 0, 100, 100);
    myLayer.anchorPoint     = CGPointZero;
    myLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:myLayer];
    [myLayer setNeedsDisplay];
    
    CALayer *layer        = [CALayer layer];
    layer.bounds          = CGRectMake(0, 0, 100, 100);
    layer.anchorPoint     = CGPointZero;
    layer.position        = CGPointMake(150, 0);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.delegate        = self;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextFillPath(ctx);
}

@end
