//
//  NetWorkStatusTool.h
//  网络状态监测
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkStatusTool : NSObject

/**
 *  是否WIFI
 */
+ (BOOL)isWIFI;

/**
 *  是否3G
 */
+ (BOOL)isMobileNetwork;

@end
