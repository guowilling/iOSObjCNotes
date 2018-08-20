//
//  ViewController.m
//  Application
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
    [btn setTitle:@"点我看看吧" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction {
    
    UIApplication *sharedApplication = [UIApplication sharedApplication];
    
    // 设置 IconBadge(ios8开始需要主动请求授权)
    //sharedApplication.applicationIconBadgeNumber = 998;
    
    // 设置状态栏的联网动画
    //sharedApplication.networkActivityIndicatorVisible = YES;
    
    // UIApplication 管理状态栏需要增加 Info.plist 设置 View controller-based status bar appearance
    // 设置状态栏的样式
    //sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    //[sharedApplication setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    // 设置状态栏是否隐藏
    //sharedApplication.statusBarHidden = YES;
    //[sharedApplication setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    // URL: 统一资源定位符用来唯一的表示一个资源
    // URL: 协议头://主机地址/资源路径
    // 网络资源: http://www.baidu.com/images/20140603/abc.png
    // 本地资源: file:///users/apple/desktop/abc.png
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com"];
    [sharedApplication openURL:URL];
}

@end
