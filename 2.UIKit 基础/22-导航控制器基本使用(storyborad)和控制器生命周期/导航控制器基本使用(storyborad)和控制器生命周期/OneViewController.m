//
//  ViewController.m
//  导航控制器基本使用(storyborad)和控制器生命周期
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

// 加载View
- (void)loadView
{
    [super loadView];
    
    NSLog(@"%s",__func__);
}

// View已经加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%s",__func__);
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}

// View即将显示
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"%s",__func__);
}

// View已经显示
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"%s",__func__);
}

// View即将消失
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSLog(@"%s",__func__);
}

// View已经消失
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%s",__func__);
}

@end
