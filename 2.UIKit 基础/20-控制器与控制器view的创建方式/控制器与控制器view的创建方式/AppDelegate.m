//
//  AppDelegate.m
//  控制器与控制器view的创建方式
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // return YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 控制器view的创建原则:
    // 1.如果没有指定xib系统查找OneView.xib
    // 2.如果没有OneView系统再查找OneViewController.xib
    // 3.如果都没有系统默认创建一个空白view作为控制器的view
    //OneViewController *oneVc = [[OneViewController alloc] initWithNibName:@"OneViewController" bundle:nil];
    //OneViewController *oneVc = [[OneViewController alloc] init];
    //self.window.rootViewController = oneVc;

    // 控制器的创建方式
    //storyboard
//    [self  viewControllerFromStoryboard];
    //代码
//    [self viewControllerFromCode];
    //xib
    [self viewControllerFromXib];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)viewControllerFromStoryboard {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"other" bundle:nil];
    // storyboard中的初始控制器(箭头所指的控制器)
    //UIViewController *vc = [storyboard instantiateInitialViewController];
    // storyborad中的指定控制器
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    self.window.rootViewController = vc;
}

- (void)viewControllerFromCode {
    
    OneViewController *vc = [[OneViewController alloc] init];
    self.window.rootViewController = vc;
}

-(void)viewControllerFromXib {
    
    ThreeViewController *vc = [[ThreeViewController alloc] initWithNibName:@"ThreeViewController" bundle:nil];
    self.window.rootViewController = vc;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
