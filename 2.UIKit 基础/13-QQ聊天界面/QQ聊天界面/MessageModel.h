//
//  MessageModel.h
//  QQ聊天界面
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kMessageModelType) {
    kMessageModelTypeMe = 0,
    kMessageModelTypeOther
};

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) kMessageModelType type;

// KVC自动转换NSNumber成枚举
@property (nonatomic, assign) BOOL hiddenTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageModelWithDict:(NSDictionary *)dict;

@end
