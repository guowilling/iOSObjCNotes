//
//  ViewController.m
//  CALayer基本使用
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView       *customView;
@property (weak, nonatomic) IBOutlet UIImageView  *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.customView.layer.borderWidth = 10;
    self.customView.layer.borderColor = [UIColor blackColor].CGColor;
    self.customView.layer.cornerRadius = 10;
    //self.customView.clipsToBounds = YES;
    //self.customView.layer.masksToBounds = YES;
    
    // image显示在子图层
    self.customView.layer.contents = (id)[UIImage imageNamed:@"火影03"].CGImage;
    // 阴影颜色(如果设置了剪切阴影无效果)
    self.customView.layer.shadowColor = [UIColor purpleColor].CGColor;
    // 阴影偏移位: 正数阴影在右下边
    self.customView.layer.shadowOffset = CGSizeMake(10, 10);
    // 阴影透明度: 1完全不透明; 0完全透明
    self.customView.layer.shadowOpacity = 1;
    
    self.iconView.layer.borderWidth = 10;
    self.iconView.layer.borderColor = [UIColor purpleColor].CGColor;
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.bounds = CGRectMake(0, 0, 200, 200);
    self.iconView.layer.position = CGPointMake(210 , 600);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 位移
    self.iconView.transform = CGAffineTransformMakeTranslation(0, -100);
//    self.iconView.layer.transform = CATransform3DMakeTranslation(0, -100, 0);
//    [self.iconView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -200, 0)] forKeyPath:@"transform"];
//    [self.iconView.layer setValue:@(-100) forKeyPath:@"transform.translation.x"];
    
    // 旋转
//    self.iconView.transform = CGAffineTransformMakeRotation(M_PI_4);
//    self.iconView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
//    [self.iconView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation.z"];
    
    // 缩放
//    self.iconView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    self.iconView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0);
//    [self.iconView.layer setValue:@(0.5) forKeyPath:@"transform.scale.x"];
//    [self.iconView.layer setValue:@(0.5) forKeyPath:@"transform.scale.y"];
//    [self.iconView.layer setValue:@(0.5) forKeyPath:@"transform.scale"];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.iconView.layer.transform = CATransform3DIdentity;
}

@end
