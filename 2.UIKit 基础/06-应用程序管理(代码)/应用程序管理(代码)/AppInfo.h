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
/**
 * @property
 * 1.自动生成getter方法
 * 2.自动生成setter方法
 * 3.自动生成_xxx成员变量
 */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

/**
 * readonly: 如果重写了setter, 则不会自动生成成员变量
 */
@property (nonatomic, strong, readonly) UIImage *image;

+ (NSArray *)appInfos;

/**
 * instancetype: 类方法实例化对象时让编译器自动推断对象的实际类型, 避免使用id造成开发中不必要的麻烦
 * instancetype: 只能用于返回值类型使, 用不能当参数类型使用
 */
+ (instancetype)appInfoWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
