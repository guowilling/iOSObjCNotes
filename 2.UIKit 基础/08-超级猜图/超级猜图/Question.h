//
//  Question.h
//  超级猜图
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject

@property (nonatomic, copy) NSString  *answer;
@property (nonatomic, copy) NSString  *icon;
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, strong) NSArray *options;

@property (nonatomic, strong, readonly) UIImage *image;

+ (NSArray *)questions;

+ (instancetype)questionWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)randomOptions;

@end
