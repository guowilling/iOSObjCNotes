//
//  MessageFrameModel.h
//  QQ聊天界面
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MessageModel;

#define kTextFont [UIFont systemFontOfSize:15]

@interface MessageFrameModel : NSObject

@property (nonatomic, strong) MessageModel *message;

@property (nonatomic, assign) CGRect timeF;
@property (nonatomic, assign) CGRect iconF;
@property (nonatomic, assign) CGRect textF;
@property (nonatomic, assign) CGFloat cellHeight;

+ (NSArray *)messageFrames;

@end
