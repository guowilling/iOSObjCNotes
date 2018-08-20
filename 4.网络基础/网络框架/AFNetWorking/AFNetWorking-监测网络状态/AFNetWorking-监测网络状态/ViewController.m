//
//  ViewController.m
//  AFNetWorking-监测网络状态
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // Sets a callback to be executed when the network availability of the `baseURL` host changes.
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)dealloc {
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
