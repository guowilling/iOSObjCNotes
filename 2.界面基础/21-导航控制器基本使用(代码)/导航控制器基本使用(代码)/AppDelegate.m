//
//  AppDelegate.m
//  导航控制器基本使用(代码)
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    OneViewController  *oneVC = [[OneViewController  alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:oneVC];
    // 创建导航控制器
    //UINavigationController *navC = [[UINavigationController alloc] init];
    // 创建其他控制器压入导航控制器栈顶
    //[navC pushViewController:[[OneViewController alloc] init] animated:YES];
    self.window.rootViewController = navC;
    [self.window makeKeyAndVisible];
    return YES;
    
    // 添加控制器到导航控制器
    // NJOneViewController *one = [[NJOneViewController alloc] init];
    // 第一种
    // [nav pushViewController:one animated:YES];
    // 第二种
    // [nav addChildViewController:one];
    // 第三种
    // nav.viewControllers = @[one];
    
//    nav.viewControllers == nav.childViewControllers
//    nav.topViewController
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    UINavigationController *navC =  (UINavigationController *)self.window.rootViewController;
    UINavigationBar *bar =  navC.navigationBar;
    NSLog(@"UINavigationBar.frame: %@", NSStringFromCGRect(bar.frame));
    NSString *strData = [self hierarchyForView:self.window];
    NSString *filePath = @"/Users/Guowilling/Desktop/ios6.xml";
    [strData writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)hierarchyForView:(UIView *)view {
    
    if ([view isKindOfClass:[UITableViewCell class]]) {
        return @"";
    }
    // 初始化xml
    NSMutableString *xml = [NSMutableString string];
    // xml开头
    [xml appendFormat:@"<%@ frame=\"%@\"", view.class, NSStringFromCGRect(view.frame)];
    if (!CGPointEqualToPoint(view.bounds.origin, CGPointZero)) {
        [xml appendFormat:@" bounds=\"%@\"", NSStringFromCGRect(view.bounds)];
    }
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)view;
        if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, scroll.contentInset)) {
            [xml appendFormat:@" contentInset=\"%@\"", NSStringFromUIEdgeInsets(scroll.contentInset)];
        }
    }
    // 是否结束
    if (view.subviews.count == 0) {
        [xml appendString:@" />"];
        return xml;
    } else {
        [xml appendString:@">"];
    }
    // 递归遍历子控件
    for (UIView *child in view.subviews) {
        NSString *childXml = [self hierarchyForView:child];
        [xml appendString:childXml];
    }
    // xml结尾
    [xml appendFormat:@"</%@>", view.class];
    return xml;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
