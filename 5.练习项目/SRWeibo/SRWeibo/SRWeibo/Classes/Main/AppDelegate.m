//
//  AppDelegate.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"
#import "SRTabBarController.h"
#import "SRNewFeatureViewController.h"
#import "SRAccount.h"
#import "SROAuthViewController.h"
#import "SDWebImageManager.h"
#import "UIWindow+Extension.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden = NO;
    
    [self setupUserNotificationSettings];
    
    [self setupWindow];

    [self setupAudioSession];

    return YES;
}

- (void)setupUserNotificationSettings {
    if (IS_iOS10) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"RequestAuthorizationWithOptions succeeded!");
                                  }
                              }];
    } else {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SRAccount *account = [SRAccountManager account];
    if (account) {
        [self.window switchRootViewController];
    } else {
        self.window.rootViewController = [[SROAuthViewController alloc] init];
    }
    [self.window makeKeyAndVisible];
}

- (void)setupAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];         // 音频会话
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];    // 后台播放
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil]; // 单独播放
    [session setActive:YES error:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSURL *mp3URL = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:nil];
    _player.numberOfLoops = -1;
    [_player prepareToPlay];
    [_player play];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 如何提高后台任务的优先级: 欺骗系统我们是后台播放程序, 但是系统会检测程序有没有播放音乐
    // 利用 MP3 在后台运行: 程序即将失去焦点的时候循环播放一个没有声音的 MP3 文件
    // Info.plst 中设置后台模式:
    // Required background modes == App plays audio or streams audio/video using AirPlay
    // 开启一个后台任务, 优先级低, 维持时间不确定
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cancelAll];
    [manager.imageCache clearMemory];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    SRLog(@"userNotificationCenter willPresentNotification");
    SRLog(@"notification: %@", notification);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    SRLog(@"userNotificationCenter didReceiveNotificationResponse");
    SRLog(@"response: %@", response);
}

@end
