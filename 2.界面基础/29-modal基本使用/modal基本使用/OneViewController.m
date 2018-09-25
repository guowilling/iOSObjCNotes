//
//  ViewController.m
//  modal基本使用
//
//  Created by 郭伟林 on 15/9/19.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "OneViewController.h"
#import "TwoTableViewController.h"

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpWithModal {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[TwoTableViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
