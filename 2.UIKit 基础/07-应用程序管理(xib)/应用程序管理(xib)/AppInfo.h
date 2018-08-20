//
//  AppInfo.h
//  应用程序管理(代码)
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, strong, readonly) UIImage *image;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)appInfoWithDict:(NSDictionary *)dict;

+ (NSArray *)appInfos;

@end
