//
//  OneViewController.m
//  导航控制器基本使用(代码)
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

- (IBAction)jump2Two:(id)sender;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 当前控制器的导航条 self.navigationItem 不是 self.navigationController.navigationItem
    // 导航条的标题
    self.navigationItem.title = @"第一个控制器";
    // leftBarButtonIt
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    // rightBarButtonItem
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:nil action:nil];
    UIBarButtonItem *item0 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:nil action:nil];
    UIBarButtonItem *item1 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[item0, item1];
    
    // 当前控制器的 backBarButtonItem 决定下一个控制器的返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (IBAction)jump2Two:(id)sender {
    
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    // 当前控制器所在的导航控制器 self.navigationController
    [self.navigationController pushViewController:twoVC animated:YES];
}

@end
