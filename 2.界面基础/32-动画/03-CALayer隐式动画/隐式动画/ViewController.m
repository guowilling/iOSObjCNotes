//
//  ViewController.m
//  隐式动画
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
    
    _layer = [CALayer layer];
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.bounds = CGRectMake(0, 0, 50, 50);
    _layer.anchorPoint = CGPointZero;
    _layer.position = CGPointMake(25, 25);
    [self.view.layer addSublayer:_layer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 关闭隐式动画
    //[CATransaction setDisableActions:YES];
    
    // CALayer 的某个属性是否支持隐式动画根据该属性描述最后是否有 Animatable
    [CATransaction begin];
    self.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer.bounds = CGRectMake(0, 0, 100, 100);
    self.layer.position = CGPointMake(250, 250);
    [CATransaction commit];
}

@end
