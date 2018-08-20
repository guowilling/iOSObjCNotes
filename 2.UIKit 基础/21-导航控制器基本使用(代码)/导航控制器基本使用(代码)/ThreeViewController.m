//
//  ThreeViewController.m
//  导航控制器基本使用(代码)
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ThreeViewController.h"
#import "OneViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"第三个控制器";
    
    UIButton *redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    redBtn.bounds =  CGRectMake(0, 0, 46, 31);
    [redBtn setBackgroundImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *redBackBtnItem = [[UIBarButtonItem alloc] initWithCustomView:redBtn];
    self.navigationItem.leftBarButtonItem = redBackBtnItem;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back2Two:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back2root:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}

@end
