//
//  ViewController.m
//  基本动画
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _layer                 = [CALayer layer];
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.bounds          = CGRectMake(0, 0, 100, 100);
    _layer.position        = self.view.center;
//    _layer.anchorPoint     = CGPointZero;
    [self.view.layer addSublayer:_layer];
    
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0 ];
//    rotationAnimation.duration = 3;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = MAXFLOAT;
//    [_layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotateAnimation.duration = 20.0;
    rotateAnimation.repeatCount = MAXFLOAT;
    [_layer addAnimation:rotateAnimation forKey:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [self basicAnimaPosition];
//    [self basicAnimaBounds];
//    [self basicAnimaTransform];
//    return;

    CABasicAnimation *anima = [CABasicAnimation animation];
    // 动画类型
//    anima.keyPath = @"transform.translation.x";
    //anima.keyPath = @"transform.scale.y";
    anima.keyPath = @"transform.rotation";
    
    // 动画执行完毕之后不删除动画
    anima.removedOnCompletion = NO;
    
    // 保存动画的最新状态
    anima.fillMode = kCAFillModeForwards;
    
    // 动画时间
    anima.duration = 1;
    
    // 修改动画
    //anima.toValue = @(100);
    //anima.toValue = @(2);
    anima.toValue = @(M_PI * 2);
    
    // 添加动画到Layer
    [self.layer addAnimation:anima forKey:nil];
}

- (void)basicAnimaTransform {
    
    CABasicAnimation *bAnima   = [CABasicAnimation animation] ;
    bAnima.keyPath             = @"transform";
    bAnima.removedOnCompletion = NO;
    bAnima.fillMode            = kCAFillModeForwards;
    bAnima.duration            = 1;
    bAnima.toValue             = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 0, 1)];
    [self.layer addAnimation:bAnima forKey:nil];
}

- (void)basicAnimaBounds {
    
    CABasicAnimation *bAnima   = [CABasicAnimation animation] ;
    bAnima.keyPath             = @"bounds";
    bAnima.removedOnCompletion = NO;
    bAnima.fillMode            = kCAFillModeForwards;
    bAnima.duration            = 1;
    bAnima.toValue             = [NSValue valueWithCGRect:CGRectMake(0, 0, 150, 150)];
    [self.layer addAnimation:bAnima forKey:nil];
}

- (void)basicAnimaPosition {

    CABasicAnimation *bAnima   = [CABasicAnimation animation];
    bAnima.keyPath             = @"position";
    bAnima.fromValue           = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    bAnima.toValue             = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    bAnima.duration            = 1;
    bAnima.removedOnCompletion = NO;
    bAnima.fillMode            = kCAFillModeForwards;
    [self.layer addAnimation:bAnima forKey:nil];
}

@end
