//
//  ViewController.m
//  按钮操作形变(代码)
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, kMovingDir) {
    kMovingDirTop = 1,
    kMovingDirLeft,
    kMovingDirBottom,
    kMovingDirRight,
};

#define kMovingDelta 20.0f

@interface ViewController ()

@property (nonatomic, strong) UIButton *iconButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    [iconButton setBackgroundImage:[UIImage imageNamed:@"mayday2.jpeg"] forState:UIControlStateNormal];
    [iconButton setBackgroundImage:[UIImage imageNamed:@"mayday1.jpeg"] forState:UIControlStateHighlighted];
    [iconButton setTitle:@"点我吧" forState:UIControlStateNormal];
    [iconButton setTitle:@"放手吧" forState:UIControlStateHighlighted];
    [iconButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [iconButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    iconButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.iconButton = iconButton;
    [self.view addSubview:iconButton];
}

- (IBAction)move:(UIButton *)sender {
    
    CGFloat dx = 0, dy = 0;
    if (sender.tag == kMovingDirTop || sender.tag == kMovingDirBottom) {
        dy = (sender.tag == kMovingDirTop) ? -kMovingDelta : kMovingDelta;
    }
    if (sender.tag == kMovingDirLeft || sender.tag == kMovingDirRight) {
        dx = (sender.tag == kMovingDirLeft) ? -kMovingDelta : kMovingDelta;
    }
    self.iconButton.transform = CGAffineTransformTranslate(self.iconButton.transform, dx, dy);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

- (IBAction)zoom:(UIButton *)sender {
    
    CGFloat dx = sender.tag ? 1.1:0.9;
    CGFloat dy = dx;
    self.iconButton.transform = CGAffineTransformScale(self.iconButton.transform, dx, dy);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

- (IBAction)rotate:(UIButton *)sender {
    
    // OC中角度统一使用弧度值, 逆时针是负值, 顺时针是正值.
    // 180° = M_PI
    CGFloat angle;
    angle = sender.tag ? -M_2_PI/2 : M_2_PI/2;
    self.iconButton.transform = CGAffineTransformRotate(self.iconButton.transform, angle);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

@end
