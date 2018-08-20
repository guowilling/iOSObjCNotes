//
//  SRTabBar.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRTabBar;

@protocol SRTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidClickPlusBtn:(SRTabBar *)tabBar;

@end

@interface SRTabBar : UITabBar

@property (nonatomic, weak) id<SRTabBarDelegate> delegate;

@end
