//
//  ViewController.m
//  组动画
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 平移动画
    CABasicAnimation *basicAnima1 = [CABasicAnimation animation];
    basicAnima1.keyPath = @"transform.translation.y";
    basicAnima1.toValue = @(50);
    
    // 缩放动画
    CABasicAnimation *basicAnima2 = [CABasicAnimation animation];
    basicAnima2.keyPath = @"transform.scale";
    basicAnima2.toValue = @(1.5);
    
    // 旋转动画
    CABasicAnimation *basicAnima3 = [CABasicAnimation animation];
    basicAnima3.keyPath = @"transform.rotation";
    basicAnima3.byValue = @(M_PI * 2);
    
    // 组动画
    CAAnimationGroup *groupAnima =[CAAnimationGroup animation];
    groupAnima.animations = @[basicAnima1, basicAnima2, basicAnima3];
    groupAnima.duration = 2;
    groupAnima.removedOnCompletion = NO;
    groupAnima.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:groupAnima forKey:nil];
}

@end
