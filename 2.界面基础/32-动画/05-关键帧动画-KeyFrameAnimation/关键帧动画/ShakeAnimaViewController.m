//
//  IconShake.m
//  关键帧动画
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ShakeAnimaViewController.h"

// 弧度 = 度数 / 180 * M_PI
#define angle2Radian(angle) ((angle) / 180.0 * M_PI)

@interface ShakeAnimaViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *icon;

@end

@implementation ShakeAnimaViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    keyAnima.values = @[@(angle2Radian(2)), @(-angle2Radian(2)), @(angle2Radian(2))];
    keyAnima.removedOnCompletion = NO;
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.duration = 0.1;
    keyAnima.repeatCount = MAXFLOAT;
    [self.icon.layer addAnimation:keyAnima forKey:nil];
}

@end
