//
//  ViewController.m
//  应用程序管理(代码)
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"

#define kAppViewW 80
#define kAppViewH 90
#define kColCount 3
#define kStartY 70

@interface ViewController ()

@property (nonatomic, strong) NSArray *appInfos;

@end

@implementation ViewController

- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [AppInfo appInfos];
    }
    return _appInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 九宫格
    CGFloat marginX = (self.view.bounds.size.width - 3 * 80) / 4;
    CGFloat marginY = 10;
    for (int i = 0; i < self.appInfos.count; i++) {
        int row = i / 3;
        int col = i % 3;
        CGFloat x = marginX + col * (marginX + kAppViewW);
        CGFloat y = kStartY + marginY + row * (marginY + kAppViewH);
       
        UIView *appView = [[UIView alloc] init];
        appView.frame = CGRectMake(x, y, kAppViewW, kAppViewH);
        [self.view addSubview:appView];
        
        AppInfo * appInfo = self.appInfos[i];
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(0, 0, kAppViewW, 50);
        iconView.image = [UIImage imageNamed:appInfo.icon];
        iconView.image = appInfo.image;
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        [appView addSubview:iconView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 50, kAppViewW, 20);
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = appInfo.name;
        [appView addSubview:label];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 70, kAppViewW, 20);
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        //button.titleLabel.text = @"xxx"; // 不要使用此种方式修改按钮标题 因为按钮不同的状态对应不同的标题
        [button setTitle:@"下载" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [appView addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)btn {
    AppInfo *appInfo = self.appInfos[btn.tag];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lable.center = CGPointMake(self.view.center.x, 400);
    [self.view addSubview:lable];
    
    lable.text = appInfo.name;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    lable.alpha = 0.0;
    btn.enabled =NO;
    [UIView animateWithDuration:1.0 animations:^{
        lable.alpha = 1.0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            lable.alpha = 0.0;
        }completion:^(BOOL finished) {
            [lable removeFromSuperview];
        }];
    }];
    
    // 首尾式动画，不容易监听动画完成时间，不容易实现动画嵌套
    // [UIView beginAnimations:nil context:nil];
    // [UIView setAnimationDuration:1.0];
    // label.alpha = 1.0;
    // [UIView commitAnimations];
}

@end
