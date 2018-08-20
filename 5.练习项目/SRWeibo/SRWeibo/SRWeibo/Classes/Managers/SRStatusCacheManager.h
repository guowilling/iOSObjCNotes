//
//  SRStatusCacheTool.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRStatusCacheManager : NSObject

/**
 *  读取数据库的微博数据
 *
 *  @param params 参数
 *
 *  @return 微博字典数组
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储微博数据到数据库
 *
 *  @param statuses 微博字典数组
 */
+ (void)saveStatuses:(NSArray *)statuses;

@end
