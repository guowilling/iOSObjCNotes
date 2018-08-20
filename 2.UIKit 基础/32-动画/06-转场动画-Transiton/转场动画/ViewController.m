//
//  ViewController.m
//  转场动画
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.index = 1;
}

- (IBAction)previousBtnClick {
    
    self.index--;
    if (self.index < 1) {
        self.index = 7;
    }
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"火影0%zd", self.index]];
    
    // 创建转场动画
    CATransition *transition = [CATransition animation];
    // 转场类型
    transition.type = @"cube";
    // 转场方向
    transition.subtype = kCATransitionFromLeft;
    // 动画时间
    transition.duration = 1;
    // 添加动画到layer
    [self.imageView.layer addAnimation:transition forKey:nil];
}

- (IBAction)nextBtnClick {
    
    self.index++;
    if (self.index > 7) {
        self.index = 1;
    }
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"火影0%zd", self.index]];
  
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1;
    [self.imageView.layer addAnimation:transition forKey:nil];
}

@end
