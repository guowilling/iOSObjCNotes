//
//  NetWorkStatusTool.m
//  网络状态监测
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "NetWorkStatusTool.h"
#import "Reachability.h"

@implementation NetWorkStatusTool

+ (BOOL)isWIFI {
    
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

+ (BOOL)isMobileNetwork {
    
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

@end
