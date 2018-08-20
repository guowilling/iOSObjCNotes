//
//  SRTabBarController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTabBarController.h"
#import "SRNavigationController.h"
#import "SRTabBar.h"
#import "SRHomeViewController.h"
#import "SRMessageViewController.h"
#import "SRDiscoverViewController.h"
#import "SRProfilesViewController.h"
#import "SRComposeViewController.h"

/**
 如果一个控件看不见有哪些可能:
 1.没有实例化这个控件
 2.没有添加到父控件
 3.没有设置尺寸
 4.alpha <= 0.01
 5.hidden = YES
 6.控件的颜色和父控件的背景色一样
 7.被其他控件挡住了
 8.位置不对
 9.父控件发生了以上情况
 
 特殊情况:
 * UIImageView 没有设置 image 属性或设置的图片名错误
 * UILabel 没有设置文字或文字颜色和父控件的背景色一样
 * UITextField 没有设置文字或没有设置边框样式 borderStyle
 * UIPageControl 没有设置总页数不会显示小圆点
 * UIButton 内部 imageView 和 titleLabel 的 frame 错误或 imageView 和 titleLabel 没有内容
 
 * 控件调试技巧:设置背景色和尺寸
 */

@interface SRTabBarController () <SRTabBarDelegate>

@end

@implementation SRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[SRHomeViewController alloc] init]
                           title:@"首页"
                           image:@"tabbar_home"
                   selectedImage:@"tabbar_home_selected"];
    
    [self addChildViewController:[[SRMessageViewController alloc] init]
                           title:@"消息"
                           image:@"tabbar_message_center"
                   selectedImage:@"tabbar_message_center_selected"];
    
    [self addChildViewController:[[SRDiscoverViewController alloc] init]
                           title:@"发现"
                           image:@"tabbar_discover"
                   selectedImage:@"tabbar_discover_selected"];
    
    [self addChildViewController:[[SRProfilesViewController alloc] init]
                           title:@"我"
                           image:@"tabbar_profile"
                   selectedImage:@"tabbar_profile_selected"];
    
    SRTabBar *tabBar = [[SRTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"]; // Notice: KVC 设置私有属性值, 并且需要在赋值之前设置代理
}

- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:selectedImage {
    //childController.tabBarItem.title = title;
    //childController.navigationItem.title = title;
    childVC.title = title; // 等同于上面两行代码
    
    // 设置 tabBarItem 的图片
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置 tabBarItem 的字体
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]} forState:UIControlStateSelected];
    
    SRNavigationController *navC = [[SRNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navC];
}

#pragma mark - SRTabBarDelegate

- (void)tabBarDidClickPlusBtn:(SRTabBar *)tabBar {
    SRComposeViewController *composeVC = [[SRComposeViewController alloc] init];
    SRNavigationController *navC = [[SRNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:navC animated:YES completion:nil];
}

@end
