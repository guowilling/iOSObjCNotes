//
//  SRNavigationController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/4.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRNavigationController.h"

@implementation SRNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = SRRGBColor(245, 75, 75);
    
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    barAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:barAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backBtn = [[UIButton alloc] init];
        backBtn.adjustsImageWhenHighlighted = NO;
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [backBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    [self popViewControllerAnimated:YES];
}

@end
