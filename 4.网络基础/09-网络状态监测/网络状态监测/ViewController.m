//
//  ViewController.m
//  网络状态监测
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "NetWorkStatusTool.h"

@interface ViewController ()

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation ViewController

- (void)dealloc {
    
    [self.reachability stopNotifier];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (Reachability *)reachability {
    
    if (!_reachability) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    return _reachability;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkStateDidChange)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [self.reachability startNotifier];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self checkNetworkState];
}

- (void)networkStateDidChange {
    
    NSLog(@"网络状态发生了改变");
    
    [self checkNetworkState];
}

- (void)checkNetworkState {
    
    if ([NetWorkStatusTool isWIFI]) {
        NSLog(@"WIFI");
    } else if ([NetWorkStatusTool isMobileNetwork]) {
        NSLog(@"移动网络");
    } else {
        NSLog(@"无网络");
    }
}

@end
