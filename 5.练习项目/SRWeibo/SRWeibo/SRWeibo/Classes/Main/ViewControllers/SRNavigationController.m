//
//  SRNavigationController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRNavigationController.h"

@implementation SRNavigationController

+ (void)initialize {
    {
        // 设置 UINavigationBar 主题
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        NSMutableDictionary *NavBarAttrs = [NSMutableDictionary dictionary];
        NavBarAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
        NavBarAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        [navigationBar setTitleTextAttributes:NavBarAttrs];
    }
    
    {
        // 设置 UIBarButtonItem 主题
        UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
        NSDictionary *norAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName: [UIColor orangeColor]};
        [barButtonItem setTitleTextAttributes:norAttrs forState:UIControlStateNormal];
        
        NSDictionary *disAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName: [UIColor colorWithWhite:0.2 alpha:0.5]};
        [barButtonItem setTitleTextAttributes:disAttrs forState:UIControlStateDisabled];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self
                                                                                   action:@selector(popVC)
                                                                                 norImage:@"navigationbar_back"
                                                                                highImage:@"navigationbar_back_highlighted"];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)popVC {
    [self popViewControllerAnimated:YES];
}

@end
