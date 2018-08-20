//
//  SRTabBarController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/4.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTabBarController.h"
#import "SRGiftViewController.h"
#import "SRItemViewController.h"
#import "SRCategoryViewController.h"
#import "SRUserViewController.h"
#import "SRNavigationController.h"

@implementation SRTabBarController

+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    NSMutableDictionary *normalAttrs              = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName]              = [UIFont fontWithName:@"Courier" size:10];
    normalAttrs[NSForegroundColorAttributeName]   = [UIColor grayColor];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs            = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName]              = [UIFont fontWithName:@"Courier" size:10];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildController:[[SRGiftViewController alloc] init]
                         title:@"礼物说"
                         image:[UIImage imageNamed:@"gift"]
                 selectedImage:[UIImage imageNamed:@"gift-S"]];
    
    [self setupChildController:[[SRItemViewController alloc] init]
                         title:@"单品"
                         image:[UIImage imageNamed:@"item"]
                 selectedImage:[UIImage imageNamed:@"item-S"]];
    
    [self setupChildController:[[SRCategoryViewController alloc] init]
                         title:@"分类"
                         image:[UIImage imageNamed:@"category"]
                 selectedImage:[UIImage imageNamed:@"category-S"]];
    
    [self setupChildController:[[SRUserViewController alloc] init]
                         title:@"我"
                         image:[UIImage imageNamed:@"user"]
                 selectedImage:[UIImage imageNamed:@"user-S"]];
}

- (void)setupChildController:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    vc.navigationItem.title      = title;
    vc.tabBarItem.title          = title;
    vc.tabBarItem.image          = image;
    vc.tabBarItem.selectedImage  = selectedImage;
    SRNavigationController *navC = [[SRNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navC];
}

@end
