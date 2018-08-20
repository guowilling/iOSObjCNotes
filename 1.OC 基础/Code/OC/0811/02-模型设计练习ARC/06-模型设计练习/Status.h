/*
 作者：MJ
 描述：微博
 时间：
 文件名：Status.h
 */
#import <Foundation/Foundation.h>
#import "User.h"

// 微博内容、微博配图、发送时间、微博发送人、转发的微博、被评论数、被转发数

@interface Status : NSObject

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, assign) long time;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) Status *retweetStatus;

@property (nonatomic, assign) int commentsCount;
@property (nonatomic, assign) int retweetsCount;

@end
