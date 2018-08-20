//
//  TwoViewController.m
//  导航控制器基本使用(代码)
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TwoViewController ()

- (IBAction)jump2Three;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.titleView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.titleView = [[UISwitch alloc] init];
    self.navigationItem.title = @"第二个控制器"; // 此时无效
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // 如果设置了leftBarButtonItem那么backBarButtonItem无效
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back)];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)jump2Three {
    
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    [self.navigationController pushViewController:threeVC animated:YES];
}

@end
