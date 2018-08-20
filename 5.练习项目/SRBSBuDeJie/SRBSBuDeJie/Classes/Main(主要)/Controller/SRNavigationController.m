//
//  SRNavigationController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRNavigationController.h"

@implementation SRNavigationController

+ (void)initialize {
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTintColor:[UIColor darkGrayColor]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        btn.backgroundColor = SRRandomColor;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    
    [self popViewControllerAnimated:YES];
}

@end
