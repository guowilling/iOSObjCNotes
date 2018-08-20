//
//  SRTabBarController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTabBarController.h"
#import "SREssenceViewController.h"
#import "SRNewViewController.h"
#import "SRPublishViewController.h"
#import "SRFriendTrendsViewController.h"
#import "SRMeViewController.h"
#import "SRNavigationController.h"
#import "SRTabBar.h"

@interface SRTabBarController () <SRTabBarDelegate>

@end

@implementation SRTabBarController

+ (void)initialize {
    
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *highAttrs = [NSMutableDictionary dictionary];
    highAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [tabBarItem setTitleTextAttributes:highAttrs forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    
    [self setupTabBar];
}

- (void)setupChildViewControllers {
    
    [self setupChildVC:[[SREssenceViewController alloc] init]
                 title:@"精华"
                 image:@"tabBar_essence_icon"
         selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVC:[[SRNewViewController alloc] init]
                 title:@"新帖"
                 image:@"tabBar_new_icon"
         selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVC:[[SRFriendTrendsViewController alloc] init]
                 title:@"关注"
                 image:@"tabBar_friendTrends_icon"
         selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVC:[[SRMeViewController alloc] init]
                 title:@"我"
                 image:@"tabBar_me_icon"
         selectedImage:@"tabBar_me_click_icon"];
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SRNavigationController *nav = [[SRNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)setupTabBar {
    
    SRTabBar *tabBar = [[SRTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - SRTabBarDelegate

- (void)tabBar:(SRTabBar *)tabBar DidClickPublicBtn:(UIButton *)btn {
    
    SRPublishViewController *publishVC = [[SRPublishViewController alloc] init];
    [self presentViewController:publishVC animated:NO completion:nil];
}

@end
