//
//  AppModel.h
//  tableView动态cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign, getter=isDownloaded) BOOL downloaded;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)appModelWithDict:(NSDictionary *)dict;

+ (NSArray *)appModels;

@end
