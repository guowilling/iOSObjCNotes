//
//  AppInfoView.h
//  应用程序管理(xib)
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"
@class AppInfoView;

// 协议名: 类名+Delegate
@protocol AppInfoViewDelegate <NSObject>

// 协议方法名称: 类名开始并且第一个参数一般是本身
- (void)appInfoViewDidClickDownloadButton:(AppInfoView *)appInfoView;

@end

@interface AppInfoView : UIView

@property (nonatomic, strong) AppInfo *appInfo;

+ (instancetype)appInfoView;
+ (instancetype)appInfoViewWithAppInfo:(AppInfo *)appInfo;

@property (nonatomic, weak) id<AppInfoViewDelegate> delegate;

@end
