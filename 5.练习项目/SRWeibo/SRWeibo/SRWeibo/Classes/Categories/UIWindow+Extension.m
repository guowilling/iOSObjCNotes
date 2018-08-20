//
//  UIWindow+Extension.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "SRTabBarController.h"
#import "SRNewFeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController {
    NSString *bundelIDStringKey = @"CFBundleShortVersionString";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:bundelIDStringKey];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[bundelIDStringKey];
    if ([lastVersion isEqualToString:currentVersion]) {
        self.rootViewController = [[SRTabBarController alloc] init];
    } else {
        self.rootViewController = [[SRNewFeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:bundelIDStringKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
