//
//  ViewController.m
//  UIView动画
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self animationWithUIView];
    
    //[self animationWithBasicAnimation];
    
    //[self animationWithUIViewBlock];
    
    [self transitionWithView];
}

#pragma mark - Transition With View

- (void)transitionWithView {
    
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{ // UIViewAnimationOptions
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight // UIViewAnimationTransition
                               forView:self.imageView
                                 cache:YES];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Animation With UIView Block

- (void)animationWithUIViewBlock {
    
    [UIView animateWithDuration:2.0 animations:^{
        NSLog(@"UIView 动画执行之前: %@", NSStringFromCGPoint(self.imageView.center));
        self.imageView.center = CGPointMake(187, 500);
        self.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        NSLog(@"UIView 动画执行之后`: %@", NSStringFromCGPoint(self.imageView.center));
    }];
}

#pragma mark - Animation With Basic Animation

- (void)animationWithBasicAnimation {
    
    // 通过 CABasicAnimation 改变 layer 的位置表面上改变了实质上没有变
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"position";
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(187, 500)];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    anima.duration = 2;
    anima.delegate = self;
    [self.imageView.layer addAnimation:anima forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"CA 核心动画执行之前: %@", NSStringFromCGPoint(self.imageView.layer.position));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"CA 核心动画执行之后: %@", NSStringFromCGPoint(self.imageView.layer.position));
}

#pragma mark - Animation With UIView

- (void)animationWithUIView {
    
    // Note: 通过 UIView 执行的动画不会恢复.
    NSLog(@"UIView 动画执行之前 imageView center: %@", NSStringFromCGPoint(self.imageView.center));
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didStopAnimatino)];
    self.imageView.center = CGPointMake(187.5, 500);
    [UIView commitAnimations];
}

- (void)didStopAnimatino {
    
    NSLog(@"UIView 动画执行之后 imageView center: %@", NSStringFromCGPoint(self.imageView.center));
}

@end
