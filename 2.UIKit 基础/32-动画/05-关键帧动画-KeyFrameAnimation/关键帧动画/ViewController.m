//
//  ViewController.m
//  关键帧动画
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /**
    // Keyfram Animation
     CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
     keyAnima.keyPath = @"position";
     NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(50, 200)];
     NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
     NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
     NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(50, 400)];
     NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(50, 200)];
     keyAnima.values = @[v1, v2, v3, v4, v5];
     keyAnima.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     keyAnima.removedOnCompletion = NO;
     keyAnima.fillMode = kCAFillModeForwards;
     keyAnima.duration = 2;
     keyAnima.delegate = self;
     [self.imageView.layer addAnimation:keyAnima forKey:nil];
     */
    
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"position";
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 100, 100);
    CGPathAddLineToPoint(path, nil, 300, 100);
    keyAnima.path = path;
    CGPathRelease(path);
    keyAnima.removedOnCompletion = NO;
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.duration = 1;
    keyAnima.delegate = self;
    [self.imageView.layer addAnimation:keyAnima forKey:nil];
}

- (IBAction)removeAnimaBtnClick {
    
    [self.imageView.layer removeAllAnimations];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"%s", __func__);
}

@end
