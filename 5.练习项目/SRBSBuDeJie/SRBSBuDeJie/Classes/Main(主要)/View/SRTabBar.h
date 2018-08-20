//
//  SRTabBar.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRTabBar;

@protocol SRTabBarDelegate <UITabBarDelegate>

- (void)tabBar:(SRTabBar *)tabBar DidClickPublicBtn:(UIButton *)btn;

@end

@interface SRTabBar : UITabBar

@property (nonatomic, weak) id<SRTabBarDelegate> delegate;

@end
