
//
//  TwoViewController.m
//  导航控制器基本使用(storyborad)和控制器生命周期
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

- (IBAction)back:(id)sender;

@end

@implementation TwoViewController

- (void)loadView {
    
    [super loadView];
    
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSLog(@"%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    NSLog(@"%s",__func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    NSLog(@"%s",__func__);
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
