//
//  ViewController.m
//  自定义Layer
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

/**
 * CALayer和UIView都能实现相同的显示效果, 如何选择?
 * 如果显示出来的东西需要跟用户交互的话用UIView, 如果不需要跟用户交互用UIView或者CALayer都可以.
 */

/**
 * CALayer重要属性
 * position: CALayer在父层中的位置, 以父层的左上角为原点
 * anchorPoint: CALayer的哪个点在position所指的位置, 以自己的左上角为原点, 取值范围0~1, 默认值（0.5, 0.5）
 */

#import "ViewController1.h"

@implementation ViewController1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CALayer *layer1        = [[CALayer alloc] init];
    layer1.backgroundColor = [UIColor redColor].CGColor;
    layer1.bounds          = CGRectMake(0, 0, 100, 100);
    layer1.position        = CGPointMake(150, 200);
    layer1.anchorPoint     = CGPointMake(0, 0);
    layer1.borderWidth     = 10;
    layer1.cornerRadius    = 10;
    [self.view.layer addSublayer:layer1];
    
    CALayer *layer2        = [CALayer layer];
    layer2.backgroundColor = [UIColor blueColor].CGColor;
    layer2.bounds          = CGRectMake(0, 0, 100, 100);
    layer2.position        = CGPointMake(150, 400);
    layer2.anchorPoint     = CGPointMake(0, 0);
    layer2.borderWidth     = 5;
    layer2.cornerRadius    = 20;
    layer2.masksToBounds   = YES;
    layer2.contents        = (id)[UIImage imageNamed:@"火影05"].CGImage;
    [self.view.layer addSublayer:layer2];
}

@end
